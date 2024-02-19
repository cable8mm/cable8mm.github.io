---
layout: single
title:  "구글 뉴스 검색 AJAX API 공개"
date:   2007-02-11 10:31:35
categories: service
tags: google news api
author: Samgu Lee
---
구글은 공식 블로그를 통해 두가지 검색바가 [론칭](http://googleajaxsearchapi.blogspot.com/2007/02/adding-google-news-and-book-search.html)됐다고 알려왔다.

![구글 AJAX 검색 바 론칭](/assets/google-ajax-bar-example.jpg)

구글의 OpenAPI 정책은 소프(SOAP)나 XMLRPC 같은 웹서비스 방식에서 AJAX를 이용한 자바스크립트 방식으로 [교체]({% post_url 2006-12-22-google-change-developer-policy %})된 후, 구글 코드에는 적지 않은 수의 [공개 코드가 론칭]({% post_url 2006-06-02-google-ajax-search %})된 바 있다. 하지만, 앞서 발표된 서비스는 스크립트에 HTML을 수정해야 했기 때문에 그다지 효용가치가 없었다. body 태그에 스크립트를 추가해야 한다면, 기능이 마음에 들더라도 태그 수정으로 망설일 수 밖에 없다.

하지만, 최근의 뉴스 검색 AJAX API는 원하는 위치에 스크립트를 추가하는 것만으로 재미있는 기능을 구현할 수 있다.

한편, 상단의 뉴스바를 만드는 데에는 1분도 걸리지 않는다. 이른바 마법사 기능으로 가능한데, 마법사를 이용하면 고유키를 자동으로 생성해 주기도 한다.

사용 방법은 간단하다. 뉴스바의 [마법사 페이지](http://www.google.com/uds/solutions/wizards/newsbar.html)에 접속한 후 키워드와 서비스 할 인터넷 주소를 넣으면 자동으로 자바스크립트 코드가 생성되는데, 그 코드를 원하는 위치에 넣으면 된다.

뉴스바와 같이 공개된 검색바에는 [북 서치 바](http://www.google.com/uds/solutions/wizards/bookbar.html)도 있지만, 구글 도서 검색이 현재까지 한글을 제대로 지원하지 않기 때문에 한국에서 쓸 일은 없을 것이다.
