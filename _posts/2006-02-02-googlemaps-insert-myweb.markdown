---
layout: post
title:  "구글맵을 이용해서 웹페이지에 지도를 넣어보자"
date:   2006-02-02 08:47:09 +09:00
categories: service
tags: google map
author: Samgu Lee
---
구글의 많은 서비스들은 개발자가 접속할 수 있도록 오픈 API를 제공하고 있습니다. 이 것을 소위 웹2.0이라고도 하는데, 구글맵에서 제공하는 API를 가지고 웹페이지에 지도를 넣어보도록 하겠습니다. 이리 말하지만, 매우 쉽습니다.

구글맵은 미국과 캐나다에서 서비스를 하고 있고, 다른 국가에서는 위성지도를 주로 서비스하고 있습니다. 다만, 한국과는 틀리게 일본에선 지리정보데이터를 넣고 있는 것이 확인되었습니다.

![구글맵에 나타난 한국과 일본](/assets/googlemaps_korea_vs_japan.jpg)

지리정보데이터가 입력되어 있으면 구글맵의 세가지 모드 즉 위성사진모드, 지도모드, 그리고 하이브리드모드로 볼 수 있고, 위치설명도 있기 때문에 매우 간편하게 사용할 수 있게 됩니다.

그럼, 웹페이지에 구글맵을 넣어보도록 하겠습니다.

## 1. 구글맵의 API를 얻자.

구글의 [API 페이지의 구글맵](http://www.google.com/apis/maps/)으로 가서 "Sign up for a Google Maps API key"를 클릭하고, 넣을 페이지의 URL을 입력하면 API 키, 사용해도 좋을 URL 그리고 예제 HTML코드 이렇게 세가지 정보가 나오게 됩니다.

주의할 점은 제공되는 키는 입력한 도메인에서만 사용 가능하므로, 도메인이 바뀔 경우 다른 키를 발급받아야 합니다.

![구글맵의 API 얻는 화면](/assets/after_signup.jpg)

## 2. 주어진 예제 코드를 수정하자.

올바르게 입력했다면 여러분은 다음과 같은 코드를 얻을 것입니다.

```html
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Strict//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-strict.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
  <head>
    <script src="http://maps.google.com/maps?file=api&v=1&key=[API키]" type="text/javascript"></script>
  </head>
  <body>
    <div id="map" style="width: [가로픽셀수]px; height: [세로픽셀수]px"></div>
    <script type="text/javascript">
    //<![CDATA[
    var map = new GMap(document.getElementById("map"));
    map.addControl(new GSmallMapControl());
    map.centerAndZoom(new GPoint([가로위치좌표], [세로위치좌표]), 4);
    //]]>
    </script>
  </body>
</html>
```

위의 코드에서 수정해야 할 것은 가로와 세로픽셀수 그리고 가로위치좌표와 세로위치좌표 입니다.

적당한 크기로 픽셀수를 수정하고, 다음과 같은 방법으로 원하는 지역의 좌표값을 얻습니다.

### 원하는 지역 좌표값 얻기

- 구글맵에 접속해서 원하는 지역이 나오도록 지도를 움직여 줍니다. 수도권일 경우 "seoul"로 검색한 후 마우스로 조정을 하면 됩니다.
- 원하는 지역이 대충 나왔다면 정확한 지역을 더블클릭해 줍니다. 그러면 그 지역이 정가운데로 오게 됩니다.
- 위와 같이 한 후 지도 최상단의 오른쪽에 있는 "Link to this page"라는 링크를 클릭하면 주소창의 주소가 바뀌는데, 주소 중에 ll= 다음에 나오는 값이 좌표값입니다. 이 두개의 좌표값을 앞뒤를 바꾸어서 위의 코드에 넣어주면 됩니다.

## 3. 수정한 코드를 웹페이지에 넣자.

수정한 코드르 웹페이지에 넣으면 아래와 같이 나의 홈페이지에 구글 맵을 넣을 수 있습니다.

![커스텀 구글 맵](/assets/customize_google_maps.jpg)
