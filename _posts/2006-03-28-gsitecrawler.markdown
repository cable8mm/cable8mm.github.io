---
layout: single
title: "구글 사이트맵 자동 생성 프로그램 소개"
date: 2006-03-28 13:34:01
categories: service
tags: google
author: Samgu Lee
header:
  og_image: /assets/sitemap_generator.jpg
---

블로그나 게시판을 이용해서 웹사이트를 꾸미는 분에게는 플러그인을 쓰는 것이 훨씬 편하겠지만, 업데이트가 자주 일어나지 않는 웹사이트의 경우는 구글에서 요구하는 사이트맵을 만들기가 꽤 귀찮은 일이 됩니다.

구글이 파이썬용 소스는 배포를 하지만 프로그램이 따로 있으면 편하겠죠. 그래서 소개합니다. 윈도우용 사이트맵 자동생성기입니다.

정확한 프로그램 이름은 "GSiteCrawler"입니다. 글 쓰는 당시의 최신 버젼이 1.06 빌드 251입니다. 자체 크롤러 여섯마리가 내장되어 있어서 URL을 넣으면 링크를 쫓아가면서 사이트맵 파일을 만들어 줍니다. 사용법은 매우 간단해서 URL 넣고 sitemap파일을 받아내면 됩니다.

프로그램은 무료이며, 비쥬얼 베이직을 이용해서 제작했기 때문에 프로그램 용량이 좀 큰 편입니다. 또한, 설치 후 재부팅을 해야 합니다.

프로그램을 구동시켜보면 아시겠지만, 꽤 잘 만들어져 있습니다. 여러 사이트를 동시에 관리할 수 있고, 크롤링 할 페이지의 확장자를 지정할 수도 있습니다.(jpg나 gif 등의 그림은 크롤링할 필요 없겠죠?) 또한, 404에러(페이지가 없을때를 말합니다.) 시에도 크롤링 여부를 지정할 수 있습니다. 처음엔 그냥 디폴트 상태에서 URL만 넣으면 알아서 긁어오는 모습을 볼 수 있습니다.

![윈도우용 사이트맵 생성기](/assets/sitemap_generator.jpg)

익숙해지면 FTP가 내장되어 있어서 자동으로 업로드를 할 수도 있고 모든 진행을 자동화시켜서 프로젝트파일을 만들 수도 있습니다. 한글도 지원하는군요 :-)

사이트맵 생성기가 없어서 포기하신 분들은 빠른 시간에 자신의 웹사이트의 구글 사이트맵 파일을 만들 수 있습니다.

프로그램은 ["The SOFTplus GSiteCrawler Google Sitemap generator"](http://johannesmueller.com/gs/)에서 받으실 수 있습니다.
