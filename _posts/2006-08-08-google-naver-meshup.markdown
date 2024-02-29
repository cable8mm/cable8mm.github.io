---
layout: single
title: "구글 맵(Google Maps)과 네이버 지도 매쉬업"
date: 2006-08-08 08:12:30
categories: service
tags: google naver map
author: Samgu Lee
header:
  og_image: /assets/google_naver_meshup.gif
---

네이버의 지도 API가 나온지 얼마 되지 않아 김유승님이 NGMAP이라는 자바스크립트 매쉬업 코드를 발표했습니다. 이 코드는 네이버 지도와 구글 맵을 클릭으로 전환할 수 있고, 적절하게 좌표와 배율까지 전환됩니다.

구글의 경우는 좌표 관련된 API가 존재하지만, 네이버 지도 API의 경우 좌표와 관계된 API는 아직 제공하지 않습니다. 공식적으로 제공 의사가 없다는 것을 약관에 명시해 놨지만, 비공식적인 글(덧글같은 것)로 좌표 API를 추가한다는 의사를 나타냈습니다.

그럼에도 불구하고, 김유승님은 간단하지 않은 좌표 변환을 자바스크립트로 만들어 냈습니다.

이 스크립트는 구글 맵의 API와 네이버 지도 API를 동시에 사용하고 있으며, DIV태그의 hidden 속성을 이용해서 네이버가 나타났다면 구글 맵에 좌표와 배율을 전달해주고 네이버를 숨기고 구글 맵을 활성화 시킵니다. 반대의 경우는 거꾸로 하면 되겠죠.

자바스크립트 소스의 상당부분이 좌표 변환과 관계가 있습니다.

![구글과 네이버의 지도 매쉬업](/assets/google_naver_meshup.gif)

[김유승님의 NGMAP 바로가기](http://9eye.net/tt/entry/NGMap-v05)
