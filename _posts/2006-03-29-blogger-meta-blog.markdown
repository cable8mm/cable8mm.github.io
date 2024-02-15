---
layout: single
title:  "한글 Blogger 업데이트 알림 서비스 개시"
date:   2006-03-29 08:49:29 +09:00
categories: service
tags: google
author: Samgu Lee
---
Ralrara님에 의해서 blogspot.com의 URL을 사용하는 한글 블로그 전문 메타블로그가 등장했습니다. 전문 사이트는 아니지만 상위 100개의 글을 보여주고, 검색 결과는 구글 블로그 검색을 이용했다고 합니다.

[구글 블로그 검색][google-blog-search]은 일반 검색과는 매우 다른 특성이 있고, 크롤러도 독립적으로 작동됩니다. 구글 블로그 검색 크롤러는 RSS만을 따라가고, 크롤러 이외에 weblogs.com과 같은 블로그 핑 사이트에서도 정보를 받아옵니다. 그 속도가 구글 웹 검색에 비해서 매우 빠릅니다.

Ralrara님은 구글 블로그 검색을 이용해서 한글로 된 blogspot.com URL을 쓰는 블로그만 전문으로 수집하는 [블로그](http://koreanupdate.blogspot.com/)를 개설했습니다. 다음은 [Ralrara님의 블로그](http://ralrara.blogspot.com/2006/03/blogger.html)에 올린 이 서비스를 만들게 된 이유입니다.

> 가끔 블로그 오른쪽 위에 있는 &#8216;NEXT BLOG≫&#8217; 버튼을 눌러서 랜덤으로 다른 블로그들을 보곤 한다. 네이버 같은 곳과는 달리 성의있는 블로그가 많고, 또 외국인들이다 보니 호기심에 꽤나 자주 이용하고 있다.
> 
> 그런데 지금까지 저 기능을 사용해 오면서 한글 블로그를 본 적은 딱 한 번뿐이다. 그것도 한국인이 아니라 한글을 배우는 외국인의 블로그였다. 기쁜 마음에 코멘트도 한 개 남겨줬다.
>
> 그리고 그외엔 단 한 번도 한글로 된 블로그를 보지 못했다. 이건 마치 외국의 길거리에 혼자 서 있는 듯한 느낌과 비슷하다. 아무리 NEXT BLOG를 눌러도 외국어만 나오니 마치 내 주변을 외국인들이 둘러싸고 있는 듯한 느낌이다.

Ralrara님이 만드신 서비스는 다음과 같은 주소를 보기 좋게 보여준 것입니다.

    http://blogsearch.google.com/blogsearch_feeds?hl=ko&c2coff=1&as_eq=&lr=lang_ko&filter=0&q=blogurl:blogspot.com&ie=utf-8&num=100&output=atom

위의 코드는 한글(lr=lang_ko)로 된 blogspot.com 도메인(blogurl:blogspot.com)의 블로그를 유니코드(ie=utf-8)로 100개(num=100)의 글을 atom 피드(output=atom)로 출력하라 라는 의미입니다.

실제로 RSS와 같은 피드리더에 위의 주소를 넣으면 Ralrara님의 블로그와 동일한 결과를 얻을 수 있습니다.

그렇더라도 피드 리스트를 이용해 커뮤니티를 만들려는 첫 시도는 놀랍지 않을 수 없네요. 많은 분들이 격려의 말을 덧글로 남기고 있습니다.

## blogspot이란?

구글이 무료로 제공하는 blogspot은 한국에서 매우 느리게 작동하기 때문에 한국에서 쓰기에는 매우 불편합니다. FTP를 이용해서 설치형 블로그처럼 만들 수도 있지만, 블로그의 스킨을 바꾼다던지 할 경우 상대적으로 많은 시간이 걸리는 단점이 있습니다.

그럼에도 불구하고, 피카사나 구글 툴바와의 연동이 편하게 되어 있기 때문에 입소문으로 한국 사용자는 늘어가고 있습니다.

via &#8211; [mwultong Blog](http://mwultong.blogspot.com/2006/03/bloggercom-blogger.html)

[google-blog-search]: {% post_url 2006-01-11-google-blog-search %}