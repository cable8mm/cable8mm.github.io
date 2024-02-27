---
layout: single
title: "라라벨 7의 새로운 기능, HTTP 클라이언트"
date: 2020-03-23 16:56:00
categories: development
tags: 라라벨 개발
author: Samgu Lee
header:
  og_image: /assets/images/laravel7.png
---

라라벨 HTTP 클라이언트는 Guzzle HTTP 클라이언트를 기반으로 하되 자주 쓰는 기능만 추리고, 더 사용하기 편하게 만든 도구입니다. 주로 외부 애플리케이션에 HTTP 요청을 보낼 때 사용합니다.

![라라벨 7]({{ page.header.og_image }})

Guzzle HTTP 클라이언트에 의존하기 때문에 컴포저로 애플리케이션에 Guzzle HTTP 클라이언트를 설치해야 사용할 수 있습니다.

저 처럼 어차피 외부에 요청을 보내기 위해 Guzzle을 설치해서 썼던 사람이라면 왠만한 건 라라벨 HTTP 클라이언트로 처리하고 복잡한 기능이 필요하면 Guzzle을 사용하는 식으로 활용하면 될 것 같습니다. Guzzle이 아닌 다른 HTTP 클라이언트를 사용하고 있었다면 기존에 쓰던 것을 유지할 지 갈아탈 지 한 번쯤 검토해보는 것도 좋을 것 같네요.

## Guzzle과 간단한 비교

사용법은 공식 문서에 잘 안내되어 있으니 따로 설명할 필요는 없을 것 같습니다. 써볼까? 싶은 분들은 꼭 공식 문서를 한 번 읽어보시길 권해드려요. 이 글에서는 기존에 사용하던 도구인 Guzzle에 비해 얼마나 편해졌는지를 위주로 정리해보도록 하겠습니다.

### 퍼사드

```php
// Guzzle
$client = new GuzzleHttp\Client();
$res = $client->get('https://laravel.com');


// 라라벨 HTTP
$response = Http::get('https://laravel.com');
```

퍼사드를 이용해서 인스턴스화 하는 단계를 줄일 수 있습니다. 별 것 아닙니다만. :)

### 데이터 접근

라라벨 HTTP 클라이언트의 get 메서드가 반환하는 Illuminate\Http\Client\Response는 ArrayAccess 인터페이스를 구현하고 있어서 JSON 응답 데이터에 접근하기가 Guzzle에 비해 편리합니다.

```php
// Guzzle
$client = new GuzzleHttp\Client();
$res = $client->get('http://test.com/users/1');
return $response->json()['name'];

// 라라벨 HTTP
return Http::get('http://test.com/users/1')['name'];
```

### 데이터 첨부

#### 폼

application/x-www-form-urlencoded 컨텐트 타입으로 데이터를 전송하고 싶은 경우, Guzzle은 ‘form_parmas’에 배열로 데이터를 담아 전송하면 되고, 라라벨 HTTP는 asForm() 메서드를 사용하면 됩니다.

```php
// Guzzle
$client = new \GuzzleHttp\Client();
$response = $client->request('POST', 'http://test.com/users', [
    'form_params' => [
        'name' => 'Sara',
       'role' => 'Privacy Consultant',
    ]
]);

// 라라벨 HTTP
$response = Http::asForm()->post('http://test.com/users', [
    'name' => 'Sara',
    'role' => 'Privacy Consultant',
]);
```

#### 파일 전송

Guzzle과 라라벨 HTTP 모두 문자열과 스트림으로 파일을 전달할 수 있습니다. Guzzle로 파일을 전송할 때는 ‘multipart’에 배열로 데이터를 담아 전송하면 되고, 라라벨 HTTP는 attach() 메서드를 사용하면 됩니다.

```php
// Guzzle 문자열 이용
$client = new \GuzzleHttp\Client();
$response = $client->request('POST', 'http://httpbin.org/post', [
    'multipart' => [
        [
            'name' => 'field_name',
            'contents' => 'abc'
            'filename' => 'filename.txt',
        ]
    ]
]);

// 라라벨 HTTP 문자열 이용
$response = Http::attach(
    'attachment', file_get_contents('photo.jpg'), 'photo.jpg'
)->post('http://test.com/attachments');

// Guzzle 스트림 이용
$client = new \GuzzleHttp\Client();
$response = $client->request('POST', 'http://httpbin.org/post', [
    'multipart' => [
        [
            'name' => 'file_name',
            'contents' => fopen('/path/to/file', 'r'),
            'filename' => 'filename.txt',
        ],
    ]
]);

// 라라벨 HTTP 스트림 이용
$photo = fopen('photo.jpg', 'r');

$response = Http::attach(
    'attachment', $photo, 'photo.jpg'
)->post('http://test.com/attachments');
```

### 인증

```php
// Guzzle 기본
$response = $client->request('GET', '/get', ['auth' => ['username', 'password']]);

// Guzzle 다이제스트
$response = $client->request('GET', '/get', [
'auth' => ['username', 'password', 'digest']
]);

// Guzzle Bearer
$response = $client->request('GET', '/get', [
	'headers' => [
		'Authorization' => 'Bearer' . $token,
		'Accept' => 'application/json',
	]
]);
// 라라벨 HTTP 기본
$response = Http::withBasicAuth('taylor@laravel.com', 'secret')->post(...);

// 라라벨 HTTP 다이제스트
$response = Http::withDigestAuth('taylor@laravel.com', 'secret')->post(...);

// 라라벨 HTTP Bearer
$response = Http::withToken('token')->post(...);
```

## 재시도

Guzzle은 내장된 RetryMiddleware를 사용하거나, caseyamcl/guzzle_retry_middleware 같은 외부 패키지를 사용해서 재시도를 설정할 수 있습니다. 언뜻 보기에 라라벨 HTTP 보다 편하게 설정할 수 있는 것 처럼 보이진 않네요.

```php
// 라라벨 HTTP
$response = Http::retry(3, 100)->post(...);
```

## 에러 처리

Guzzle은 외부 서버에서 에러가 발생해도 예외를 던지지만, 라라벨 HTTP는 그렇지 않습니다. 이건 어떤 방식이 더 편리한건지 잘 모르겠네요.

### 테스트

기존에는 응답을 속이기 위해 직접 모킹해야 했습니다. 라라벨 HTTP는 테스트에 활용할 수 있는 여러 편의 기능을 제공합니다. 이 부분에 대해서는 라라벨 HTTP가 압승인 듯 합니다. 간단히 비교하면 아래와 같습니다. 더 많은 기능이 있으니 관심있으시면 공식 메뉴얼을 참고하세요.

```php
// Guzzle
$mock = $this->mock(Client::class);
    $mock->shouldReceive('send')
        ->andReturn(new Response(
            $status = 200,
            $headers = [],
            ['foo' => 'bar']
        ));

// 라라벨 HTTP
Http::fake([
    // 깃헙 엔드포인트용 JSON 응답 스텁...
    'github.com/*' => Http::response(['foo' => 'bar'], 200, ['Headers']),

    // 구글 엔드포인트용 문자열 응답 스텁...
    'google.com/*' => Http::response('Hello World', 200, ['Headers']),
]);
```

## 마치며

기존에 Guzzle(또는 다른 HTTP 클라이언트 패키지)를 사용하는 것에 비해 어떤 면에서 편리해졌을까 하는 궁금증으로 글을 시작했습니다.

하나씩 정리해보니 확실히 더 편리해보이네요. 서두에 말씀드린 것 처럼 어차피 라라벨 HTTP 클라이언트를 사용하기 위해선 Guzzle을 설치해야 하기 때문에, 좀 더 손쉽게 사용할 수 있는 HTTP 클라이언트를 우선 이용하고 이것으로 해결되지 않는 상황은 Guzzle로 해결하면 어떨까 싶습니다.
