---
layout: single
title: "만약 여러분이 애드센스를 보고 사이트를 구매한다면?"
date: 2006-03-07 08:40:39
categories: gossip
tags: google adsense
author: Samgu Lee
---

젠센스를 운영하는 Jennifer Slegg은 [애드센스를 염두에 두고 웹사이트를 인수](http://www.jensense.com/archives/2006/03/safeguarding_yo.html)할 때 확인할 수 있는 방법과 무엇을 확인해야 하는지를 알려왔습니다. 팔글에서는 그 내용을 요약해서 알려드립니다.

웹사이트를 인수했는데 그 사이트가 애드센스에 거부된 적이 있다면 난감할 것입니다. 난감하지 않다 하더라도 인수 전에는 그런 것들은 충분히 고려할 만한 가치가 있는 일입니다. 그럼, 몇가지 방법을 알려드립니다.

## 구글 애드센스의 미리보기 도구를 이용하라

인수할 웹사이트 몇페이지에 미리보기 도구를 사용하여 광고를 미리볼 경우 광고가 나오지 않거나 "e:-2146697208"같은 에러메세지가 나올 경우 그 웹사이트는 애드센스에서 거부된 적이 있다고 볼 수 있습니다. 이 에러메세지가 뜨지 않고 다음과 같은 메세지가 나올 수도 있습니다.

> We are unable to show ads on this page. Possible reasons include:

    * No ads are currently available for the selected geographic region.
    * Page has not been crawled. Please try again later.
    * This page contains sensitive content. Google AdSense filters ads from pages containing sensitive news items or content.

![웃긴대학에서 미리보기 한 화면](/assets/preview_in_humor.jpg)

이 페이지를 볼 수 있도록 승인되지 않았습니다.

만약 그 사이트에서 애드센스코드를 삭제하지 않았다면 애드센스 자리에 "이 페이지를 볼 수 있도록 승인되지 않았습니다."라는 메세지가 뜰 것입니다. 그것은 "HTTP Error 403 - Forbidden" 페이지를 말하는 것으로 모질라나 파이어폭스와 같은 브라우져를 쓰면 아무런 메세지도 나오지 않게 됩니다.

## 구글 / 야후 / MSN 캐쉬

검색엔진들의 캐쉬를 보면 애드센스 자리에 광고가 들어가 있는 것을 알 수 있는데, 그 계정이 삭제당했다면 마찬가지로 광고가 뜨지 않거나 403에러 페이지가 뜨게 됩니다.

예전에 올블로그에서 애드센스 계정 사건이 일어날 때 팔글에선 [이 방법으로 계정삭제 유무를 판별][adsense-in-allblog]했습니다.

## Internet Wayback Machine

Internet Wayback Machine은 웹사이트를 주기적으로 기록해서 보존하는 비영리기관에서 운영하는 프로그램입니다. 많은 이들이 웹사이트 거래시에 이 프로그램을 이용합니다.

이 사이트에서 웹사이트의 과거 코드를 볼 수 있으므로, 캐쉬와 마찬가지로 애드센스 자리에 광고가 뜨는지 안뜨는지 확인해 보면 알 수 있습니다.

## 거부 당한 적이 있는 사이트를 인수했을 경우

구글에 웹사이트를 인수했으니 거부리스트에서 삭제해 달라는 메일을 보낼 수는 있습니다. 하지만, 이 방법은 악용될 소지가 있기 때문에 구글에선 거부리스트에서 삭제해주는 경우는 거의 없습니다.

## 가장 안전한 방법은 역시 계약서

웹사이트 판매자에게 애드센스에서 거부된 적이 없다는 확답을 받아내는 것이 무엇보다도 중요합니다. 이 것이 중요한 이유는 웹사이트에서 예전에 애드센스를 진행한 적이 있고 robots.txt로 막아놓았다면 캐쉬던 Internet Wayback Machine던 코드가 남아있지 않기 때문입니다. 그리고, 미리보기 툴도 제대로 작동하지 않습니다.

따라서, 만약 여러분이 인수할 웹사이트에서 애드센스의 비중이 조금이라도 있다면 계약내용에 한 줄을 추가할 필요가 있을 것입니다.

[adsense-in-allblog]: {% post_url 2006-02-27-adsense-in-allblog %}
