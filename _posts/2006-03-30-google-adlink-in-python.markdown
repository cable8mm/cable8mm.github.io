---
layout: single
title: "또하나의 구글 광고, 애드링크"
date: 2006-03-30 08:48:36
categories: news
tags: google
author: Samgu Lee
header:
  og_image: /assets/google_adlink_in_python.jpg
---

Garett Rogers은 ZDNET에서 구글이 테스트하고 있는 구글 연관된 링크(Google Related Content)를 소개했습니다. 팔글에서 또하나의 증거를 발견할 수 있었는데 바로 [파이썬 공식 웹사이트](http://www.python.org/)입니다. 테스트 된 웹사이트 둘 다 재밌게도 개발자를 위한 곳입니다.

팔글에선 구글 데스크탑에서 작동할 수 있는 간단한 프로그램을 만들기 위해서 파이썬 웹사이트를 방문했습니다. 그 곳에서 재미있는 것을 발견할 수 있었는데, [Garett Rogers이 소개했던 연관 링크](http://blogs.zdnet.com/Google/?p=126)입니다.

자바스크립트로 임베드되어 있는 이 코드는 컨텐츠에 맞는 링크들을 메뉴와 함께 보여주기 때문에 한개의 단어만을 링크하는 상품인 애드센스의 링크단위를 패키지로 묶은 느낌입니다.

이 코드는 [Michael Nguyen](http://www.socialpatterns.com/search-engine-marketing/google-related-content-adlinks/)는 애드링크라고 명칭을 붙였는데 공식 명칭은 아니지만 매우 편해서 몇몇 블로그가 이 명칭을 사용하고 있습니다.

애드링크는 [Vivi’s developer blog](http://www.vivi.ro/blog/?p=182)에 나온 이후로는 다른 웹사이트에서는 발견되지 않다가 파이썬 공식 웹사이트에서 발견되었습니다. 같은 코드이고, 색깔만 파이썬 웹사이트 색깔에 맞게 조정되었습니다.

![파이썬 공식 웹사이트의 구글 애드링크](/assets/google_adlink_in_python.jpg)

애드링크는 자바스크립트 코드 자체에는 아무런 키(올린 이가 누구인지 알려주는 열쇠)가 없습니다. 하지만, 모든 링크에 키가 나타나게 됩니다. 예를 들면,

```html
http://www.googlesyndication.com/relcontent/searchclick?client=ca-rlu-python-org-468x60_rc&type=2&redir_url=http://www.google.com/search%3Frcu%3D2RLU%26hl%3Den%26q%3DJython
```

위의 코드에서 진한 부분이 바로 파이썬의 키값이 되고, 이것은 자바스크립트 코드에는 포함되지 않지만, 링크에 연결되어 있습니다. 클라이언트 키값에서 ca는 애드센스의 접두어이고, 끝의 rc는 개발용이라는 뜻으로 보입니다.

현재까지 애드링크는 공식적으로 테스트를 하고 있지는 않습니다. 공식적인 테스트로 알려진 구글 애드센스로는 [피드를 위한 애드센스][adsense-for-feed-beta] 뿐입니다. 그 외에 비공식적으로 [비디오를 위한 애드센스][google-videoad-test]가 테스트되고 있기도 합니다.

참고적으로 구글에서 쓰는 개발 언어는 많이 쓰는 순서대로 C++, 파이썬, 자바라고 합니다. 파이썬은 구글에서 많이 사용되는 언어로 알려져 있으며, 파이썬의 창조자 Guido가 [구글에 입사](http://eminency.egloos.com/2042951)하기도 했습니다.

[adsense-for-feed-beta]: {% post_url 2006-02-07-adsense-for-feed-beta %}
[google-videoad-test]: {% post_url 2006-02-28-google-videoad-test %}
