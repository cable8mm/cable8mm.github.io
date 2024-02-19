---
layout: single
title:  "알려지지 않은 검색, Google 영화 검색"
date:   2006-05-31 09:59:17
categories: opinion
tags: google movie search
author: Samgu Lee
---
Google에 영화 검색([www.google.com/movies](http://www.google.com/movies))이 있다는 것을 아는 이는 많지 않은 것 같지만, 서비스된 지는 꽤 됐습니다. 어떻게 영화를 검색할 수 있는지 대략적인 것들을 알아봅니다.

[Google의 웹검색][the-structure-of-google-web-search]은 중국 검열을 시작으로 많은 변화가 있었습니다. 예전에는 PageRank라는 백링크가 많은 웹페이지가 더 낳다라는 모토로 순위를 메겼지만, 지금은 문서 관련성에 많은 연구가 진행되고 있고, Google 알고리즘의 많은 변화(Big Daddy라고도 합니다.)도 실제 적용 되었습니다.

검색은 Google의 서비스들이 늘어나게 되면서 단순미를 해치지 않는 선에서 최대한의 복잡한 검색결과를 나타내 주고 있습니다. 이 기술은 초기 [사용권한 필터][google-search-ccl-filter], [기간 필터][google-search-add-filter] 등이 추가되었고, [여러가지 테스트를 진행][verify-google-test]하는 것이 블로거에 의해 알려지는 일까지 있었습니다. [Google Base가 출현][combine-search-base]하면서 가시화되고 있는데요, 이런 업그레이드 중에서 영화 검색은 꽤 쓸만한 결과를 보여줍니다.

![Google 영화 검색 Star Wars](/assets/google_movie_search.png)

영화 검색을 하는 방법은 검색어 앞에 "movie:"를 넣는 것입니다. 위의 화면은 기본 Google 검색에서 "movie:star wars"를 넣은 결과 화면입니다. 한글 검색은 되지 않지만, 화면에 나오는 글들은 한글화가 되어 있습니다.

Google 영화 검색은 Google 뉴스와 마찬가지로 자체적인 알고리즘에 의해서 순위를 메기고 영화평 몇개를 보여주게 됩니다. 영화평은 Google의 자료가 아니라 영화 관련 웹사이트에서 인용한 것이고, 클릭을 할 경우 긍정적 평가 혹은 부정적 평가를 왼쪽에 나타내 주고, 오른쪽에는 영화평이 나오게 됩니다.

이런 시스템은 Google의 쇼핑몰 검색엔진인 Froogle과 매우 흡사합니다. 즉, Froogle은 상품평을 보고 상품을 구매하는 식이고, Google 영화 검색은 영화평을 보고 영화를 보는 형식입니다.

그런데, Google의 영화 검색은 색다른 기능이 첨가되어 있습니다. 바로 영화관 검색이 그것인데요, 검색한 사람의 IP로 위치를 추적한 후 가장 가까운 영화관을 알려주게 됩니다.

![Google 개봉관 검색](/assets/google_movie_schedule.png)

이 검색에서 영화 정보는 Amazon에서 운영하는 Internet Movie Database 주식회사를 참고하고, 영화를 클릭하면 영화관의 시간을 알 수 있습니다. 아직까지는 좌석이 비었는지, 혹은 티케팅 등은 가능하지 않습니다.

재미있는 사실은 영화관의 웹사이트를 직접 링크해 주지는 않습니다. 보통 자료를 찾고 바로 예매를 하면 편하겠지만, 이 부분을 수익모델화 할지 아니면 극장측과 제휴가 필요한 것인지는 확인되진 않습니다.

또하나의 보너스, 극장의 위치를 알고 싶을 때는 "지도"를 클릭하면 Google Maps의 매쉬업이 펼쳐지게 됩니다. 일반적으로 Google Maps를 지도 검색으로만 알고 계신 분들이 있을텐데, Google Maps는 예전에 Google Local이라는 이름으로 불리워졌고, 버스같은 노선표를 제공하고 출발지와 도착지를 넣으면 최적의 길을 알려줍니다.

![Google 개봉관 검색](/assets/google_movie_maps.png)

위의 그림은 영화 검색에서 지도를 클릭한 후 메쉬업에서 출발지로 "Los Angeles, CA"를 넣어본 화면입니다.  좌측에 정확하게 가능 방향을 설명해 주는 링크를 볼 수 있습니다.

Google은 영화 검색에서 자체적인 데이터는 극장과 지도 뿐이지만, 매우 편한 서비스를 제공하고 있습니다. 이 서비스는 Google 웹검색에 자연스럽게 추가될 것이고, 검색어에 따라서 영화 검색이 검색 결과에 나오게 될 것입니다. 그 선택은 역시 알고리즘이 이루어 내겠죠.

마지막으로 Google의 영화 검색 최하단에 쓰여져 있는 문장이 재미있습니다.

> 이 페이지 영화평의 선택과 게재는 컴퓨터 프로그램에 의해 자동으로 결정됩니다. 이 페이지를 만드는 과정에 어떠한 영화 비평가도 침해되거나 사용되지 않았습니다.

[the-structure-of-google-web-search]: {% post_url 2005-11-26-the-structure-of-google-web-search %}
[google-search-ccl-filter]: {% post_url 2006-01-26-google-search-ccl-filter %}
[google-search-add-filter]: {% post_url 2006-03-07-google-search-add-filter %}
[verify-google-test]: {% post_url 2006-04-26-verify-google-test %}
[combine-search-base]: {% post_url 2006-03-24-combine-search-base %}
