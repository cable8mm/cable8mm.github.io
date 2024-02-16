---
layout: single
title:  "자바를 위한 툴킷, GWT 공개"
date:   2006-05-18 05:39:42 +09:00
categories: service
tags: google gwt
author: Samgu Lee
---
Google Code팀에서 GWT(Google Web Toolkit)을 런칭했습니다. Ajax를 겨냥해서 쉽게 제작하고 디버깅할 수 있다는 소개가 있네요. 사실 Ajax를 맨땅에 개발하는 것은 매우 어렵습니다. 많은 프로젝트가 표준 모듈화를 시도하고는 있지만, 한곳으로 뭉치지가 않네요.

[Google Web Toolkit](http://code.google.com/webtoolkit/faq.html#what) 인용 :

> Google Web Toolkit (GWT) is a Java software development framework that makes writing AJAX applications easy. With GWT, you can develop and debug AJAX applications in the Java language using the Java development tools of your choice. When you deploy your application to production, the GWT compiler translates your Java application to browser-compliant JavaScript and HTML.

GWT는 기술적으로 말하자면 JAVA코드를 JavaScript로 변환하고, 여러가지 디자인 모듈(Widgets)이 포함되어 있는 지능적인 템플릿이라고 표현할 수 있습니다.

![GWT 아키텍처](/assets/gwt-architecture.png)

MS가 OS시장을 평정할 때와 어째 분위기가 비슷하게 흘러가고 있네요. 개발자를 지배하면 세계를 지배한다 인가요...

via - [Google Blogoscoped](http://blog.outer-court.com/archive/2006-05-17-n42.html)
