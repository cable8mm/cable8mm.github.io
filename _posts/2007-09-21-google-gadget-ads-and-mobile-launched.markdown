---
layout: single
title:  "구글 가젯 광고 론칭과 모바일용 애드센스 추가"
date:   2007-09-21 01:50:15
categories: service
tags: google adsense
author: Samgu Lee
---
이번 주에 구글 광고에 대한 커다란 업데이트가 있었다. 가젯 광고와 [모바일용 애드센스](http://adsense.blogspot.com/2007/09/here-comes-mobile.html)가 그것인데, 모바일용 애드센스는 현재 한국을 제외한 13개의 국가에서 론칭했다.(중국과 일본이 추가되었지만, 한국은 적용되지 않았다.) 국내 사정상 모바일용 애드센스가 국내에 적용되기까지는 오랜 시간이 걸릴 것 같다.

![모바일용 애드센스와 구글 가젯 광고](/assets/google-mobile-and-gadget-ad.gif)

한편 [구글 가젯 광고](http://www.google.com/adwords/gadgetads/)는 기술적인 구글의 몇가지 기술이 더해져서 굉장한 가능성을 보여주고 있는 또하나의 [프로젝트로 탄생](http://adsense.blogspot.com/2007/09/introducing-google-gadget-ads.html)되었는데, 구글 가젯 광고의 완성도는 상당히 높은 것으로 보인다. 구글 가젯 광고의 리뷰와 기술적인 내용을 알아보도록 하자.

구글 가젯 광고를 이용하게 되면 광고주는 기존의 문맥광고나 이미지, 동영상, 플래쉬 광고의 정해진 규격만을 이용할 수 있던 것을 그 이상으로 확대할 수 있다. 가젯은 일반적으로 HTML과 자바스크립트로 만들어지는데, 이 말은 사용자와의 동적인 관계를 갖게 만드는 광고창을 만들 수 있다는 의미다. 국내에서도 몇개의 선도적인 업체가 위젯 광고를 기업에 보급하고 있는데, 이를 구글의 시스템과 융합되었다.

구글 가젯 광고에 적용된 눈에 띄는 기술은 캐슁과 유튜브 스트리밍, 다른 서비스(구글 맵이나 구글 체크아웃)와의 연동, 그리고 구글 가젯 광고 에디터 이렇게 네가지. 특히 [구글 가젯 광고 에디터](http://www.google.com/ig/modules/gadgetads.html)는 구글의 개인화 서비스인 아이구글에 내장되었다. 이 에디터는 간단한 저작과 에러 추적 기능을 제공하고, 구글의 스토리지를 이용해서 웹상에서 가젯을 생성 및 저장할 수 있다.

구글의 다른 서비스와의 연동은 당연한 것인데, 캐슁과 유튜브 스트리밍은 대단히 흥미롭다.

우선 캐슁의 경우, 구글에 파일을 전송하지 않아도 특정 자바스크립트 코드를 이용하면 구글의 캐슁 서버에 자동으로 등록된다. 캐슁 서버는 1,2시간에 한번씩 파일을 받아서 구글의 캐싱 인프라를 통해서 사용자에게 보여지게 된다. 실제 작성된 코드를 보면 이해가 쉬울 것이다.

```js
_IG_RegisterOnloadHandler(function() {
    _gel("mainTbl").style.background = "transparent url(" + _IG_GetImageUrl("http://www.labpixies.com/gadgads/adsense/images/background.gif") + ") 0px 0px no-repeat";
    _gel("logo").src = _IG_GetImageUrl("http://www.labpixies.com/gadgads/adsense/images/logo.jpg");
    _gel("splashText").src = _IG_GetImageUrl("http://www.labpixies.com/gadgads/adsense/images/ad0.gif");
});
```

이 코드는 현재 구글 애드센스 블로그에 예제로 나와있는 구글 애드센스 관련 가젯 광고의 코드 중 일부이다. 아주 간단한 내용인데, www.labpixies.com이라는 도메인에 올라와 있는 gif와 jpg로 된 이미지를 _IG_GetImageUrl이라는 함수로 불러오는 내용.

![구글 가젯 광고 에디터의 팔글 RSS](/assets/palgle-in-google-gadget-ad.gif)

그리고, Fetch 계열의 함수를 이용하면 실시간으로 다른 서버의 내용을 받아와서 처리할 수 있다. 예를 들어서, _IG_FetchFeedAsJSON 함수를 이용하면, 내 블로그의 RSS글들을 구글 가젯 광고 안에 넣을 수 있다. 좌측 그림은 구글 가젯 광고 에디터를 이용해서 팔글의 RSS 광고를 간단하게 만든 모습.

이와 별개로 구글 비디오가 아니라 유튜브의 스트리밍이 캐슁의 용도로 구글 가젯 광고에 적용된 모습도 이채롭다. 구글 가젯 광고주가 비디오를 광고에 삽입하고 싶다면 비디오 파일을 서버에 저장해야 한다. 구글 캐슁 인프라는 동영상 파일을 저장하진 않는데, 대신 유튜브에 동영상을 올려서 가젯 광고에 사용할 수 있다.

구글 가젯의 [사용 설명서](http://www.google.com/adwords/gadgetads/tutorial.html#video)를 바탕으로 한다면, 유튜브 플래이어를 사용할 수도 있지만, 자신만의 비디오 플래이어를 만들어 유튜브 동영상을 플래이 할 수도 있다고 한다.

이론적으로 가젯 광고를 이용하면 문맥이나 비디오 광고를 모두 대체할 수 있다. 가젯 광고는 처음 정해진 광고의 크기를 제외한 모든 엑션이 가능하기 때문이다.

구글 가젯 광고의 [갤러리](http://www.google.com/adwords/gadgetads/gallery.html)를 방문하면 실제 어떻게 광고가 적용되는지를 볼 수 있다.

구글 가젯 광고료는 사용자가 가젯 내에서 하는 엑션에 대해서는 요금이 부과되지 않으며, 원하는 주소로 이동했을 때 발생하고, 과금 체계는 기존 애드워즈와 동일하다.([가젯 광고 비용은 얼마나 됩니까?](https://adwords.google.com/support/bin/answer.py?answer=74802&topic=12549) 참고)

구글 가젯 광고는 현재까지 애드워즈의 모두에게 적용되는 것은 아니고, 리치 콘텐트(동영상이나 플래쉬 광고를 말함)로 광고를 진행해 본 적이 있는 광고주에게만 초대 메일이 발송된다고 한다.
