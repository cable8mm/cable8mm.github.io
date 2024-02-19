---
layout: single
title:  "구글, 개발자 포용 정책에 손대나?"
date:   2006-12-22 10:07:40
categories: opinion
tags: google developer
author: Samgu Lee
---
외부 개발자 포용정책으로 열렬한 지지를 얻었던 구글이 최근들어 정책 변화의 조짐이 보이고 있다.

구글은 자사의 서비스 해킹을 즐길 정도의 여유가 있었다.(물론, 검색과 광고 등 핵심 사업은 허용되지 않는다.) 구글 맵의 API가 나온 것도 맵 서비스를 해킹해서 새로운 서비스를 만든 해커 때문이었다. 하지만, 구글은 공식적으로 검색 결과를 해킹할 수 있는 API를 중지해 버렸다.

중지 후 [공식 블로그](http://google-code-updates.blogspot.com/2006/12/beyond-soap-search-api.html)에 공지를 했으나, 많은 블로거들은 지금까지 나온 검색 해킹에 관한 서적이 쓸모 없어 졌다면서 우려를 표시했고, 차니님도 이에 대해 구글이 변하는 것이 아니냐는 [글](http://channy.tistory.com/112)을 블로그에 올리기도 했다.

하지만, 이 부분은 구글의 외부 접속을 [GData](http://code.google.com/apis/gdata/codesearch.html)라는 프로토콜로 통합한다는 면에서 서비스 자체를 사용하지 못하는 것은 아니었다.

ZDNET 블로거 가렛 로저스는 최근 구글 맵 API의 약관이 바뀐 사실을 알려왔다.

약관 변경에 있어서 눈여겨 보아야 할 사실은 구글 맵 API를 이용할 수 있는 횟수가 제한되었다는 사실이다.

> 1.6 Geocode Requests. There is a limit of 50,000 geocode requests per day per Maps API key. This translates to roughly one geocode request every 1.73 seconds. If you exceed this 24-hour limit, the Maps API geocoder may stop working for you temporarily. If you continue to abuse this limit, your access to the Maps API geocoder may be blocked permanently.

변경된 [약관](http://www.google.com/apis/maps/terms.html)에 의하면 하루 5만번의 요청이 넘을 경우 일시적으로 사용이 중지된다는 내용이다.

과거 네이버가 자사의 검색 API를 공개할 당시 하루 최대 쿼리 갯수를 제한했다는 이유로 몇몇 개발자에게 원성을 산 바 있었다. 그 당시 비교되었던 회사는 바로 구글. 구글은 검색 쿼리 제한이 물론 있기는 하지만, 그 외의 서비스에는 접속 제한이라는 것이 없다.

현재 구글의 서비스에 접속하기 위해서는 GData 프로토콜을 이용하던지, 아니면 구글이 제공하는 자바스크립트 코드를 이용해야 한다. 완성된 자바스크립트 코드를 이용하는 것은 편하긴 하지만, 개발자에겐 많은 제약을 주게 된다. 게다가 구글 맵은 횟수 제한이 생겼기 때문에 상용 서비스를 만든다는 것은 구글과 계약을 하지 않으면 힘들게 되었다.

과거 구글 맵 API의 약관엔 광고가 나올 수도 있다는 내용은 있었지만, 개발자들은 이를 그다지 중요하게 생각하지 않았다. 그리고, 구글은 횟수 제한을 하지 않겠다는 듯한 발언을 하기도 했다.

이번 사건을 바라보는 개발자들은 구글의 이번 제한 조치로 인해서, 타사의 데이터나 API를 이용한 상용서비스 제작이 과연 안전할까 라는 의구심을 갖을 수 밖에 없게 되었다.

반면 기업 입장에서는 API를 공개를 어디까지 할 것인가에 대해서 고민하지 않을 수 없게 되었다. 네이버나 다음이 OpenAPI를 공개하긴 했지만, 이를 이용한 흥미로운 서비스들은 거의 출현하지 않고 있다. 반면, 위젯이나 가제트와 같은 모듈화된 서비스 이용이 오히려 낳다고 생각할 수도 있다.

오픈 API는 어떻게 될까?
