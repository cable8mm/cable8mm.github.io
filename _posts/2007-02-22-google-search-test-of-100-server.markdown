---
layout: single
title:  "구글의 100번 서버 검색 테스트"
date:   2007-02-22 05:11:20 +09:00
categories: opinion
tags: google search
author: Samgu Lee
---
구글은 약 70개의 데이터센터를 보유하고 있고, 대부분 그들은 같은 알고리즘을 사용하기 때문에 시기의 차이는 있지만 기본적으로 검색결과가 같다. 하지만, 구글은 새로운 기능을 테스트할 때 한두개의 데이터센터에만 적용을 하는 경우가 있는데, 최근 [Google Operation System 블로그](http://googlesystem.blogspot.com/2007/02/plus-boxes-new-way-to-look-at-search.html)에 따르면 100번 서버(72.14.207.100 - 현재는 )에서 흥미로운 기능을 볼 수 있다.

이번에 추가된 기능으로 검색결과에 구글 파이넨스의 결과를 숨김기능을 이용해서 노출해 준다. 공식적인 명칭은 정해지지 않았지만, 플러스 표시가 있다고 해서 "플러스 박스(Plus Box)"라고도 부르고, URL에 manybox가 표시된다고 해서 매니박스(ManyBox)라고도 부른다. 아무튼, 100번 서버에 접속해서 "[phone company](http://72.14.207.100/search?hl=en&q=phone+company&btnG=Search)"로 검색해 보자.

![구글 플러스 박스](/assets/100-server-test-in-google-search.jpg)

위의 그림은 phone company로 검색한 후 플러스 아이콘을 클릭했을 때의 결과 화면이다. IBM과 같이 특정 기업을 검색하면 플러스 아이콘 없이 바로 첫검색어에 주식 관련 데이터가 노출된다.

이 데이터는 구글 파이넨스의 것을 차용하기 때문에 구글 파이넨스에 등록되지 않은 한국 증시의 경우는 노출되지 않지만, 부분적인 한글화는 진행되어 있으므로, 한글로 설정한 후 [접속](http://72.14.207.100/search?hl=ko&q=IBM&btnG=%EA%B2%80%EC%83%89&lr=)한다면 플러스 아이콘 설명이 한글이라는 사실을 알 수 있다.

![구글 플러스 박스 한글판](/assets/100-server-test-in-korean.jpg)

한글판의 경우 기업 데이터가 영문이기 때문에 기업 요약과 링크만을 제공한다.

구글은 박스를 이용해서 검색결과를 손상시키지 않는 선에서 여러가지 서비스를 테스트하고 있으며, 동시에 한국에서 흔히 사용되는 부분별 검색도 [별도의 검색엔진]({% post_url 2006-10-03-searchmash-launched %})을 이용해서 테스트하고 있다.
