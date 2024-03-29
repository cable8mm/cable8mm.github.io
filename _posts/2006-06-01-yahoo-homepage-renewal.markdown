---
layout: single
title: "2% 부족한 야후!의 홈페이지 리뉴얼"
date: 2006-06-01 12:13:00
categories: opinion
tags: yahoo renewal
author: Samgu Lee
header:
  og_image: /assets/800_yahoo_homepage-758206.png
---

야후!의 홈페이지 개편이 Yahoo!와 거의 같아졌습니다. Ajax를 이용해서 멋지고도 약간은 개인화적인 면도 들어가 있습니다. 이번 개편과 더불어서 Yahoo!의 서비스들이 대거 한국에서도 서비스될 지도 모른다는 기대가 있었습니다만, 아직은 그런 일은 벌어지지 않고 있군요.

## Yahoo!(미국 야후 - http://www.yahoo.com/)

이번 개편은 놀랍게도 해상도 1024를 기준으로 만들어졌습니다. 즉, 800일 경우(보통 15인찌 모니터) 간단하게 정리된 웹사이트가 뜨게 됩니다.

![야후 홈페이지](/assets/800_yahoo_homepage-758206.png)

요약하자면, 현재까지는 총 세개의 홈페이지 디자인이 있는 셈입니다. 옛날것, 신형 1024 이상일때, 신형 1024 미만일때...

```javascript
YAHOO.Fp.bNarrow = YAHOO.Fp.nScreenWidth
  ? YAHOO.Fp.nScreenWidth < 1024
    ? 1
    : 0
  : -1;
```

## 야후!(한국 야후 - http://kr.yahoo.com/)

하지만 야후!의 경우는 위의 설정이 빠져 있습니다. 왜 해상도를 조절하는 자바스크립트가 빠져 있는지는 알 수 없지만, 현재 야후!를 작은 모니터나 혹은 Google 사이드바를 띄워놓고 접속하면 오른쪽 부분이 빠져서 나오게 됩니다. 물론 Yahoo!는 새로운 홈페이지가 뜹니다.

![야후코리아 홈페이지](/assets/kr-yahoo-homepage.png)

야후!가 자체적인 개발팀을 만들어서 미국과 차별화된 서비스를 제공한지 몇년이 흘렀습니다. 올해를 기점으로 미국 서비스와 통폐합 될런지, 아니면 계속 자체적인 서비스를 제공할지 관심이 가네요. 개발인력은 꾸준히 뽑고 있는 것 같기는 합니다만...
