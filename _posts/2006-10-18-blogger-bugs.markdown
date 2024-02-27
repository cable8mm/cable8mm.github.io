---
layout: single
title: "또다시 구글 블로거(Google Blogger) 해킹"
date: 2006-10-18 01:42:01
categories: news
tags: google blogger
author: Samgu Lee
---

구글의 블로깅 서비스 블로거(Blogger) 버그로 보이는 글이 사라지는 현상이 알려졌습니다.

[구글 공식 블로그가 해킹]({% post_url 2006-10-09-blogger-hacked-in-detail %})당한지 얼마 되지 않아서, 블로거(Blogger) 버그로 보이는 이유로 또다른 글이 블로거 버즈 블로그(구글 공식 블로그 중 하나)에 올라왔고, 이에 대한 소식을 구글 블로고스피어 운영자인 필립 렌슨(Philipp Lenssen)에 의해 알려졌습니다. 글은 이미 삭제되었습니다.

블로거(Blogger)는 구글에서 운영하는 서비스형 블로그 툴로, 구글의 모든 공식 블로그들이 블로거로 운영되고 있고, 현재는 베타버젼을 테스트하고 있으며, [구글 데이터 API]({% post_url 2006-04-21-gdata-means %})를 이용한 포스팅을 시험서비스하고 있습니다. 예전 블로그 해킹은 해커에 의해 그럴싸한 글이 블로그에 올라와 논란이 됐는데, 이번의 경우는 메인 블로그는 아니고, 블로거 버즈라는 블로거의 단편적인 소식을 전하는 구글의 예외적인 공식 블로그입니다.

팔글에선 이 글을 구글 리더(RSS 리더)로 받아보았는데, 글 내용이 이상해서 원본으로 접속을 했으나 삭제되어 있었습니다.

![삭제된 블로거 버즈, 구글 리더로 본 모습](/assets/erase_blogger_buzz.jpg)

필립 렌슨은 이 글의 스크린샷을 [자신의 블로그](http://blog.outer-court.com/archive/2006-10-17-n72.html)에 포스팅 했습니다.

![블로거 버즈 해골 이야기](/assets/blogger-buzz-sugar-skulls.jpg)

필립 렌슨은 해킹 보다는 블로거 API의 버그가 원인으로 보고 있는데, 그 근거로 블로거 데이터 API 커뮤니티에 [다음과 같은 글](http://groups-beta.google.com/group/bloggerDev/browse_frm/thread/bd8da9c78a32b7c4)이 올라와 있습니다.

    Maximal
    Hi, I am making tests with Google Data API to publish my posts.
    The problem is - my posts are being published into the Honourable Dr
    Mantombazana Tshabalala-Msimang South Africa's Minister of Health" blog
    (I don't have to say I am not the minister of health of South Africa).
    Any help before Honourable Minister of Health of South Africa would
    speak with Interpol would be apreciated.

구글 데이터 API를 이용해서 글을 올렸는데, 엉뚱한 블로그에 글이 올라가 있다는 내용입니다.

현재 마이그레이션 중인 [이글루스](http://happyseeker.tistory.com/35)도 그렇지만, 구글의 블로거도 수난시대라고 할 수 있겠습니다. 공지없는 삭제는 한국 회사의 절대신공 중 하나인데, 구글도 비슷해지는 걸까요?
