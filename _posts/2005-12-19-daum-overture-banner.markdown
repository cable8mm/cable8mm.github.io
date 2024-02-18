---
layout: single
title:  "다음커뮤니케이션, 오버추어와 개인정보를 이용한 배너 개시"
date:   2005-12-18 15:49:59 +09:00
categories: advertising
tags: daum overture
author: Samgu Lee
---
구글에서 구글코리아(가칭)를 정식으로 오픈하려는 움직임을 보이면서 야후의 자회사 오버추어가 마케팅사이트를 런칭하면서 대대적인 홍보를 시작했습니다.

구글의 홍보 특징은 온라인에서는 구글 애드센스만을 이용해서 자사 홍보를 진행하는데 비해, 오버추어는 자사의 광고매체 이외에 배너광고나 에이젼트를 두는 방향으로 진행을 하고 있는데, 이번에 선보인 다음과는 배너는 다음의 개인정보 중에서 닉네임을 이용했습니다.

실험을 위해서 익스풀에서 다음 로그인 한 상태에서 다음 주소를 클릭해보세요.

[다음의 개인정보를 이용한 오버추어 배너](http://amsv2.daum.net/cgi-bin/adcgi?corpid=46&secid=00420&type=cpm&tag=iframe&mkvid=1&ord=)

배너의 HTML 소스는 다음과 같이 코딩되었습니다.

```js
var InternetExplorer = navigator.appName.indexOf("Microsoft") != -1;
function drawFlash(){
	var swf_url = 'http://amsimg.hanmail.net/www2/a40K/aRyP/overture_250250_1215_a.swf';
	var html = '';
	html += '<object classid="clsid:d27cdb6e-ae6d-11cf-96b8-444553540000" codebase="http://fpdownload.macromedia.com/pub/shockwave/cabs/flash/swflash.cab#version=7,0,0,0" width="250" height="250" id="banner" align="middle">';
	html += '<param name="movie" value="'+swf_url+'" />';
	html += '<param name="quality" value="high" />';
	html += '<param name="bgcolor" value="#ffffff" />';
	html += '<param name="flashVars" value="user_name=niio" />';
	html += '<embed src="'+swf_url+'" quality="high" bgcolor="#ffffff" width="250" height="250" name="banner" align="middle" type="application/x-shockwave-flash" pluginspage="http://www.macromedia.com/go/getflashplayer" />';
	html += '</object>';
	document.write(html);
}
drawFlash();
```

이 배너는 익스플로어와 그 외의 브라우져를 따로 처리를 하기 때문에 위의 코드는 익스플로어에서만 볼 수 있고, flashVars의 user_name값을 플래쉬파일에 넘겨줌으로서 플래쉬에서 닉네임을 보여주게 됩니다.

![개인정보를 이용한 오버추어의 배너](/assets/daum_overture_banner_01.gif)

일반적으로 다음같은 매체사들은 배너를 광고 에이젼시나 광고를 내는 업체에게 직접 받지만, 이번 경우처럼 제작에 관여하는 경우는 흔치 않습니다. 또한, 플래시 파일에 다음의 쿠키값을 복호화하는 코드는 없을테지만, 다음에서 닉네임을 넘겨주어야 이런 광고물이 만들어 질 수 있습니다.

이런 개인정보를 이용한 배너제작이 가능한건지 다음의 개인정보관리부분을 살펴본 결과 다음과 같은 문구를 확인할 수 있었습니다.

> 개인정보의 수집목적 및 이용  
> Daum 이 회원님 개인의 정보를 수집하는 목적은 Daum 사이트를 통하여 회원님께 최적의 맞춤화된 서비스를 제공해드리기 위한 것입니다. Daum 은 각종의 컨텐츠를 무료로 서비스해 드리고 있습니다. 이때 회원님께서 제공해주신 개인정보를 바탕으로 회원님께 보다 더 유용한 정보를 선택적으로 제공하는 것이 가능하게 됩니다.  
> Daum 은 무료로 서비스를 제공하기 위해서 광고를 게재합니다. 이때에도 회원님 개인에 대한 정보를 바탕으로 좀더 유용한 정보로서의 가치가 있는 광고를 선별적으로 전달할 수 있게 됩니다.  

이번 오버추어의 플래쉬 배너의 경우 오버추어에게 개인정보를 넘겨주는 형식은 아니지만, 오버추어에서 플래쉬의 스크립트를 코딩하고, 배너가 다음 서버에 올라가 있기 때문에 다음에서 쿠키로 저장하는 정보를 알 수 있습니다.

```js
vid7=11CH8f; DNSHOPCPC=11313519464736466039097; ACODE=Vs-sed991II0; PMPROF=0603012024024064044108UiQPJk7X-6w0-zE35fE7EtWDTWO2pljEtw00KuZP3z7wEl2W4..NYhR74w00LYYSA9A1_cHtydXyOb1Wd_-jZFdzOV4jmBqDwDY6fXQyyuIf8ZdHYjUbHLzXiPjbooToC5P1QOA._EAsok.aubq5uRyOYYFe-K2O8bI3vXA0smsqWDNXRwF_wfewFPrLxAtTIz1cfPvjLxQj1FtUZRdgYMk..nC2y3BFGuqETsy5tbAnv1-UN5boXWiZiab8hn.XeJC81oeNehbTqZuLDu90; SLOGIN=1; PMHIP=53aDNeMlcdY..1467CgWmhtxIZTw00; Apache=211.197.251.75.1134918290360753; ADF=00|1974|N|M|J||K185Q|S|0513|LC; HM_CU=53eIV73aDNe; TS=1134918297; HTS=1yiOAyCEEtnBj8PSgtyMiA00; HIP=MlcdY..1467CgWmhtxIZTw00; PROF=0603012044088064044108UiQPJk7X-6w0BQphxVuS99qtWUs7x-OWmTrTIDhnb_seOWqJSwbCmaw0aNeGVs5v4KgvtuXPQM_oGWeoNX5J6ucfLwq-Wk76PiLmBmrL-39ZRgw9pwQQ1mRMIokGf._gJsUL594Y6zBTKA00LYYSA9A1_cHtydXyOb1Wd_-jZFdzOV4jmBqDwDY6fXQyyuIf8ZdHYjUbHLzXiPjbooToC5P1QOA._EAsok.aubq5uRyOYYFe-K2O8bI3vXA0smsqWDNXRwF_wfewFPrLxAtTIz1cfPvjLxQj1FtUZRdgYMk..nC2y3BFGuqETsy5tbAnv1-UN5boXWiZiab8hn.XeJC81oeNehbTqZuLDu90; TMSGROUPCODE=LC
```

일반적으로 포털같은 많은 개인정보를 가지고 있는 웹사이트의 경우 모든 정보를 암호화시키지만, 위의 코드로 최소한 IP, 생년월일, 성별 등을 취합할 수 있는 길이 오버추어에게는 열릴 수 있습니다.

이 문제점을 해결하기 위해선 오버추어에서 게제하는 플래쉬 광고물의 스크립트들을 다음이 검열하던지, 플래쉬 파일을 amsv2.daum.net이라는 도메인을 이용하지 말고, 전혀 별개의 주소를 이용하던지, 다음의 쿠키값 범위에서 광고서버를 빼야합니다.

구글 애드센스는 현재까지는 플래쉬배너를 허용하지 않고 있지만, 블로거들의 증언에 따르면 플래쉬배너를 테스트하고 있다고 합니다. 플래쉬는 스크립트가 들어있는 일종의 프로그램이므로, 개인정보 유출에 자유로울 수가 없습니다.
