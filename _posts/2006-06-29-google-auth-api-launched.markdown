---
layout: single
title: "구글(Google) 계정 인증 API 공개"
date: 2006-06-29 04:47:53
categories: service
tags: google
author: Samgu Lee
header:
  og_image: /assets/Authsub_diagram.jpg
---

팔글에서 4월 21일 GData라는 구글(Google)에서 데이터를 전송할 때 사용할 수 있는 API의 공개를 알려드린바 있습니다.

[그 당시 스펙에 따르면][gdata-means] 인증 부분이 구현되어 있었지만, 실제 작동되지는 않았는데 이번 계정 인증(Google Account Authentication) API의 구현으로 인해서 구글의 계정 데이터를 이용해서 서비스를 개발할 수 있게 되었습니다.

[구글 계정 인증](http://code.google.com/apis/accounts/Authentication.html)은 크게 두가지로 되어 있습니다. 어플리케이션(일반 프로그램) 인증과, 웹서비스 인증이 그것입니다. 둘은 각각 ClientLogin API와 AuthSub API로 작동되는데, 팔글에서는 웹서비스 인증에 대해서만 알아보겠습니다.

## 구글 계정 인증 API의 프로세스

![구글 계정 인증 API 프로세스](/assets/Authsub_diagram.jpg)

위의 그림에서 알 수 있듯이 개발자의 웹서비스는 구글의 인증서버에 연결이 되고, 이용자의 허가가 떨어지면 토큰값을 받습니다. 물론 거부하면 거부되었다는 메세지를 웹서비스에 전달하게 됩니다.

웹서비스는 받은 토큰값으로 구글의 여러가지 서비스에 접속을 하게 되고, 이제부터 구글은 웹서비스에 정보를 전달하게 됩니다. 이제 부터는 인증 API가 할 일이 아닌 GData API로 접속이 이루어 집니다.

구글 인증 API는 웹서비스 업체에게 개인 정보를 넘기지 않는 대신에 토큰값만을 넘깁니다. 따라서, 예민한 개인정보(스펙에 없는 정보) 유출에 문제에서 벗어날 수 있습니다.

토큰(Tokken)은 키(Key)라는 말과 같이 쓰이는 경우가 있지만, 보통 키는 변하지 않는 값을 말하고, 토큰은 일시적이고, 보안에 신경쓰지 않아도 되는 값을 말합니다. 둘 다 어떤 개체를 지칭 혹은 구분할 때 사용됩니다.

## 인증을 받은 후의 프로세스

GData API는 RSS나 ATOM과 같이 데이터 전달 포멧인 XML 형태이고 생김새도 매우 비슷하지만, 인증이 들어가 있다는 차이점이 있습니다. 그리고, 거의 대부분의 구글 서비스에 대한 XML 스키마가 제공됩니다.

현재까지는 스펙은 제공되지만, 실제 쓸 수 있는 API는 구글 Calendar API가 있습니다. 즉, 구글 Calendar의 개인 등록 정보를 이용한 다른 서비스를 제공할 수 있다는 의미입니다.

## 서비스 이용 시나리오

구글은 웹사이트에서 Calendar를 이용한 예제를 설명하고 있지만, 한국의 경우 이용자가 많다고 볼 수는 없기 때문에 아직까지는 서비스가 제한적입니다. Calendar 보다는 구글 Reader의 API가 공개되는 것이 활성화에 도움이 될 것입니다. 조만간 모든 서비스에 대한 API가 공개되리라 의심치 않습니다.

## 실제로 이용해 보자

이 서비스는 "인증"이라는 테마이기 때문에 이용하는 것이 그리 간단하지는 않습니다. 더군다나 구글의 허락을 받아야 합니다.

일단, 구글 인증 API를 이용하기 위해서는 서버에 PEM 포멧의 X.509 인증서가 존재해야 합니다. 리눅스의 경우는 OpenSSL을 이용해서 인증서를 만들 수 있는데, 윈도우즈 서버에서는 서버에 공인인증서(VeriSign, Thawte, Entrust 등의 회사가 발행하는 인증서)가 있어야 합니다.

인증서를 만든 후 구글에서 요구하는 XML 형식의 문서를 만든 후 담당자에게 이메일을 보냅니다.

허가를 받고 실제 서비스를 구현하면 웹서비스에서 구글 인증을 시도할 때 다음과 같은 화면이 뜬다고 합니다.

![구글 인증 API 시도 화면 1](/assets/accessrequestpage.jpg)

![구글 인증 API 시도 화면 2](/assets/accessdenypage.jpg)

팔글에서 테스트를 해 보았는데 서버가 윈도우즈 2003이기 때문에 인증서 만드는데 실패했습니다. 공인인증서가 존재하는 서버를 운영하시는 분 만약 테스트 한다면 트랙백 부탁합니다.

[gdata-means]:{% post_url 2006-04-21-gdata-means %}
