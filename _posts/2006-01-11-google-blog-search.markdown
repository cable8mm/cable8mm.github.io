---
layout: single
title: "블로그 검색이 힘들면 구글 블로그 검색으로..."
date: 2006-01-11 04:21:31
categories: service
tags: google search
author: Samgu Lee
header:
  og_image: /assets/google_blog_search.jpg
---

이 글을 보는 여러분들이 만약 블로거라면 블로그만을 검색해 주는 서비스를 진심으로 바랄 것입니다. 현재 한국에는 블로그를 검색해주는 서비스가 여럿 존재하지만, 모든 블로그를 검색하는 서비스는 아직까지 출현하고 있지 않습니다.

열린 검색이라는 [엠파스](http://search.empas.com/ob_search.html)와 [첫눈](http://blog.1noon.com/)이 블로그를 검색해 주지만 그것은 포탈이나 이글루스같은 특정서비스를 이용하는 블로그만을 검색해주고, 설치형 블로그를 사용하는 유저의 글은 검색대상이 아닙니다. 그나마 유일하게 다음의 RSS넷이 외부의 블로그를 검색하게 만드는 유일한 창구입니다만, 원론적인 접근차원에서 본다면 RSS넷은 아이디어는 매우 좋지만, 서비스 디자인 측면에서 본다면 어느성도 한계가 있습니다.

블로그 검색은 일반 웹문서 검색과는 많은 부분에서 차이가 납니다. 기본적으로 웹문서를 제작하는 사람은 서버를 직접 제어할 수 있는 권한이 있는 것으로 보기 때문에 robots.txt같은 파일이나 특정한 파일을 심음으로서 본인인증이 가능합니다. 하지만 블로그같은 경우 독립게시판에 글을 쓰는 것과 비슷하기 때문에 이 글이 검색되게 만들지 아닐지를 선택하는 마땅한 방법이 없습니다. 따라서, 현재까지 나온 방안 중 타당성있는 것은 RSS나 ATOM 같은 프로토콜을 이용해서 검색이 되게 할지 아닐지를 판별하는 것입니다.

일단 저작권에 대해서 위의 방법이 타당하다면, 검색엔진 입장에서는 블로그 검색은 XML형태로 제공하기 때문에 웹검색에 비해서 매우 빠른 속도로 인덱싱을 할 수 있습니다. 더군다나 블로그는 서버핑이라는 서비스도 있기 때문에 블로거가 새 글을 올릴 경우 그 사실을 검색서버에 자동으로 알려줄 수도 있습니다. 이런 서비스는 웹에서는 웹사이트 소유자가 검색서버에 업데이트 사실을 알린다는 면에서 본다면 구글 사이트맵과도 비슷합니다.

![구글 블로그 서치 메인화면](/assets/google_blog_search.jpg)

## 구글 블로그 서치를 사용하는 방법

구글 블로그 서치는 네가지 방법으로 사용이 가능합니다.

- blogsearch.google.com에 접속하는 방법
- search.blogger.com에 접속하는 방법
- blogger.com의 관리자모드에서 이용하는 방법
- 블로거 스팟 블로그에서 최상단 메뉴에 있는 검색창을 이용하는 방법

사용방법은 생긴것이 비슷한 것처럼 구글 웹서치와 매우 흡사합니다. 다만, 고급옵션에서 차이가 나게 되는데, RSS를 이용해서인지 제목, 게시자, 날짜 등으로 검색을 할 수 있습니다.

구글 웹서치에서 제공하는 site:나 link:등과 같은 오퍼레이터를 구글 블로그 서치에서도 사용할 수 있습니다. 다음은 지원되는 오퍼레이터입니다.

- link:
- site:
- intitle:
- inblogtitle:
- inposttitle:
- inpostauthor:
- blogurl:

## 구글 블로그 서치에 내 블로그를 나오게 하려면?

구글 블로그 서치에 나오려면 여러분의 블로그가 RSS나 ATOM같은 사이트 피드(site feed)를 지원해야 하고, Weblogs.com같은 업데이트 서비스 사이트에 자동으로 핑을 보내주어야 합니다. 현재까지 구글 블로그 서치는 웹서치같은 인덱스에 수동으로 추가하는 입력페이지가 존재하지 않습니다. 따라서, 사이트 피드를 지원하는 서비스에 자신의 블로그를 등록시키는 방법밖에는 없습니다.

일단 구글 블로그 서치의 인덱스에 여러분의 블로그가 추가되었다면, 구글 블로그 서치는 주기적으로 업데이트를 하게 됩니다. 만약 자동으로 사이트 피드를 weblogs.com과 같은 회사에서 핑으로 알려준다면 구글 블로그 서치에 바로 적용되게 됩니다.

## 그 외에 구글 블로그 서치로 무엇을 할 수 있나?

구글 블로그 서치는 검색 결과의 RSS와 ATOM과 같은 피드를 검색 결과 하면의 최하단에 제공합니다. 또한, 구글 오퍼레이터나 고급검색을 이용하면 여러분들의 블로그에 링크를 한 블로그나 여러분의 이름으로 게시된 글만을 찾을 수 있습니다.

구글 블로그 서치가 웹서치와 다른 가장 큰 점은 업데이트 속도가 훨씬 빠르다는데 있습니다. 블로그는 블로그 엔진에서 업데이트를 서버에 알려주는 것이 일반적이므로, 거의 실시간으로 검색이 됩니다.

현재까지는 구글 블로그 서치와 구글 웹서치는 전혀 별개로 작동하고 있습니다. 따라서, 블로그 서치에서 검색이 된다고 해도 웹서치에서 검색이 된다는 보장은 없습니다. :-)

## Update 20060216

워드프레스같은 외국계 블로그 프로그램은 기본설정에 핑을 보내도록 하기 때문에 따로 설정하지 않아도 구글 블로그에서 검색이 됩니다.

국내 블로그 프로그램이나 핑을 지원하지 않는 포탈사이트에서 제공하는 블로그 등은 FEED를 만들어주는 Feedburner.com의 서비스를 이용하면 알아서 weblogs.com로 핑을 쏘아 주기 때문에 Google 블로그 검색을 이용할 수 있습니다. 피드버너 관련 내용은 [아크몬드님](http://vista.archmond.com/)이 알려주셨습니다. 감사~! :-)
