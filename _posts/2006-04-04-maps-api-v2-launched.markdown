---
layout: single
title:  "구글 공식 블로그, 구글 맵스 API 버젼 2 공개"
date:   2006-04-04 05:27:43 +09:00
categories: news
tags: google maps
author: Samgu Lee
---
맵스 API라고 불리우는 구글 맵스 API의 버젼 2가 공식적으로 런칭되었다고 [공식 구글 맵스 블로그](http://googlemapsapi.blogspot.com/2006/04/google-maps-api-version-2.html)에서 알려왔습니다. 몇가지의 작고 큰 변화가 있으며, 약관도 긍정적으로 바뀌었습니다.

맵스 API는 구글 소속이 아닌 개발자에게 구글 맵스의 데이터를 이용해서 서비스를 만들 수 있는 툴을 말합니다. 이삼구글에서도 맵스 API를 이용한 [매쉬업 서비스][google-mesh-up-3]들을 소개한 적이 있고, [웹페이지에 지도 넣는 법][googlemaps-insert-myweb]을 소개한 적도 있는데 맵스 API가 드디어 버젼 2를 런칭했습니다.

바뀐 것은 자바스크립트 파일이 1/2 정도로 줄어들었고, 몇가지의 클래스들이 추가되었으며, GMap 클래스를 더욱 확장한 GMap2 클래스가 생겼습니다. 그 밖에 메모리 릭을 줄이는 등의 최적화 작업이 있었다고 합니다. 여기에 대한 자세한 내용은 [버젼 2 문서](http://www.google.com/apis/maps/documentation/)를 참고하세요.

기술적인 내용 이외에 약관이 변경되었습니다.

> *  No page view limits. Your site can get as many page views as you can muster. If, however, your site gets more than 500,000 page views per day, we ask that you talk to us before you launch so that we can prepare in advance to handle your traffic.  
> * 90-day notice before any advertising-related change. The Maps API does not include advertising. If we ever decide to change this policy, we will give all developers at least 90 days' notice via this blog.

하루 페이지뷰 제한이 5만회에서 무제한으로 풀렸습니다. 그리고, 만약 광고가 들어갈 경우 90일 전에 알려준다고 하네요.

자바스크립트 코딩은 디버깅이 상대적으로 쉽지 않아서 제작하는데 까다로운 면이 있지만, 구글에서 제공하는 맵스 API는 문서화도 꽤 잘 되어 있는 편입니다. 이삼구글에서 가까운 시일내에 간단명료한 서비스를 만들어보겠습니다. :-)

[google-mesh-up-3]: {% post_url 2006-03-29-google-mesh-up-3 %}
[googlemaps-insert-myweb]: {% post_url 2006-02-02-googlemaps-insert-myweb %}
