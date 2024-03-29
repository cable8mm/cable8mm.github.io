---
layout: single
title: "구글 애플리케이션을 편하게 세팅하는 방법"
date: 2007-10-08 15:20:34
categories: service
tags: google
author: Samgu Lee
header:
  og_image: /assets/google-apps-partnership-with-domain-corp.jpg
---

구글 애플리케이션(Google Apps)은 구글의 CEO인 에릭 슈미츠가 강력하게 드라이브를 거는 엔터프라이즈 서비스로, 자신의 도메인에서 메일, 웹페이지, 메신져, 캘린더, 오피스 그리고 시작페이지를 구성할 수 있는 강력한 웹 기반 솔루션으로, 팔글에서도 몇번 소개를 한 적이 있다.

![구글과 제휴한 도메인 회사의 설명](/assets/google-apps-partnership-with-domain-corp.jpg)

구글 애플리케이션은 이미 유료화를 마친 상태이고, 파트너 참여를 허용함으로서 구글 서비스가 제공하지 않는 것을 몇가지 제공하고 있다.(하지만, 세일즈 포스에 비하면 아직 갈 길은 먼 것 같다)

구글 애플리케이션에서의 진입장벽이라면 도메인 연결이라고 할 수 있다. 구글 애플리케이션을 세팅할 때 가장 어려워 하는 것은 이메일의 MX레코드와 CNAME이다. 이 모두 일반인에겐 상당히 생소한 단어일 것이고, 급기야 구글 애플리케이션의 파트너 서비스 중에 [구글 애플리케이션 설치 서비스](http://www.google.com/enterprise/gallery/apps/smallbiz_services.html)가 있을 정도.

이런 불편함을 해소하기 위해서 구글은 기존의 제휴사였던 고대디와는 별도로 [두개의 도메인 회사와 제휴](http://googleenterprise.blogspot.com/2007/10/new-program-for-domain-registrars-web.html)를 했다고 공식 블로그에서 알려왔다.

우선 네임닷컴(name.com)의 경우 신규 도메인 등록 기준으로 1년에 5.99달러, 도메인사이트닷컴(domainsite.com)은 7.99달러로 기존의 제휴사인 고대디에 비해 같거나 더 저렴하다. 두 곳 모두 서비스 내용은 대동소이하다.

위의 두 곳에서 도메인을 등록하면, 별다른 설정 없이 구글 애플리케이션 설정을 구성할 수 있다.

한편, 국내의 파워유져들은 구글 애플리케이션을 사용하기 위해서 도메인 주소(DNS) 관리 서비스로 [DNSEver](http://www.dnsever.com)를 사용하는데, DNSever의 경우 CNAME 설정이 구글 애플리케이션과 충돌이 나는 경우가 있다. A 레코드를 이용해서 강제로 연결해주는 방법이 있지만, 그것은 구글이 추천하는 방법이 아니다.(팔글은 [ZoneEdit](http://www.zoneedit.com)를 사용한다)

국내에서는 마이크로소프트와 제휴를 해서 이와 같은 서비스를 하는 경우가 있는데, 예를 들어서, 가비아의 경우 윈도우즈 라이브의 커스텀 도메인을 이용해서 고객에게 무료 웹메일 서비스를 제공하기도 한다.
