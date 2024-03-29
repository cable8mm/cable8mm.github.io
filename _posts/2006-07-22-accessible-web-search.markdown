---
layout: single
title: "구글(Google)의 웹 접근성 좋은 문서 검색"
date: 2006-07-21 16:36:16
categories: tip
tags: google search
author: Samgu Lee
---

구글 검색을 서비스하고 있는 구글에게 웹 접근성이란 무엇을 의미할까요?

떡이떡이님이 구글 랩스(Google Labs)의 새로운 서비스인 Accessible Web Search에 대한 [소개글](http://itviewpoint.com/tt/index.php?pl=1641)을 포스팅 해 주셨습니다. 보통 Accessible을 '접근성 좋은'이라고 해석하기도 하는데, 웹 접근성이라는 것이 일반적으로 XHTML+CSS로 이루어진 웹페이지를 의미합니다. 딱히 두개의 의미가 같은 것은 아니지만, XHTML+CSS이라는 것이 접근성을 염두에 둔 가이드라인이기 때문입니다.

그런데, 재미있는 사실은 정작 구글 자신은 접근성이 좋은 웹에 대해서 지금까지는 그다지 우등생이라고 볼 수는 없습니다. 구글은 웹브라우져 별로 다른 페이지들을 보여주는 것이 지금까지의 서비스 형태입니다. 따라서, 한번 만들면 여러가지 브라우져로 볼 수 있게 한다는 접근성과는 차이가 있습니다.

이것은 두개의 구글 검색 HTML을 봐도 알 수 있습니다.

기존의 구글 웹검색은 TABLE 태그로 구성되어 있고, 이번에 나온 Accessible Web Search은 XHTML+CSS로 코딩 되어 있는데, 그나마 코드를 보면 어설프다라는 느낌마져도 들게 됩니다.

브라우져 별 호환성, 버젼별 하위 호환성, 그리고 접근성 등을 모두 포함하는 페이지를 만드는 것은 힘들기도 하고, 어떤 것을 포기해야 할 경우도 있기 때문에 이 문제는 꼭 구글이 잘못했다 라고 할 수도 없긴 합니다.

참고로, 이 서비스는 한글 검색을 지원하지 않습니다. 그리고, 여러가지 검색 옵션도 없는 말 그대로 검색어를 넣고 결과를 보는 정도가 구현되어 있습니다.

그리고, 재미있는 것이 이 서비스의 도움말을 보면 말 그대로 최고의 접근성을 보이고 있습니다. 제목을 위한 H태그와 본문의 P태그만을 사용했습니다.
