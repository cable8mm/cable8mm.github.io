---
layout: single
title: "원하는 웹페이지의 페이지랭크(PR) 알기"
date: 2006-04-05 05:30:02
categories: tip
tags: google
author: Samgu Lee
redirect_from:
  - /2006/04/05/live_pagerank/
---

페이지랭크는 구글의 검색 순위에서 가장 중요한 [포지션을 차지하는 변수]({% post_url 2005-12-02-how-to-know-what-page-rank-is-my-website %})입니다. 야후 웹검색에서도 사용되고 있는데, 원하는 웹페이지의 페이지랭크를 쉽게 알려주는 웹사이트를 소개합니다.

구글은 웹검색을 위한 73개의 데이터센터를 운영하고 있습니다. 빅데디라고 불리우는 대규모 인덱스 업데이트가 있게 되면 73개의 데이터센터의 페이지랭크가 틀릴 수가 있습니다. 구글 툴바를 설치한 후 웹사이트 페이지랭크가 시간마다 변하는 것이 바로 이때문입니다.

소개할 [Live PageRank](http://livepr.raketforskning.com/)이라는 웹사이트는 73개의 페이지랭크 전부를 보여줍니다. 그리고, 페이지의 랭크를 알려주는 아이콘도 제공하는데 이 부분은 구글에서 막아버려서 더이상 지원되지는 않고 있습니다.(팔글글에서도 우측 상단에 페이지랭크 아이콘을 추가한 적이 있습니다.)

![73개의 페이지랭크를 보여주는 Live Pagerank](/assets/live_pagerank.jpg)

원클릭으로 알 수 있는 링크를 만들 수도 있는데, http://livepr.raketforskning.com/?u=referer 라는 URL로 링크를 만들면 됩니다. 예를 들어서,

```html
<a href=”http://livepr.raketforskning.com/?u=referer”>페이지랭크 보기</a>
```

라는 식으로 링크를 만들면 원클릭으로 73개의 페이지랭크를 볼 수 있습니다.

빅데디가 어제와 오늘에 걸쳐서 적용되었기 때문에 페이지랭크가 많이 바뀌었네요.
