---
layout: single
title:  "Google AJAX 검색 API 공개"
date:   2006-06-02 10:41:49
categories: service
tags: google search api
author: Samgu Lee
---
Google은 MS가 유닉스와 OS/2를 꺽은 똑같은 방식으로 인터넷 비지니스를 진행하고 있습니다. 즉, 개발자를 포용하기 위해서 웹서비스의 API들을 대규모로 공개하고 있는데, 이번의 공개 API는 매력적인 Google의 네가지 검색 AJAX버젼입니다.

Google의 많은 서비스 중에서도 가장 핵심이라면 역시 검색입니다. Google은 다른 서비스는 RSS의 출력화면을 제공하지만, 유독 검색만은 공개하지 않았습니다. 또한, 파싱이라는 검색결과를 다듬어서 뿌려주는 웹사이트도 사용권 위반이라는 이유로 허용하지 않았습니다.

[AdSense API의 공개][adsense-api-launched]에 이은 [이번 API](http://code.google.com/apis/ajaxsearch/)는 RSS문서 자체를 받아오는 것은 아니라서 다소 매력은 떨어지지만 일반적인 웹퍼블리셔들에게는 상당히 매력적인 서비스입니다. 간단한 스크립트의 추가만으로 Google의 네가지 검색을 AJAX형태로 자신의 웹사이트에 올릴 수 있습니다.

## Google AJAX 검색의 네가지

구글은 최선을 다해 검색결과를 단순화시키는 연구를 진행했습니다. 네이버나 다음처럼 섹션별 검색결과를 보여주지 않고 검색어에 따라서 여러가지 형태의 검색결과를 보여줍니다. 하지만, 이번 API는 네가지의 독립된 검색결과를 보여줄 수 있고, 웹게시자 선택에 따라서 네가지 중 일부만 선택해서 보여줄 수 있습니다.

![Google AJAX 검색 API의 사례](/assets/google_search_ajax_sample.png)

[그림](http://www.google.com/uds/samples/options.html)에서 볼 수 있듯이 네가지 검색결과는 이렇습니다.

1. 로컬 검색(Google Maps)
2. 웹 검색
3. 비디오 검색
4. 블로그 검색

팔글 블로그의 우측에 이미 적용해 놓았는데 블로그 검색으로 맞추어 놓았습니다. 또다른 동영상 블로그에는 비디오 검색으로만 맞추어져 있으니 직접 눈으로 확인하면 금방 이해가 갈 것입니다.

## 알아야 할 것들

팔글에서 테스트 해 본 결과로는 꽤 만족스러운 작동을 보이고 있지만, 몇가지 사항은 적용 전에 알고 있어야 합니다.

1. Google AJAX 검색을 이용하기 위해서는 키를 발급받아야 한다. 키는 웹사이트 주소로 인증이 되고 특별한 개인정보는 받지 않는다.
2. 현재의 버젼은 0.1이며, 잘 돌아가긴 하지만, 버젼 1.0이 되면 광고가 들어간다고 한다.
3. 모든 브라우져에서 작동되는 것은 아니며, Firefox, Safari, and IE 6에서 작동된다.
4. 국가 및 언어 설정이 없기 때문에 언어 설정이 반드시 필요하다면 AdSense 프로그램에서 제공하는 사이트 검색을 이용하는 것이 좋다.
5. 자바스크립트 코드로 이루어져 있기 때문에 Blogger 같은 스킨을 편집할 수 있는 블로그툴 이외의 서비스형 블로그에서는 사용할 수 없다.

[adsense-api-launched]: {% post_url 2006-06-01-adsense-api-launched %}
