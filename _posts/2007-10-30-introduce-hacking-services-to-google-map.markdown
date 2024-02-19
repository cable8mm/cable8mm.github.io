---
layout: single
title:  "구글 맵의 해킹 서비스들을 소개합니다"
date:   2007-10-30 00:55:55
categories: gossip
tags: googlemap hacking
author: Samgu Lee
---
팔글에서는 [구글 디벨로퍼 나이트][google-developer-night-and-google-map]의 맵 API 섹션에서 발표자였던 크리스 아테나시오(Chris Atenasio)에게, 현재 구글 맵을 API를 쓰지 않고 해킹하는 서비스들에 대해서 질문을 한 바 있다. 그리고, 당시 두개 정도의 사이트가 아직까지 정상적으로 운영되고 있다고 언급했다.

![맵인과 윙버스](/assets/mapin-and-wingbus.jpg)

이들 서비스는 구글에서 제공하는 맵 API를 사용하지 않고, 맵 데이터를 직접 접속해서 플래쉬로 가져오고, 그 지도를 독립적으로 콘트롤하는 방식으로 사용하고 있다. 지도 데이터를 직접 콘트롤하는 가장 큰 이유는 여러가지가 있겠지만, 구글 맵 API 자체가 구글이 제공하는 것이기 때문에 사용상 한계가 있기 때문이다.

지도 데이터를 직접 콘트롤하는 웹사이트는 예전에도 소개한 적이 있던 [플래쉬 어스(Flash Earth)](http://www.palgle.com/2006/02/23/flash_earth/)라는 서비스로, 현재 버젼에서는 마이크로소프트와 야후, 애스크, 나사 그리고 오픈 레이어의 위성지도 전체를 네이게이션 해 주는데까지 발전했다.

이 서비스가 나온 시기가 2006년 2월이었으니 구글이 이런 서비스를 시연용으로는 용인해 준다는 의미가 있다.

구글 맵을 해킹한 또다른 사이트는 한국에서 여행정보를 제공하고 있는 [윙버스](http://www.wingbus.com/)와 [맵인](http://www.mapin.co.kr/)이라는 서비스. 이 두개의 서비스 모두 플래쉬로 구글 맵의 데이터를 활용하고 있고, 구글 맵 API는 전혀 쓰지 않는다.

![구글 맵을 해킹한 서비스 중 하나인 윙버스](/assets/google-map-in-wingbus.jpg)

![맵인, 구글 맵 해킹 서비스](/assets/google-map-in-mapin.jpg)

이런 서비스를 매쉬업이라고 해야할 지는 확신이 서질 않지만, 구글이 이런 식의 서비스를 강제로 막지는 않는다는 것은 현재까지 맞는 말인 것 같다.

하지만, 해킹을 하지 않고 서비스를 하려는 회사들도 생기고 있다. 이 부분에 대해서는 다시 언급할 기회가 있을 것이다. 한편, 현재까지 구글 맵의 엔터프라이즈 유료 서비스는 아시아에서는 제공되지 않는다.

[google-developer-night-and-google-map]: {% post_url 2007-10-17-google-developer-night-and-google-map %}