---
layout: single
title: "프린팅닷컴, 구글 검색결과에서 삭제"
date: 2006-03-31 04:43:00
categories: news
tags: google
author: Samgu Lee
header:
  og_image: /assets/printing_banned.jpg
---

예전에 [BMW 독일 웹사이트가 Blackhat SEO로 구글 검색에서 완전히 삭제되었다는 내용][bmw-doorway]을 알려드렸는데, 이번에는 프린팅닷컴(printing.com)이 히든링크로 인해서 구글 검색에서 완전히 삭제되었습니다.

BMW는 자바스크립트를 이용해서 검색엔진과 일반 접속을 다르게 보여주는 방법으로 검색엔진 최적화를 시도했었지만, 이번의 경우는 방법이 매우 간단합니다.

배경색과 글자색을 똑같게 해서 링크를 보이지 않게 만들었고, 결과적으로는 검색엔진과 사람이 다르게 인식할 수 있도록 첫페이지를 꾸몄습니다. 이런 검색 최적화로 인해서 구글 검색엔진에서 전혀 페이지가 나오지 않게 되었습니다.

![히든링크를 이용한 검색 최적화](/assets/printing_banned.jpg)

위의 그림에서 최하단 빨강색 박스는 실제 눈에 보이지 않습니다. 마우스를 드래그 해서 화면 캡쳐를 한 것입니다.

이 사실을 알아낸 [Chris Porter](http://www.questio.co.uk/blog/google-bans-printingcom)은 48개의 구글 데이터 센터 모두에서 프린팅닷컴의 인덱스가 삭제되었다는 사실을 알아냈습니다.

이 글을 쓰는 현재까지 프린팅닷컴의 히든링크는 제거되지 않고 있습니다. 히든링크를 보이게 하던지 아예 삭제하지 않으면 구글 검색에 검색되지 않을 것입니다.

via - [questio](http://www.questio.co.uk/blog/google-bans-printingcom)

[bmw-doorway]: {% post_url 2006-02-11-bmw-doorway %}
