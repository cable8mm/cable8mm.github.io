---
layout: single
title: "구글의 연관링크에 이은 야후의 임베딩 Y!Q"
date: 2006-04-05 03:08:06
categories: tip
tags: google yahoo
author: Samgu Lee
---

급속히 몰락중인 야후에서 구글의 대항 서비스가 론칭되었습니다.

[구글의 연관링크(Related Links)][google-related-links-launch]가 정식으로 구글 랩스에 리스팅 된 몇일 되지 않아서 야후에서도 비슷한 서비스인 임베딩 Y!Q라는 2005년 <ins datetime="2006-04-05T05:01:24+00:00">2월부터 시작한 </ins>서비스<del datetime="2006-04-05T04:58:34+00:00">를 시작했습니다</del><ins datetime="2006-04-05T04:58:34+00:00">가 있습니다</ins>. 사용법은 구글의 연관링크와 마찬가지로 자바스크립트 코드를 HTML에 넣기만 하면 됩니다. 하지만, 현재 결과값이 나타나진 않고 있습니다.

구글의 연관링크는 뉴스, 웹페이지 그리고 검색 이렇게 세가지의 결과를 탭을 이용해서 보여주고 있습니다.(댄스 비디오 포드캐스트의 우측에 예시로 넣어놓았습니다.) 야후의 임베딩 Y!Q는 검색결과만을 보여주지만, 두가지 옵션 즉 인라인과 컨텐츠라는 형식을 지원합니다.

인라인은 한 라인에 이어서 넣을 수 있습니다. 예를 들어서 인라인 코드를 사용하면 문장 중간에 자연스럽게 야후의 검색을 넣을 수 있습니다.

구글의 연관링크와는 다소 차이가 있습니다. 이 형태는 단어에 숨은 광고 링크를 적용하는 [Vibrant Media의 광고 상품인 IntelliTXT](http://www.vibrantmedia.com/site/web_01a.html) 와 매우 흡사하고, 야후 뉴스에 적용되어 있는 것과 같은 형태입니다.

## 사용방법

1. 웹페이지의 헤드태그(head)에 다음과 같은 자바스크립트를 삽입합니다.

```html
<script
  language="javascript"
  type="text/javascript"
  src="http://yq.search.yahoo.com/javascript/yq.js"
></script>
```

2. 원하는 문단을 선택합니다.

3. 태그와 폼을 이용한 Y!Q Form을 삽입합니다.

이 서비스는 웹 퍼블리셔들의 입맛에 옵션을 바꿀 수 있습니다. 더 자세한 사항은 [퍼블리셔를 위한 Y!Q 페이지를 참고](http://yq.search.yahoo.com/publisher/embed.html)하세요.

via - [SEW](http://blog.searchenginewatch.com/blog/060404-074457)

Update - [Y!Q: Adding Context to Search](http://www.ysearchblog.com/archives/000074.html), 이 서비스는 2005년 2월부터 서비스되었습니다. 지나가다님 감사합니다.

[google-related-links-launch]: {% post_url 2006-04-04-google-related-links-launch %}
