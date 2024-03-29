---
layout: single
title: "차세대 RIA는 과연 Ajax가 될것인가?"
date: 2007-03-27 09:34:42
categories: opinion
tags: ria ajax development
author: Samgu Lee
header:
  og_image: /assets/combination-flash-and-ajax-in-google-finance.jpg
---

차세대 RIA로 플래시, 자바스크립트 중 최종 승자는 누가 될까요?

RIA(Rich Internet Application)이라는 용어는 광고에서 주로 사용되었다. 인터넷 초창기 때는 회선이 느렸기 때문에 텍스트 위주의 홈페이지가 주를 이루었지만, 광고에서 만큼은 모션이 들어가야 했기 때문에 선두적인 광고 에이젼시들은 움직이는 광고물을 제작했고, 그 때 적당한 용어가 필요했기 때문에 나온 말이 RIA라고 할 수 있다. 당연하겠지만, 이 용어는 플래쉬의 개발사인 매크로미디어(현재 어도비에 인수됐다)가 만든 용어이고, 현재 RIA가 다른 의미로 사용되는 경우도 있기 때문에 광고에서는 리치 미디어(Rich Media)라는 용어를 사용한다.

아무튼, 현재의 RIA는 컴퓨터에서 실행되는 프로그램과 비슷한 분위기를 풍기는 웹서비스를 지칭한다. 어떤 것이 RIA냐 하는 논쟁은 그다지 큰 의미가 없을 것이다. 일반적으로 링크를 클릭했을 경우 다른 화면이 나오지 않는 서비스를 RIA라고 말한다.

RIA라는 말이 매크로미디어에서 나온 이후, 시맨틱웹이라는 용어가 등장하고, 서비스로서의 차세대 웹을 말하면서 어떤 형태로 진화될 것인가에 대한 열띤 토론이 이어졌고, 구글 맵이 나오기 전까지는 플래쉬가 Ajax보다 앞서있었다. 그 이유는 몇가지가 있다.

우선, 플래쉬는 전세계 대부분의 컴퓨터에 깔려있고, 플랫폼을 가리지 않기 때문에 매우 편하다. 게다가 멋지기까지 하다. 또하나의 장점은 괜찮은 언어(엑션 스크립트)를 지원하고, 괜찮은 성능의 디버거를 제공하며, 많은 디자이너의 지지를 받고 있다는 점이다. Ajax와 비교해서 우월한 점은 셀 수 없을 정도로 많다.

하지만, 현재 RIA 도구로 Ajax는 플래쉬를 넘어서는 지지를 받고 있다. Ajax로 웹서비스를 개발하는 것은 그야말로 대단히 고통스러운 일임에도 불구하고, 많은 개발자들은 Ajax를 배우기위해 열을 올리고 있다. 똑같은 서비스를 플래쉬로 더 멋지게 제작한다 할지라도 Ajax로 하찮게 제작할 경우 사용자는 더 많은 찬사를 보내기도 한다. 게다가 포탈같은 서비스 전문 업체들은 플래시를 완전히 포기하는 듯한 인상을 풍기고 있다. 도대체 왜 이런 현상이 일어나는 것일까?

구글만 놓고 본다면, 구글 서비스에서 플래쉬가 사용되는 곳은 비디오 플래이어와 구글 파이넨스의 차트 부분 밖에 없다. 나머지는 Ajax를 사용하고 있다. 구글이 플래쉬를 적극적으로 지원하지 않는 이유를 찾는다면 아마도 정책적인 부분일 것이다. 구글의 기술정책은 다른 사람이 만들어 놓는 프로그램은 사용하지 않는다. 구글 대부분의 서비스는 모두 자체제작된 것들이고, 따라서 어이없을 정도로 형편없는 서비스를 내놓는 경우도 종종 있다.

![구글 파이넨스의 차트는 플래쉬를 사용한다](/assets/combination-flash-and-ajax-in-google-finance.jpg)

구글의 Ajax 지원 이후에 정말 많은 기업들이 Ajax를 따라하기 위해 최선을 다하고 있다. 야후는 자사의 이메일 서비스를 Ajax를 이용해서 아웃룩과 비슷한 형태로 만들었다.(이것도 플래쉬로 만들었다면 별다른 이슈가 되지 않았을 것이다)

왜 플래쉬를 제치고 Ajax가 선두에 서게 되었는지 팔글에서도 알 수가 없다. 이 문제에 대한 해답은 몇가지 예제를 통해 힌트를 얻을 수도 있을 것이다.

## Flash vs Ajax (Maps, Cart and OS)

- Google Maps http://maps.google.com
- Flash Earth http://www.flashearth.com
- swiffCart https://www.swiffcart.com
- highfdvd http://www.hidefdvd.com
- eyeos.org http://eyeos.org/demo/desktop.php
- snowMaker http://www.withsnow.net
- Lanzlo Mail http://www.laszlomail.com/lzmail/
- Yahoo Meta Beta http://mail.yahoo.com/
