---
layout: single
title: "구글 어스의 활용, 실시간 구름사진"
date: 2006-04-09 20:28:30
categories: gossip
tags: google earth
author: Samgu Lee
header:
  og_image: /assets/google_cloud_map.jpg
redirect_from:
  - /2006/04/10/google_cloud_earth/
---

구글 어스 API를 이용한 멋진 서비스가 만들어 졌는데 확인 해 보시죠.

키홀의 인수로 시작된 구글의 지도 서비스들은 서비스만 나온것이 아니라 외부 개발자가 구글의 데이터를 쓸 수 있는 [API도 같이 공개][maps-api-v2-launched]가 되었고, 지금도 꾸준히 업데이트가 되고 있습니다. 외국의 경우 대단하다고 할 수 밖에 없는 [매쉬업들이 공개][google-mesh-up-3]되고 있는데, 구글 어스에 플러그인 되어서 실시간 구름사진을 볼 수 있는 파일이 공개되었습니다.

구글 맵스와 구글 로컬의 경우는 자바스크립트 API를 공개해서 구글 직원이 아니더라도 웹서비스가 가능합니다. 구글 어스는 확장자가 KML인 파일을 플러그인 해서 지구의 위성사진 위에 또다른 서비스 구현이 가능합니다.

이번에 공개된 구글 구름사진은 완벽한 실시간은 아니고 3시간마다 새로운 구름사진을 전송해 줍니다. 이 플러그인의 제작자는 키홀 커뮤니티에서 ChrisMDP이라는 아이디를 쓰고 있는 [Chris Parsons](http://bbs.keyhole.com/ubb/showprofile.php?Cat=0&User=184034&Number=373671&Board=EarthExternalData&what=showthreaded&page=0&fpart=&vc=1)입니다. 한때 서버 호스팅을 중지했다가 4월 3일 다시 서비스를 하고 있는데, 공개된지 일주일만에 3600여번의 다운로드를 기록할 정도로 대단한 관심을 받고 있습니다.

서비스를 다시 할 수 있었던 것은 GE team의 호스팅 제공에 있다고 [구글 어스 블로그 운영자](http://www.gearthblog.com/blog/archives/2006/04/global_cloud_ma.html)인 FrankTaylor는 언급하고 있습니다.

![구글 어스의 구름사진](/assets/google_cloud_map.jpg)

![Google Earth Icon](/assets/gelogoicon.gif)

구름 사진을 구글 어스에서 보기 위해서는 [Global transparent cloud map](http://bbs.keyhole.com/ubb/download.php?Number=373671)을 클릭하세요. 구글 어스는 미리 설치되어 있어야 합니다.

via - [Google Earth Blog](http://www.gearthblog.com/blog/archives/2006/04/global_cloud_ma.html)

[maps-api-v2-launched]: {% post_url 2006-04-04-maps-api-v2-launched %}
[google-mesh-up-3]: {% post_url 2006-03-29-google-mesh-up-3 %}
