---
layout: single
title:  "구글 메일(GMail)의 SMTP를 이용한 메일발송하기"
date:   2006-08-21 08:51:59
categories: tip
tags: google gmail
author: Samgu Lee
---
메일 발송에 대한 프로그래밍은 프로그래머의 골칫거리 중 하나입니다. 일반인에게 메일 서비스를 하는 포탈의 경우 강력한 스팸 필터링으로 인해 메일 발송이 아예 되지 않는 경우가 많기 때문입니다. 국내 포탈들의 경우 IP를 등록하지 않으면 대게가 메일 발송이 되지 않습니다.

이런 문제 때문에 구글 SMTP를 이용한 메일 발송은 의미가 있을 수 있습니다. 프로그램 제작자는 구글의 SMTP를 이용하면 마치 구글에서 보내는 것과 마찬가지의 효과를 얻을 수 있고, 국내 대부분의 포탈들은 구글에서 보내는 메일을 블록하지 않기 때문([과거엔 블록당했었음][not-able-to-send-mail])에 자체 메일서버를 운영하는 것 이상의 효과를 얻을 수 있습니다.

## 준비물

우선 구글의 SMTP를 사용하기 위한 준비물을 살펴보도록 합니다. 만약 경험이 있다면 아래의 링크만으로도 원활한 제작이 가능할 것 같습니다.

연관링크 : [GMail 도움말 센터 - 기타 메일 클라이언트 설정](http://mail.google.com/support/bin/answer.py?answer=13287&query=smtp&topic=&type=f&ctx=search)

당연한 것이지만, 우선 구글 메일의 계정이 있어야 합니다. 그리고, 구동하려하는 웹서버가 SSL 모듈이 설치되어 있어야 합니다.

이 두가지가 준비물의 전부이고, 웹서버의 종류는 관계가 없습니다.

그럼 메일러를 제작해야 합니다...만 이미 선배들은 스크립트로 작동될 수 있는 메일러를 이미 작성해 놓았습니다. 그런 메일러 중 SSL 기능을 지원하는 것으로 골라야 합니다.

PHP의 경우는 [XPertMailer](http://xpertmailer.sourceforge.net/)가 이를 지원합니다.

원리는 간단합니다. 포트를 465번으로 맞추고, 계정과 비밀번호를 구글 계정으로 설정합니다. 그리고, 실행하면 끝~!

미리 만들어 본 설정 예제는 다음과 같습니다.

```sh
XPertMailer : SMTP_RELAY_CLIENT, &#8216;66.249.93.109', 1, true
auth : $sender_email, $password, AUTH_LOGIN, SSL_TRUE, 465
from : $sender_email, $sender
header[&#8216;Reply-To'] : $sender_email
header[&#8216;X-Whatever'] : &#8216;description'
```

위의 코드에서 IP 주소는 GMail을 nslookup한 값입니다. 만약 웹서버가 nslookup과 비슷한 함수를 지원한다면 gmail.com을 이용해서 IP를 자동으로 뽑아올 수도 있습니다.

$sender_email과 $password에는 구글 계정과 암호가 들어가게 됩니다.

보내는 사람의 이메일과 암호는 정확히 넣어야 발송이 된다는 사실을 꼭 기억하세요.

[not-able-to-send-mail]: {% post_url 2006-02-03-not-able-to-send-mail %}
