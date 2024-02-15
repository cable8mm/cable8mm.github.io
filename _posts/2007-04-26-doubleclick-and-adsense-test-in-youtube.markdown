---
layout: single
title:  "발빠른 구글 애드센스팀, 더블클릭 테스트 시작"
date:   2007-04-26 07:20:32 +09:00
categories: advertising
tags: google
author: Samgu Lee
---
구글과 소니하면 생각나는 것이 무엇일까? 작년에 있었던 소니 픽처스와의 다빈치 코드 프로모션 정도가 있을 것이다.

![구글,소니,더블클릭,유튜브](/assets/youtube-sony-google-doubleclick.jpg)

말하자면, 그다지 구글과 소니의 관계는 밀접한 것은 아니다. 하지만, 더블클릭과 소니의 관계는 구글보다 훨씬 가깝다.

이런 배경때문일까, [더블클릭을 구글이 인수](https://palgle.com/2007/04/16/google-acquire-doubleclick-31b/)한 후, 유튜브의 상단 배너 모듈이 애드센스에서 더블클릭으로 변환되었다.

![유튜브 상단의 더블클릭 광고 코드](/assets/youtube-adsense-sony.jpg)

현재 유튜브의 상단 광고는 소니의 배너가 독점으로 노출되고 있고, 광고 코드는 더블클릭의 코드 안에 애드센스가 삽입되어 노출되고 있다. 애드센스 코드를 본 적이 있다면, 아래의 코드는 익숙해 보일지도 모른다.

```js
document.write(");
google_ad_client = "pub-6219811747049371";
google_ad_width = 728;
google_ad_height = 90;
google_ad_format = "728x90_as_new";
google_ad_type = "text_image";
//2007-01-26: International
google_ad_channel = "9123014361";
google_color_border = "FFFFFF";
google_color_bg = "FFFFFF";
google_color_link = "0033CC";
google_color_text = "444444";
google_color_url = "0033CC";

document.write('<script type="text/javascript"
 src="http://pagead2.googlesyndication.com/pagead/show_ads.js">
 </script>’); document.write("");
```

구글은 전통적으로 데이터를 좋아하며, 통계를 믿는다. 통계를 이용해서 부정클릭을 찾아내고, 광고비를 산정하고, 검색 랭킹을 메기는데 매우 익숙하다.

누가 나에게 구글의 강점이 무엇이냐고 묻는다면, 통계에 강하고, 사용자의 엑션을 수치화하는데 아무런 꺼리낌 없이 여기는 회사 분위기라고 답할 것이다.
