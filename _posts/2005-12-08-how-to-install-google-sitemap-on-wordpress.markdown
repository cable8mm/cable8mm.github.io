---
layout: single
title:  "워드프레스에 구글 사이트맵을 설치해보자"
date:   2005-12-07 15:00:38
categories: service
tags: google sitemap wordpress
author: Samgu Lee
---
필요한 기능은 플러그인으로 많은 프로그램이 오픈소스로 개발되어있는 공개 설치형 블로그 툴인 [워드프레스(wordpress)](http://www.wordpress.org/)의 플러그인을 이용해서 [구글 사이트맵 제네레이터(google sitemap generator)를 설치](http://www.arnebrachhold.de/2005/06/05/google-sitemaps-generator-v2-final)해 봅시다.

구글 웹서치에 URL을 보내는 방법은 [URL을 스파이더(크롤러라고도 함)에 알리는 페이지](http://www.google.com/addurl/?continue=/addurl)에 홈페이지(보통 웹사이트의 의미로 사용되지만, 여기선 사전적 의미인 웹사이트 첫페이지를 말함) URL을 알려주거나, [구글 사이트맵](https://www.google.com/webmasters/sitemaps/login)을 이용하는 것 이렇게 두가지 방법이 있습니다.

구글 사이트맵의 도움말을 보면 다음과 같은 글로 사이트맵의 장점을 설명하고 있습니다.

> Google Sitemaps를 통해 웹 크롤링을 경험할 수 있습니다. Google은 Sitemaps를 사용하여 Google 크롤러에 사이트를 알려서 사이트가 검색되도록 함으로써 웹 검색 범위를 넓히고 검색 속도 및 Google 색인에 페이지가 추가되는 속도를 향상시켜 보시길 바랍니다.

즉, 구글 사이트맵을 이용하면 설사 인터넷에 전혀 링크가 걸려있지 않은 페이지도 URL을 직접 전송함으로서 조금 더 엑티브한 인덱싱이 가능하고, 구글 사이트맵이 크롤링하기 전에 직접 웹마스터가 전송할 수 있으므로 색인 추가의 속도가 향상될 수 있습니다.

워드프레스의 구글 사이트맵 제네레이터 관련 플러그인은 몇종류가 나와있지만, 가장 완성도가 높다고 보여지는 프로그램은 워드프레스를 위한 [구글 사이트맵 제네레이터 V2.0 파이널버젼](http://www.arnebrachhold.de/2005/06/05/google-sitemaps-generator-v2-final)입니다.(현재 [2.5 버젼이 제작중](http://www.arnebrachhold.de/2005/06/15/google-sitemap-generator-for-wordpress-25)이라고 합니다.)

워드프레스의 다른 플러그인 처럼 플러그인 폴더에 복사하고 플러그인 페이지에서 활성화를 시키면 설정탭에 Sitemap메뉴가 추가됩니다. 기본 설정으로 Rebuild 버튼을 누르면 루트에 sitemap.xml파일이 생성됩니다.(예를 들어 구글매니아 블로그의 경우라면 http://www.palgle.com/sitemap.xml파일이 생성됩니다.)

그 밖에 워드프레스로 만든 페이지가 아닌 것들도 하단의 옵션부분에서 추가할 수 있습니다. 이미 구글 사이트맵을 사용하고 있는 사용자는 간편하게 XML파일을 추가할 수 있습니다.
