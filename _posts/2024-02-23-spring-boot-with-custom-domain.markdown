---
layout: single
title: "스프링 부트 프로젝트 개발에 커스텀 도메인 연결하기"
date: 2024-02-23 22:20:00
categories: development
tags: spring laravel valet
author: Samgu Lee
header:
  og_image: /assets/images/spring_boot_and_laravel_valet.png
---

스프링 부트 환경에서 `http://localhost:8080` 이 아닌 `https://spring-boot.test` 와 같은 도메인으로 개발할 수 있는 방법을 소개합니다.

![Spring boot and laravel valet]({{ page.header.og_image }})

웹사이트를 개발할 때 `localhost`나 `127.0.0.1`로 테스트를 하게 되면 쿠키와 세션, 그리고 카카오 로그인과 같은 외부 SDK와의 연동 문제 등이 생길 수 있습니다. 따라서, ssl과 커스텀 도메인은 라라벨 에코시스템에서는 필수이지만, 다른 프레임워크에서는 [공식 문서에서도 이 부분을 다루지 않습니다](https://docs.spring.io/spring-boot/docs/current/reference/html/using.html).

이 글에서는 [라라벨 발렛](https://laravel.kr/docs/9.x/valet)을 이용해서 [스프링 부트](https://spring.io/projects/spring-boot)를 로컬에서 띄우는 방법을 설명합니다.

[Laravel Valet](https://laravel.com/docs/10.x/valet)을 설치한 후 아래의 순서대로 따라 하세요.

## 1. `valet secure`를 실행합니다

```sh
cd spring-boot

valet secure
```

Valet은 간단한 커맨드 만으로 브라우져에서 <https://spring-boot.test> 로 접속을 할 수 있게 만들어 줍니다.

## 2. Nginx 설정을 수정합니다

Nginx 설정파일을 에디터로 열어주세요.

```sh
code /Users/[MAC_NAME]/.config/valet/Nginx/spring-boot.test
```

이제 Valet의 Nginx 설정파일인 `spring-boot.test` 파일에서 가장 상단에 다음을 추가합니다.

```nginx
map $sent_http_content_type $expires {
    "text/html"                 epoch;
    "text/html; charset=utf-8"  epoch;
    default                     off;
}
```

그리고, 아래의 코드를 찾아서

```nginx
location / {
    rewrite ^ "/Users/[MAC_NAME]/.composer/vendor/laravel/valet/server.php" last;
}
```

이렇게 수정합니다.

```nginx
location / {
    expires $expires;

    proxy_redirect                      off;
    proxy_set_header Host               $host;
    proxy_set_header X-Real-IP          $remote_addr;
    proxy_set_header X-Forwarded-For    $proxy_add_x_forwarded_for;
    proxy_set_header X-Forwarded-Proto  $scheme;
    proxy_read_timeout          1m;
    proxy_connect_timeout       1m;
    proxy_pass                          http://127.0.0.1:8080; # set the adress of the Spring Boot instance here
}
```

## 3. 커스텀 도메인으로 접속합니다

설정을 변경한 후 `valet restart` 실행 후 <https://spring-boot.test> 로 접속을 하면 <http://127.0.0.1:8080> 으로 접속됩니다.(proxy_pass)

자, 이제 스프링 부트 프로젝트를 실행합니다.

```sh
./gradlew bootRun
```

브라우져에 <https://spring-boot.test> 를 입력하면 스프링 부트 웹사이트를 볼 수 있습니다!

![https와 더불어 커스텀 도메인이 적용되었다](/assets/images/screenshot_custom_domain.png)

개발할 때 도메인을 이용해야 하는 이유는 인증 관련 작업을 할 경우 IP나 localhost의 경우 개발을 하기가 매우 어렵기 때문입니다. 특히 [카카오 로그인](https://developers.kakao.com/docs/latest/en/kakaologin/common) 등의 경우는 개발 자체가 불가능할 때도 있습니다.

부가적으로 Valet에는 [`ngrok`](https://ngrok.com/)나 [`expose`](https://expose.dev/)를 이용해서 [외부에서도 접속할 수 있거나 하는 기능](https://laravel.com/docs/10.x/valet#sharing-sites)이 있기 때문에 개발 편의성이 높아지는 장점도 있습니다.

라라벨 발렛을 사용하지 않아도 Ngnix나 Apache를 이용해서 [리버스 프록시를 구성할 수 있습니다](https://medium.com/@steelcityamir/using-apache-as-a-reverse-proxy-for-spring-boot-embedded-tomcat-f704da73e7c8).

다음은 `spring-boot.test` 설정파일 전문입니다.

```nginx
map $sent_http_content_type $expires {
    "text/html"                 epoch;
    "text/html; charset=utf-8"  epoch;
    default                     off;
}

server {
    listen 127.0.0.1:80;
    #listen 127.0.0.1:80; # valet loopback
    server_name demo-for-spring-boot.test www.demo-for-spring-boot.test *.demo-for-spring-boot.test;
    return 301 https://$host$request_uri;
}

server {
    listen 127.0.0.1:443 ssl;
    #listen VALET_LOOPBACK:443 ssl; # valet loopback
    server_name demo-for-spring-boot.test www.demo-for-spring-boot.test *.demo-for-spring-boot.test;
    root /;
    charset utf-8;
    client_max_body_size 512M;
    http2  on;

    location /41c270e4-5535-4daa-b23e-c269744c2f45/ {
        internal;
        alias /;
        try_files $uri $uri/;
    }

    ssl_certificate "/Users/cable8mm/.config/valet/Certificates/spring-boot.test.crt";
    ssl_certificate_key "/Users/cable8mm/.config/valet/Certificates/spring-boot.test.key";

    location / {
        expires $expires;

        proxy_redirect                      off;
        proxy_set_header Host               $host;
        proxy_set_header X-Real-IP          $remote_addr;
        proxy_set_header X-Forwarded-For    $proxy_add_x_forwarded_for;
        proxy_set_header X-Forwarded-Proto  $scheme;
        proxy_read_timeout          1m;
        proxy_connect_timeout       1m;
        proxy_pass                          http://127.0.0.1:8080; # set the adress of the Node.js instance here
    }

    location = /favicon.ico { access_log off; log_not_found off; }
    location = /robots.txt  { access_log off; log_not_found off; }

    access_log off;
    error_log "/Users/cable8mm/.config/valet/Log/nginx-error.log";

    error_page 404 "/Users/cable8mm/.composer/vendor/laravel/valet/server.php";

    location ~ [^/]\.php(/|$) {
        fastcgi_split_path_info ^(.+\.php)(/.+)$;
        fastcgi_pass "unix:/Users/cable8mm/.config/valet/valet.sock";
        fastcgi_index "/Users/cable8mm/.composer/vendor/laravel/valet/server.php";
        include fastcgi_params;
        fastcgi_param SCRIPT_FILENAME "/Users/cable8mm/.composer/vendor/laravel/valet/server.php";
        fastcgi_param PATH_INFO $fastcgi_path_info;
    }

    location ~ /\.ht {
        deny all;
    }
}

server {
    listen 127.0.0.1:60;
    #listen 127.0.0.1:60; # valet loopback
    server_name demo-for-spring-boot.test www.demo-for-spring-boot.test *.demo-for-spring-boot.test;
    root /;
    charset utf-8;
    client_max_body_size 128M;

    add_header X-Robots-Tag 'noindex, nofollow, nosnippet, noarchive';

    location /41c270e4-5535-4daa-b23e-c269744c2f45/ {
        internal;
        alias /;
        try_files $uri $uri/;
    }

    location / {
        rewrite ^ "/Users/cable8mm/.composer/vendor/laravel/valet/server.php" last;
    }

    location = /favicon.ico { access_log off; log_not_found off; }
    location = /robots.txt  { access_log off; log_not_found off; }

    access_log off;
    error_log "/Users/cable8mm/.config/valet/Log/nginx-error.log";

    error_page 404 "/Users/cable8mm/.composer/vendor/laravel/valet/server.php";

    location ~ [^/]\.php(/|$) {
        fastcgi_split_path_info ^(.+\.php)(/.+)$;
        fastcgi_pass "unix:/Users/cable8mm/.config/valet/valet.sock";
        fastcgi_index "/Users/cable8mm/.composer/vendor/laravel/valet/server.php";
        include fastcgi_params;
        fastcgi_param SCRIPT_FILENAME "/Users/cable8mm/.composer/vendor/laravel/valet/server.php";
        fastcgi_param PATH_INFO $fastcgi_path_info;
    }

    location ~ /\.ht {
        deny all;
    }
}
```
