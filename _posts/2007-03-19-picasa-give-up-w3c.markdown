---
layout: single
title:  "피카사, 웹표준 포기"
date:   2007-03-19 02:50:18
categories: service
tags: google picasa
author: Samgu Lee
---
구글이 웹표준을 지키지 않는다는 것은 널리 알려진 사실이다. [차니님의 블로그](http://channy.creation.net/blog/?p=283)에 따르면, 웹표준이란 표준 스펙을 잘 지키는 것 뿐만 아니라 구조적 마크업(XHTML)과 표현 및 레이아웃(CSS) 및 사용자 행위 제어(DOMScripting)를 잘 분리하는 고급 홈페이지 구축 방식을 의미한다. 웹표준에 대한 명확한 정의는 월드와이드웹 컨소시움(W3C)이라는 비영리단체에서 만들고 있다. 한글로 웹표준이라고 번역되지만, 현재 사용하는 CSS와 XHTML로 웹문서를 작성하는 것의 명확한 용어는 [권고](http://www.w3.org/2004/02/Process-20040205/tr#RecsW3C)(Recommendations). 일반적으로 버젼에 상관없이 HTML이나 XHTML은 그 자체로 표준(standard)이라고 부르고 있다.

영어권 국가에서 어떤 용어가 사용되건간에 한국에서 웹표준이라고 하면 차니님의 정의에 따른다고 볼 수 있다. 그렇지만, 구글의 경우 초창기부터 웹표준에 무관심했기 때문에 웹디자이너가 존재하지 않는다는 [루머](http://chanky.nhnlab.com/5)에 시달리기도 했다. 구글의 대표적 서비스인 구글 검색의 코드는 여전히 HTML을 사용하고 있다.

최근 구글의 피카사팀은 사진 앨범을 내 블로그나 홈페이지로 옮길 수 있는 코드를 DIV 태그를 사용한 표준양식에서 테이블로 바꾸어버렸다.

바뀌기 전 코드와 바뀐 후의 코드를 비교해 보자.

이전

```html
<div style=”height:194px;background:url(http://picasaweb.google.com/f/img/transparent_album_background.gif) no-repeat left”>
```

현재

```html
<table style=”width:194px;”><tr><td align=”center” style=”height:194px;background:url(http://picasaweb.google.com/f/img/transparent_album_background.gif) no-repeat left”>
```

일반적으로 DIV태그를 이용한 방법은 웹표준과 부합하지만, 브라우져의 하위호환성이나 다른 양식의 표준 웹문서 양식과 충돌하는 경우가 있다. 예를 들어서, 과거의 표준양식으로 제작한 웹문서에 현재의 표준양식의 문서를 끼워넣는다면(회사 끼리의 제휴와 같은 실무에서는 이런 일이 자주 일어난다) 제대로 표시되지 않는다.

웹표준에 상대적으로 신경을 쓰지 않는다는 구글도 최근의 구글 웹 애플리케이션 [최신판](http://www.palgle.com/2007/02/22/google-apps-enterprise-launched/)에선 웹표준에 부합하는 훌륭한 코드를 선보이고 있다.

![구글 웹 애플리케이션의 대쉬보드는 훌륭한 웹표준 코드를 선보였다](/assets/google-apps-is-perfect-on-xhtml.jpg)

한편, 피카사 웹 앨범은 최근의 업데이트로 [검색]({% post_url 2007-03-11-google-picasa-web-album-updated-half %})과 [사진인화]({% post_url 2006-03-23-picasa-op %})가 가능해졌다.
