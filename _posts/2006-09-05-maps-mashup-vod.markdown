---
layout: single
title:  "구글 어스와 콩나물의 만남 - 동영상"
date:   2006-09-05 13:32:57
categories: gossip
tags: google earth
author: Samgu Lee
---
SsaZzang's Web Log에서 구글 어스와 콩나물을 매쉬업한 글이 포스팅되었습니다. 하지만, 불여우(Firefox)에서 동작하지 않아서 소개를 못해드렸는데, 無異님께서 "[구글 어스(Google Earth) 2종 세트][best-on-google-earth]" 덧글로 무시무시한 매쉬업 동영상 주소를 포스팅해 주셔서 소개합니다.

콩나물은 웹2.0의 바람을 타고 얼마전 사용자의 웹페이지에 콩나물 지도 서비스를 할 수 있는 코드를 선보였습니다. 이삼구글에서도 확인했지만, 역시 불여우(Firefox)에서 제대로 서비스 되지 않았기 때문에 소개해 드리지 않았습니다.

곧이어, [구글 맵스(Google Maps)와 연동되는 화면](http://www.hometown.co.kr/57)을 SsaZzang님이 소개해 주셨습니다.

이번에 소개해 드릴 매쉬업은 [구글 어스(Google Earth)와 콩나물의 매쉬업 동영상](http://www.youtube.com/watch?v=48Idlin0Fzc)입니다. 일단 감상을 해 보도록 하죠.

{% youtube "http://www.youtube.com/watch?v=48Idlin0Fzc" %}

이 영상을 올리신 분은 예전 네이버 맵을 해킹해서 구글 어스에 연동시킨 영상을 올리신 [taekie님](http://www.youtube.com/profile?user=taekie)이십니다.

"[구글 어스(Google Earth) 2종 세트][best-on-google-earth]"에서 소개한 적이 있는 네이버 맵과 구글 어스의 연동 동영상도 감상을 해 보도록 하죠.

{% youtube "http://www.youtube.com/v/fmbJIGT2MCo" %}

네이버 맵과 구글 어스의 매쉬업은 KLDP에서 활동하고 계신 [aero님](http://kldp.org/user/540)이십니다. taekie님과 aero님이 동일인인지는 확인할 수 없었습니다.(알고 계신 분은 덧글~)

재미있는 사실은 콩나물 동영상이 2달 전에, 네이버 동영상이 한달 전에 포스팅 되었다는 점입니다. 이런 영상이 블로고스피어에 소개되지 않은 이유를 알 수 없을 정도로 멋진 영상입니다.

구글 맵스나 구글 어스와의 연동에 있어서의 핵심은 좌표변환에 있습니다. 구글 어스는 GPS에서 주로 사용되는 WGS84를 사용하고 있지만, 국내 대부분의 지도 서비스는 동경좌표계로 알려져 있는 Bessel 좌표를 사용합니다. 좌표간 변환은 함수로 딱 정해져 나오게 되지만, 함수의 7가지 인자를 찾기가 힘들고(실측이 필요), 지역별로 인자가 같지 않습니다. 이 부분에서의 선두업체는 [제모지오스페셜](http://geo.repl.net/)이라는 곳으로 미국방지리원과의 합동 조사로 30군데에서 실측한 데이터를 가지고 있습니다.

아직은 상용 서비스로 진행될만한 기술은 나오지 않고 있지만, 벌써 이정도의 기술로도 서비스하는 회사가 있습니다.

매쉬업이 실제 서비스로 진화하기 위해선 아직 가야할 길이 멀어 보이지만, 기존의 시스템에선 감히 시도조차 할 수 없는 일을 여러 회사 혹은 개인이 진행하고 있다는 것은 굉장한 일이 아닐 수 없습니다.

[best-on-google-earth]: {% post_url 2006-08-28-best-on-google-earth %}
