---
layout: single
title: "라라벨 Herd 설치 후 Xdebug 에러 수정하는 법"
date: 2024-02-26 14:32:00
categories: development
tags: tips laravel herd xdebug
author: Samgu Lee
header:
  og_image: /assets/images/herdxdebug.png
---

라라벨 Valet을 대신할 수 있는 Laravel Herd를 사용하면 편하게 개발 환경을 만들 수 있지만, XDebug 에러가 날 경우가 있습니다. 에러를 해결할 수 있는 방법을 알려 드립니다.

![라라벨 Herd와 Xdebug](/assets/images/herdxdebug.png)

라라벨 Valet은 커맨드 만으로 mysql, dnsmasq, php, nginx, 그리고 https와 NAT 외부에서 접속할 수 있게 하는 등 다른 프레임워크에 비해서 굉장히 편한 개발환경을 만들어 줍니다. 10분도 안되서 개발 환경을 만들 수 있죠.

반면 라라벨 Herd는 라라벨 Valet을 건들이지 않고도 더 편하고 빠른 개발환경을 만들 수 있으며, [php나 node 버전 업데이트 등도 쉽게 관리](https://herd.laravel.com/docs/1/advanced-usage/php-versions)할 수 있고 맥 네이티브 UI 를 제공하므로 사용하지 않을 이유가 없습니다.

다만, 에러가 생길 경우 Herd는 생긴지 얼마 되지 않기 때문에 조금 까다로우며, 이 글에서 다루는 에러도 해결을 하는데 8시간이나 걸렸습니다.

## Xdebug 설정

라라벨 Herd는 유료인 Pro 버전을 제공하는데요, 그 경우 [XDebug를 자동으로 관리](https://herd.laravel.com/docs/1/advanced-usage/xdebug) 해 줍니다. 무료 버전의 경우 아래와 같이 XDebug를 설정할 수 있죠.

```sh
zend_extension=/Applications/Herd.app/Contents/Resources/xdebug/xdebug-83-arm64.so
xdebug.mode=debug,develop
xdebug.start_with_request=yes
xdebug.start_upon_error=yes
```

공식 문서에 따르면 위의 코드를 `php.ini` 파일 안에 넣습니다. `php.ini`는 화면 최 상단 Herd 아이콘을 클릭 후 나오는 `Show php.ini` 을 클릭하면 finder가 바로 뜹니다.

![라라벨 Herd에서 php.ini 바로가기 버튼](/assets/images/laravel-herd-icon.png)

## Xdebug 에러

그런데, 위와 같이 하더라도 Xdebug와 php가 연결이 되지 않을 때가 있습니다.

```sh
~ herd restart
Xdebug: [Step Debug] Could not connect to debugging client. Tried: localhost:9003 (through xdebug.client_host/xdebug.client_port).
Xdebug: [Step Debug] Could not connect to debugging client. Tried: localhost:9003 (through xdebug.client_host/xdebug.client_port).
Restarting DNSMasq...
Restarting PHP 8.2...
Restarting Nginx...
Herd services have been restarted.
```

Herd 재시작을 하면 DNSMasq, PHP, Nginx 모두 리스타트가 되지만, Xdebug는 작동하지 않습니다. 이 경우 어떻게 해결할까요?

## Xdebug 에러 수정하는 법

라라벨 Herd의 설명대로 `php.ini`에 넣고 아래 한 줄을 더 추가 해 줍니다.

```sh
xdebug.log_level=0
```

이 명령어는 실행 로그를 멈추라는 뜻입니다.

이후 라라벨 Herd를 재시작하면 Xdebug가 웹이던 cli던 제대로 작동됨을 확인할 수 있습니다.

## 도움글

전 라라벨 Herd가 라라벨 valet에 맥 UI를 올린 것이라고 생각했습니다만, 라라벨 Herd는 valet과는 완전히 다르게 개발 환경을 관리 해 줍니다. 물론 Herd는 valet과 충돌되지 않는다고 이야기하지만, 전 이번 에러를 해결하면서 valet을 완전히 삭제했으며, 기존에 설치된 php 및 pecl 모두 삭제를 했습니다.

동일한 일을 두가지 프로그램이 할 경우 특정한 상황에서 문제를 발생할 수 있으니까요.

만약 맥에서 php 개발이 처음이라면 valet을 설치하지 말고 Herd를 설치하는 것이 더 쾌적한 개발 환경을 만들 수 있습니다.
