---
title: "PHP용 PortOne V2 SDK가 없어서 직접 만들었습니다: OpenAPI 147개 operation 전수 검증기"
date: 2026-10-12 09:00:00 +0900
excerpt: "포트원 V2에는 PHP SDK가 없어서 cable8mm/portone-php를 만들었습니다. 한국형 Laravel Cashier 호환 패키지를 만들기 위한 첫 단계입니다. JVM SDK로 뼈대를 잡고 최종 기준은 공식 OpenAPI로 바꿨으며, 147개 operation 전부를 실제 API로 전수 테스트했습니다."
categories: development
tags: php portone sdk openapi guzzle webhook laravel cashier payment ai-coding replworks
author: Samgu Lee
header:
  og_image: /assets/images/portone-homepage-hero.png
---

이번 글은 개발자인 제가 보기에도 꽤 지루한 글이 될 것 같습니다. 이 글은 포트원의 PHP SDK를 만든 기록입니다. AI와 함께 개발을 진행하는 분들에게 실무에서 도움이 되었으면 합니다.

## 프로젝트의 출발

한국에서 Laravel로 서비스를 만들면 결제를 붙일 때마다 같은 고민을 하게 됩니다. 해외에는 Laravel Cashier가 있어서 구독·결제 로직을 일관된 방식으로 쓸 수 있는데, 제가 찾은 범위에서는 한국 PG에 그에 해당하는 패키지가 없었습니다.

저는 포트원 기반으로 Cashier 호환 패키지가 있으면 좋겠다고 생각했습니다.

![포트원 홈페이지](/assets/images/portone-homepage-hero.png)

포트원은 국내 주요 PG를 한 번에 감싸고 있어서, PG별 패키지를 따로 만들 필요가 없기 때문입니다. 그리고, 결제를 할 때 백엔드 서버를 제작하고 운영하는 비용을 생각하면 포트원을 안 쓸 이유가 없다고 전 생각했습니다.

마침 [와이파이 노트](https://wifinote.net)에 결제를 붙여야 해서 패키지를 찾기 시작했습니다. 그런데 상황이 생각보다 나빴습니다.

- [blood72/laravel-iamport](https://github.com/blood72/laravel-iamport): 개인이 만든 Laravel 패키지이고, 마지막 업데이트가 2020년입니다.
- [iamport/iamport-rest-client-php](https://github.com/iamport/iamport-rest-client-php): 아임포트(현 PortOne)가 제공한 공식 PHP 클라이언트입니다. 마지막 업데이트가 2022년이고, 지금은 deprecated 상태입니다.
- 공식 [server-sdk](https://github.com/portone-io/server-sdk) 저장소에는 PHP가 Go와 함께 빠져 있습니다. 공식 문서에는 PHP와 Go SDK가 지원 예정이라고 적혀 있습니다.

![포트원은 Go, PHP 등을 지원할 예정입니다](/assets/images/portone-will-support-go-and-php.png)

위 두 패키지는 모두 PortOne V1(아임포트) 시절의 것입니다. V2를 지원하는 PHP 패키지는 없었고, Cashier 호환 패키지는커녕 PHP로 PortOne V2를 쓰려는 개발자가 기댈 곳이 사실상 없었습니다.

선택지는 두 가지였습니다.

- 애플리케이션마다 PortOne API 연동 코드를 직접 작성한다.
- PHP SDK를 먼저 만들고, 그 위에 Laravel 패키지(최종적으로는 Cashier 호환 패키지)를 만든다.

저는 두 번째를 선택했습니다. 그 첫 단계가 [`cable8mm/portone-php`](https://github.com/cable8mm/portone-php) v0.1.0입니다.

- GitHub: <https://github.com/cable8mm/portone-php>
- 요구 사항: PHP 8.2+, PortOne V2 전용, MIT 라이선스

## 범위는 OpenAPI 전체로 잡았습니다

처음 내가 한 일은 어떤 언어의 sdk를 포트원이 지원하는가 였습니다. 포팅을 하기 위해서 입니다. 역시 java와 node는 지원하고 있었고, PHP로 포팅이 가능한 java 버전을 살펴봤습니다.

포팅이 끝나고 작동 가능한 버전을 만든 후, 테스트 코드를 통해서 검증합니다. 그 후에 API Spec을 참고로 전체 구현체를 만들 계획이었습니다.

순서대로 AI와 코딩을 한 후에 나온 결과물은 아래와 같습니다.

- 115개 path, 147개 operation
- 모든 operation의 동기 메서드와 비동기(`Async` 접미사) 메서드
- operation별 응답 클래스와 PortOne API 오류를 표현하는 예외 타입
- webhook 서명 검증, 알 수 없는 webhook 타입의 안전한 처리

```php
$payment = $client->payment->getPayment($paymentId);

$future = $client->payment->getPaymentAsync($paymentId);
$payment = $future->wait();
```

HTTP 통신은 Guzzle을 사용했습니다. JVM SDK에서 제공했던 비동기는 Guzzle의 Promise를 그대로 노출하지 않고 SDK 자체의 `Future`로 감쌌습니다. 사용하는 쪽에서 Guzzle 구현을 알 필요가 없도록 하기 위해서입니다. transport 규칙은 다음과 같습니다.

- 연결 timeout 10초, 전체 timeout 30초
- 자동 retry 없음
- `Authorization: PortOne {apiSecret}` 헤더 사용
- 동기·비동기가 같은 request 정의, 같은 응답 해석, 같은 오류 매핑을 사용

## JVM SDK는 출발점이었을 뿐, 기준은 아니었습니다

Java와 PHP는 문법적으로 비슷한 부분이 많아서, 처음에는 현재 최신 버전의 JVM SDK(`jvm-v0.24.0`)를 참고했습니다.

![포트원의 JVM 패키지](/assets/images/jvm-sdk-for-portone.png)

클라이언트 구조, operation 목록, 응답 모델, 예외 구조, 비동기 방식의 뼈대를 여기서 잡았죠. 작업 초반에는 JVM SDK의 operation, 파라미터, 응답 모델을 기록하는 probe를 만들고, PHP 쪽이 그것과 달라지면 실패하도록 했습니다.

JVM SDK를 기준으로 삼고 패키지를 완성했습니다. 그리고, 드디어 OpenAPI 스펙을 만족해야 하는 진짜 PHP SDK를 만들 차례입니다.

[공식 OpenAPI V2 스냅샷](https://developers.portone.io/api/rest-v2?v=v2)을 저장소에 넣고, 다음을 대조하는 도구를 만들었습니다.

1. operationId 목록과 PHP의 동기·비동기 메서드
2. path, HTTP method, path/query 파라미터, request body 필드와 PHP 메서드 시그니처
3. 모든 success response schema와 PHP 응답 클래스

이 도구들은 JVM SDK를 참조하지 않았습니다. JVM 비교 probe는 중간 검증 수단이었고, 이 절차에서는 더 이상 참조하지 않기 때문에 JVM 의존 도구는 제거했습니다. CI도 로컬 JVM 체크아웃 없이 돌아갑니다.

> 사실 이 단계가 사람과 AI가 코딩을 하는 결정적인 차이 같다고 느꼈습니다. 포팅을 할 때 기존의 구현체를 보고 제품을 완성한 뒤 전체 스펙을 구현하고 최종 테스트하는건 꽤나 고통스러운 작업입니다.
>
> 그런데, AI를 사용하니 이 고통이 마법처럼 사라졌습니다.

## 응답 모델

응답 최상위는 operation별 PHP response class로 변환합니다. 모델링된 필드는 필수 필드와 타입을 검증하며, 조건을 만족하지 않으면 operation 경계에서 `UnrecognizedResponseException`으로 처리합니다. 정의되지 않은 추가 필드는 무시합니다.

다만 OpenAPI의 복합 객체 중 일부는 아직 associative array 또는 `list<array>` 형태로 노출됩니다. 예를 들어 플랫폼 파트너의 연락처·계좌 정보, 세금계산서의 공급자·수취자·품목 정보, 일부 결제·이체 응답의 중첩 객체가 이에 해당합니다. 페이지 정보와 자유형 사용자 정의 데이터도 배열로 유지합니다.

`oneOf` 응답은 discriminator로 variant를 고르고, 알 수 없는 variant나 새 enum 값은 원본 payload를 보존한 채 `unrecognized` 상태로 받습니다. API에 새 variant가 추가되어도 SDK가 바로 깨지지 않게 하려는 설계입니다.

## 오류 모델

OpenAPI에 정의된 오류 응답은 각각 `PortOneException`의 하위 타입으로 매핑했습니다.

- 정의되지 않은 오류: `UnknownException`
- 해석할 수 없는 성공 응답: `UnrecognizedResponseException`
- 네트워크 문제: `TransportException`

모두 `PortOneException`을 상속합니다. HTTP status, 오류 type, message, 원본 body는 보존하되 credential은 노출하지 않습니다.

## Webhook 검증

결제 연동에서 API 호출만큼 중요한 것이 webhook 검증입니다.

```php
$webhook = $verifier->verify(
    $body,
    $request->header('webhook-id'),
    $request->header('webhook-signature'),
    $request->header('webhook-timestamp'),
);
```

원본 body를 그대로 보존한 채 서명을 검증합니다. 검증이 통과한 뒤에만 디코딩하고, 알고 있는 타입이면 typed object로, 모르는 타입이면 `UnrecognizedWebhook`으로 돌려줍니다. body 변조, signature 변조, timestamp 허용 범위 초과는 `WebhookVerificationException`이 되며, 검증되지 않은 body는 디코딩하지 않습니다.

## 147개 operation을 전수 검증했습니다

mock 테스트는 끝났습니다. 하지만, 결제 SDK는 포트원에서 공개한 OpenAPI의 전체 스펙을 API 상에서 정확히 작동해야 합니다.

그래서 OpenAPI JSON에서 operation 목록을 읽어 147개 전부를 실제 포트원 API에 호출하는 E2E probe 매트릭스를 만들었습니다.

샘플링이 아니라 전수이고, 147개 모두 통과했습니다. 결과는 operation별로 성공 결과 타입 또는 관측된 `PortOneException` 타입과 status code를 JSON으로 기록합니다.

실제 API 경계에서 따로 확인한 항목은 다음과 같습니다.

- 인증 헤더, 연결·전체 timeout, retry 없음
- 정의된 오류, 알 수 없는 오류, 해석할 수 없는 성공 응답
- 동기·비동기 결과 동등성
- webhook 정상 검증, body·signature 변조 거부, timestamp tolerance, 알 수 없는 타입

PHPUnit과 OpenAPI 계약 검사(operation, 시그니처, 응답 스키마 인벤토리)는 PHP 8.2부터 8.5까지 GitHub Actions에서 통과했습니다.

## REPLWorks 방식으로 만들었습니다

이 프로젝트도 제가 쓰는 [REPLWorks](https://www.rep.net) 방식으로 만들었습니다. 코드는 전부 AI가 작성했고, 제가 한 일은 "무엇이 끝난 것인가"를 문서로 먼저 정하는 것이었습니다. 저장소에는 `PRODUCT_SPEC.md`, `ARCHITECTURE.md`, `TECH_STACK.md`, `TASKS.md`가 있고, 작업은 `TASKS.md`의 48개 task로 쪼갰습니다.

![REPL Works의 TASKS.md 문서](/assets/images/tasks-of-replworks-documents.png)

각 task에는 acceptance criteria가 있고, "외부 경계" 여부를 표시했습니다. 외부 경계가 있는 task는 mock 테스트만으로 닫을 수 없고, 실제 포트원 API probe를 통과해야 완료 처리했습니다. 결제 SDK에서 "아마 잘 동작할 것"은 아무 의미가 없으니까요.

외부 경계가 true일 경우 AI는 테스트코드가 아니라 실제로 작동되는지 여부를 체크합니다. 즉, 코드가 배포가 되어야 알 수 있는 테스트를 해야한다는 의미이며, 이 것도 배포 전에 불가능하지 않다는 것을 알게 되었습니다. 도커를 이용할 수도 있고, 이 부분만을 별도의 웹서버를 로컬에서 띄울 수도 있습니다. 물론 보안과 관련된 것들은 사람이 개입해서 작동 여부를 알려주어야 하죠.

이 방식이 실제로 작동했다고 말할 수 있는 근거는 두 가지입니다.

- 147개 operation이 실제 API에서 전수 통과했습니다. AI가 쓴 코드가 "돌아가는 것처럼 보이는" 수준이 아니라, 문서에 적은 기준을 통과했다는 뜻입니다.
- 중간에 기준을 바꿀 수 있었습니다. 초반 task(T-002, T-020)는 JVM SDK를 참고 계약으로 삼았고, 뒤쪽 task(T-035~037)부터는 JVM 카탈로그를 권위로 쓰지 않고 공식 OpenAPI로 바꿨습니다. 문서가 기준을 명시하고 있었기 때문에, 무엇을 바꾸고 무엇을 지울지 task 단위로 판단할 수 있었습니다.

REPLWorks가 무엇인지는 [이전 글](https://www.palgle.com/2026/10/11/laravel-imageforge-ai-development/)에서 정리했습니다. 이번 SDK는 그 방식이 결제 SDK에서도 통한다는 또 다른 사례입니다.

## 다음 단계

이 SDK 위에 Laravel 통합 패키지를 만들 예정입니다. 최종 목표는 처음 생각했던 Cashier 호환 패키지입니다.

- 서비스 컨테이너에서 Client 주입
- 환경 변수 기반 API Secret 설정
- Laravel HTTP request에서 webhook 검증
- Laravel 예외 처리와 연동
- 그 위에 구독·결제 흐름을 Cashier와 비슷한 방식으로 쓸 수 있는 계층

SDK가 포트원 API 전체를 덮고 있으니, 이 계층은 SDK 호출을 Laravel 방식으로 감싸는 일에 집중할 수 있습니다.

## 마무리

AI와의 협업에서 인간이 과연 어떤 일을 해야하느냐라는 것은 개발방법론에 있어서 미래에 아주 중요한 이슈가 될 것입니다.

지금은 사람이 결정하고 AI가 수행한다, 혹은 사람이 검토하고 AI가 수행한다라는 쪽으로 많은 분들이 생각하고 있는 것 같습니다.

제가 REPL Works 방식으로 여러가지 코드를 만들면서 드는 생각은 그것이 불가능할 것 같다라는 점입니다.

사람은 현재도 그리고 미래에서 AI가 만드는 어떤 산출물도 이해할 수 없는 시대가 올 것 같습니다. 그 시대에 사람은 어떤 역할을 해야 할까요?
