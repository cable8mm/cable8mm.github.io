---
layout: single
title: "구글의 오픈소스정책, Ajax에 올인"
date: 2007-03-25 07:07:08
categories: opinion
tags: google api ajax
author: Samgu Lee
header:
  og_image: /assets/open-ajax-logo.jpg
---

구글이 Ajax를 처음 만든 기업은 아니지만, 구글 맵의 성공적인 론칭 이후로 OpenAPI 정책은 OpenAjax로 [급격하게 이동]({% post_url 2006-12-22-google-change-developer-policy %})하고 있다.

![OpenAjax 연합 로고](/assets/open-ajax-logo.jpg)

구글의 OpenAPI정책은 검색 결과를 웹서비스 형태로 오래전부터 지원되고 있지만, 현재 OpenAPI의 모든 지원은 끊긴채 OpenAjax 정책을 강력하게 지원하고 있다.(OpenAPI 부분은 GData라는 데이터 관련 프로젝트로 대체되고 있다)

최근, 구글은 [OpenAjax의 연합 프로젝트](http://www.openajax.org/)에 가입했다는 사실을 [공식 블로그](http://google-code-updates.blogspot.com/2007/03/joining-openajax-alliance.html)를 통해 알려왔다. 이 프로젝트에는 일반인에게도 익숙한 썬 마이크로시스템즈, 오라클, 아이비엠, 마이크로소프트 등이 가입되어 있다.

OpenAPI와 OpenAjax의 차이는, 전자는 프로그래머를 위한 외부 함수(API)를 지원한다면, 후자는 API 제공업체가 완성된 서비스 모듈을 제공하는 점이 다르다. OpenAjax는 일반인도 쉽게 코드를 복사하기만 하면 기본적인 기능을 사용할 수 있기 때문에 최근의 경향으로는 Ajax가 API보다 널리 사용되고 있다. 최근 [네이버](http://openapi.naver.com/index.nhn)와 [다음](http://dna.daum.net/)에서 OpenAPI 정책을 [지원]({% post_url 2006-03-27-google-naver-apis %})하고 있지만, 사용되는 경우가 그리 많지는 않는 것 같다.

OpenAPI의 경우 제작 의도 자체가 외부 개발자들을 지원하기 위한 것이지만, OpenAjax의 경우 자사의 서비스를 다른 홈페이지에 끼워 넣으려는 의도가 있다라고 본다면, 과연 Open이라는 용어를 쓸만한 가치가 있는 서비스인지는 고민해 보아야 할 문제일 것이다.
