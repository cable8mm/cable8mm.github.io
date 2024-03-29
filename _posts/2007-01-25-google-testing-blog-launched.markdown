---
layout: single
title: "구글 테스팅 공식 블로그 론칭"
date: 2007-01-25 03:53:16
categories: service
tags: google testing
author: Samgu Lee
header:
  og_image: /assets/test-in-toilet.jpg
---

구글의 기업 시스템을 주의깊게 본다면, 마이크로소프트와 비슷한 면을 보게 된다. 유일하게 틀린 점이라면 아마도 마이크로소프트는 판매를 통해 수익을 얻고, 구글은 광고를 통해 얻는 정도일 것이다. 물론 마케팅적인 면은 많이 다르긴 할 것 같다.

![구글 테스트 블로그 그림](/assets/test-in-toilet.jpg)

마이크로소프트의 기업 성장을 소설처럼 다룬 책인 "싸우는 프로그래머"를 보면, 테스팅과 빌드를 전문으로 하는 팀이 어떻게 만들어졌는지에 대한 과정이 상세하게 다루어진다. 책에서도 알 수 있듯이, 일반적으로 개발자는 자신의 코드에 대한 테스트를 외부에 맞기는 것을 상당히 꺼려한다. 주석과 메뉴얼을 만들어야 하고, 때로는 직접 설명까지 해야되기 때문이다. 아마도 가장 중요한 것은 자존심과 관련된 문제이기 때문일 것이다.

아무튼, 구글도 마이크로소프트가 했던 것 처럼 테스팅을 전문으로 하는 팀을 만들었고, [공식 블로그](http://googletesting.blogspot.com/2007/01/introducing-testing-on-toilet.html)를 론칭했다.

구글이 어떻게 서비스를 테스팅하는가에 대한 자료는 이미 여러 블로그를 통해 알려져 있고, 팔글에서도 트러스트 테스트의 존재를 알린바 있다. 구글이 마이크로소프트의 테스팅과 다른 몇가지 증거가 있는데, 구글의 테스트는 사용자의 피드백을 전폭적으로 지지한다는 점이다. 구글 이전의 기업은 일반적으로 자사의 엄격한 테스트를 거치고, 정해진 사용자에게 최종적인 테스트를 맞긴다. 아마도 전세계에서 가장 강력한 내부 테스팅 프로그램을 운영하고 있는 기업은 IBM일 것이다. IBM은 씽크패드라는 노트북을 만들 당시, 150종류나 되는 테스팅 프로그램 레퍼런스를 운영한 바 있다.

구글의 테스팅 프로그램은 계속 진화하고 있다. 작년엔 직원의 가족이나 친구들에게 테스트를 맞기는 [트러스트 테스트]({% post_url 2006-03-09-trusted-tester-faq %})를 진행한 바 있고, 쿠키를 이용한 [사용자 테스트]({% post_url 2006-04-26-verify-google-test %})도 진행한다. 최근의 추세라면 같은 서비스 두개를 만들어 진행하고, 버그가 모두 수정되면 기존 시스템을 새로운 시스템으로 마이그레이션 시키는 방법을 사용한다. [구글 블로거]({% post_url 2006-08-15-blogger-beta %})와 [구글 그룹스]({% post_url 2007-01-25-google-groups-out-of-beta %})가 이와 같은 방식으로 새로운 서비스를 론칭한 바 있다. 그 밖에 구글은 시스템에 사용자 반응을 연구하기 위한 알바도 운영하고 있다.

구글의 시스템을 제대로 알기 위해서는 두가지 부분, 즉 돈과 관련이 있는 검색, 광고, 모바일과 돈과 관련이 없는 그 밖에 모든 서비스를 분리해서 생각할 필요가 있다. 테스팅도 마찬가지인데, 검색과 광고, 모바일 쪽의 테스트는 일반인에게 전혀 공개되지 않는다. 새로 론칭한 테스팅 블로그는 수익 외의 서비스에 대한 테스팅을 목적으로 하고 있다.

구글이 테스팅을 일반인에게 공개하는 것 자체가 더 좋은 시스템을 만들기 위해서 일지도 모르지만, 아마도 구글이 추구하고 있는 입소문 마케팅을 위한 것일지도 모른다.

구글이 마케팅을 위해서던 아니던 관계없이 구글 내부의 정보를 외부인이 볼 수 있다는 점은 다른 기업에서는 쉽게 찾아보기 힘든 정보이니만큼 환영할 만한 일이다.
