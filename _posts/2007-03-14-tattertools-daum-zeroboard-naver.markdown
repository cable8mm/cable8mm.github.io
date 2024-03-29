---
layout: single
title: "다음이 태터툴즈라면, 네이버는 제로보드"
date: 2007-03-14 03:42:36
categories: opinion
tags: daum tattertools naver zeroboard
author: Samgu Lee
header:
  og_image: /assets/zeroboard-and-naver.gif
---

한국의 양대 오픈소스라면 단연 제로보드와 태터툴즈라고 할 수 있다. 태터툴즈는 TNC가 인수해서 현재 티스토리로 서비스하고 있고, 다음 커뮤니케이션이 서버와 같은 자원을 지원하고 있다. 반면, 제로보드도 네이버의 지원을 받게 되었다고 [제로보드 공식 사이트](http://www.nzeo.com/bbs/zboard.php?id=main_notice&no=198)에서 알려왔다.

![NHN이 지원하는 제로보드](/assets/zeroboard-and-naver.gif)

제로보드는 한국에서 가장 널리 퍼져있는 게시판으로 PHP라는 언어로 만들어져 있다. PHP의 특성상 소스가 공개되어 있기 때문에 많은 사람이 자신의 필요에 맞게 고쳐서 사용하고 있다. 비슷한 용도의 프로그램으로 [그누보드](http://www.sir.co.kr/gnuboard4.php)가 있고, 그누보드의 경우 깔끔한 대외정책으로 인해서 쇼핑몰을 구축하거나, 기업에서 사용할 때 제로보드보다 효율이 좋지만, 선두 프로그램이라는 강력한 메리트는 제로보드라는 아성을 만들어 주었다.

이런 제로보드가 네이버에 인수된다는 기사가 나왔는데, 정확히 말하자면 제로보드의 개발자인 고영수님이 네이버에 입사한 이후로 네이버에서 제로보드의 개발만을 맞긴 것이다. 고영수님이 말한 네이버와의 계약 내용을 살펴보자.

1. 제로보드의 모든 결정과 진행은 PM인 저에게 권한이 있다.
2. 제로보드의 모든 코드는 Open source이고 GPL라이센스를 따른다.
3. NHN에 종속적이거나 제한적인 기능을 구현하지 않고 open api를 통한 연계만이 가능하다. (다른 포털이나 서비스 업체와의 연계도 동일)
4. 제로보드를 개발함에 있어 디자인, 번역등의 NHN 보유 인력이나 장비의 지원을 적극적으로 한다. (현재 좋은 서버를 다수 지원받았습니다)
5. 다른 업무를 하지 않고 full time open source 개발자로서 근무를 할 수 있다.

고영수님은 첫눈이라는 회사에서 풀타임으로 제로보드 개발에 매진한 바 있고, 그 때 나온 프로젝트가 제로보드5라고 알려진 zb5 베타였다. 첫눈이 NHN에 인수된 후로 고영수님은 NHN 직원으로 입사하게 되었고, 회사의 지원으로 제로보드 XE를 완전한 오픈소스 모델(GPL)로 개발하게 된다.

기술적으로 말하자면, 제로보드 5 이상의 버젼은 더이상 게시판이 아니라 웹사이트를 개발하는 일종의 플랫폼적인 성격이 강하다. 싸이월드가 개발한 싸이월드2와 어떻게 보면 비슷할 수도 있는데, 너무 많은 기능을 체계적으로 넣으려다 보니 상당히 복잡하게 만들어져 있다.

이런 이유로 zb5가 출현한 이후로도 제로보드4의 업데이트를 바라는 사용자들이 줄어들지 않고 있으나, 아쉽게도 [제로보드4의 라이센스](http://www.nzeo.com/manual/about_license.html)가 수정 후 재배포를 허용하지 않기 때문에 보안 패치를 제외한다면 업그래이드가 이루어지지 않고 있다고 볼 수 있다.

이번 계약으로 인해서 NHN은 잃을 것이 전혀 없는 매력적인 프로젝트를 진행할 수 있게 되었고, 개발자인 고영수님도 소득에 구애받지 않으면서 자신이 개발한 제로보드를 개선시킬 수 있게 되었다. 네이버의 서비스가 다음을 벤치마킹하고 있다는 얘기는 더이상 새로운 것이 아니지만, 현재 진행되고 있는 다음과 태터툴즈의 관계, 그리고 네이버와 제로보드의 관계가 비슷해 보이는 것은 왜일까?

Update 20070315

언론에 제로보드를 NHN이 인수를 했다는 기사가 나오고 있는데, 이 부분에 대한 출처는 NHN의 [보도자료](http://app.yonhapnews.co.kr/yna/basic/article/Press/YIBW_showPress.aspx?contents_id=RPR20070314009500353)입니다. 다음은 보도자료의 중요부분.

> ......
>
> NHN(대표 최휘영 www.nhncorp.com)은 국내 인터넷 콘텐츠 생산환경을 개선하고 포털 외부 이용자들에게 콘텐츠 제작 편의를 제공하기 위해 인터넷 게시판 제작 솔루션인 &#8216;제로보드'를 인수하고, 올 하반기에 오픈 소스 형태로 지원할 예정이라고 밝혔다.
>
> NHN 은 제로보드의 원활한 서비스 제공과 오픈 소스 활성화를 위해 오픈 소스 프로그램 전담 지원팀을 구성하고 기획, 디자인, 기술 등 관련된 다양한 전문 기술력과 대용량 서버를 지원해 누구나 쉽고 편리하게 게시판, 커뮤니티 등을 제작, 운영할 수 있도록 할 계획이다.
>
> ......
>
> NHN 이람 커뮤니티 테마 매니저는 "그동안 포털 외부 이용자들이 커뮤니티를 운영하기에는 제반 기술 프로그램 및 호스팅 등의 제약이 컸었다" 며, "NHN은 포털 서비스 이용자가 아니더라도 누구나 편리하게 자신의 커뮤니티를 제작하고 운영할 수 있는 환경을 제공하기 위해 노력을 아끼지 않을 것"이라고 밝혔다....
