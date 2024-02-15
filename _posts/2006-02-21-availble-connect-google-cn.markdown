---
layout: single
title:  "중국판 구글 접속방법"
date:   2006-02-21 04:02:54 +09:00
categories: tip
tags: google gmail
author: Samgu Lee
---
구글 중국(google.cn)은 외국에서 접속이 차단되어 있습니다. 한국에서는 직접 구글 중국을 접속하게 되면 강제적으로 한국이나 미국 구글로 리다이렉트 됩니다. 간단한 구글 중국에 접속방법을 소개합니다.

주소창에 구글 중국(http://www.google.cn)을 넣으면 구글닷컴으로 리다이렉트가 되는데 간단한 방법으로 중국에 서비스되는 구글을 볼 수 있습니다.

## 1. 처음 접속 주소를 바꾸기

구글 중국에 google.cn으로 접속하지 말고 http://www.google.cn/webhp?hl=zh-CN의 주소로 접속을 하면 검열된 구글 중국을 경험할 수 있습니다.

## 2. 서핑 도중 중국의 검색 결과를 보기

현재 페이지의 중국판 검색 결과를 보기 위해서는 주소를 수동으로 바꾸어주어야 합니다. 먼저 구글 주소를 google.cn으로 바꾸고 끝에 ?hl=zh-CN을 추가하면 됩니다.

예를 들어서 http://images.google.co.kr/images?hl=ko&#038;q=tiananmen&#038;btnG=Google+%EA%B2%80%EC%83%89&#038;lr=lang_en%7Clang_ko 라는 주소는 구글 한글페이지에서 천안문의 영문표기인 tiananmen으로 검색한 결과의 주소입니다. 이 주소에서 co.kr을 cn으로 바꾸고 hl=ko를 zh-CN으로 바꾸면 구글 중국의 검색결과를 볼 수 있습니다.

![구글 중국와 구글 한국의 검색결과 비교](/assets/how_to_google_china.jpg)

## 3. christian langreiter가 만든 비교페이지를 이용하기

구글 미국과 구글 중국의 [검색결과를 비쥬얼하게 나타나는 페이지](http://www.langreiter.com/exec/google-vs-google.html)를 christian langreiter가 제작했습니다. 검색어만 넣으면 검색 순서가 도트로 나오고 마우스를 올리면 주소가 나오게 됩니다. 더불어 검색결과가 어떻게 변했는지 화살표로 표시도 해 줍니다.

구글이 구글 중국의 접속을 막은 방법은 첫페이지를 아파치에서 리다이렉트 시킨 것으로 판단되고 그 것은 첫페이지의 주소만 적용됩니다. 즉 하부페이지는 영향을 미치지 않는다는 뜻으로, 첫페이지를 피해가는 다른 모든 방법으로 접속을 할 수 있습니다.

참고적으로 프록시를 써서 외국 아이피로 접속을 한다고 해도 국내와 별반 차이가 없습니다.
