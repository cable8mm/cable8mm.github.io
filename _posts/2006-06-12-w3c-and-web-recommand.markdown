---
layout: single
title:  "웹표준과 CSS"
date:   2006-06-12 12:15:00
categories: opinion
tags: webstandard css
author: Samgu Lee
---
일모리님은 한국 웹표준의 전도사로서 정확한 지식을 전달하는데 많은 도움을 주고 계신 분입니다. 이 글은 어떤 정보가 다른 쪽으로 해석될 수도 있다는 것을 보여주기 위해서 쓰여졌으며, 모든 내용은 실전에 적용을 해 본 후 나름대로의 느낌을 적은 것임을 먼저 알려드립니다.

## 웹표준과 CSS은 관계가 없다.

원론적으로 이야기하자면 처음 CSS가 W3C에 권고될 때가 1996년 12월 17일로 정확한 문서의 제목은 "[Recommendation: CSS level 1](http://www.w3.org/TR/REC-CSS1-961217)"입니다. 스펙을 보면 느낄 수 있겠지만, 기존 태그를 style로 대체하기 위해서 만들어진 것을 쉽게 알 수 있습니다. 그리고, 태그에 확장성을 가미해서 더 쉽게 디자인 할 수 있는 것도 중요하겠죠. 이 문서로 인해 CSS의 기본 문법이 정해졌습니다. 스타일간 그룹화가 가능하고, 상속도 가능합니다. 하지만, 이 문서에 레이아웃에 대한 것은 전혀 나와있지 않습니다.

현재는 어떨지 몰라도 처음 CSS가 나올때는 더 편하고 쉽게, 그리고 많은 기능을 구조적으로 선언하기 위해서 만들어 졌다는 사실을 알 수 있습니다.

그렇다면 웹표준 이야기가 나올때 왜 CSS라는 것이 나올까요? [일모리 님의 지적](http://ilmol.com/wp/2005/08/15/110/)대로 정확히 말하자면 CSS가 아니라 XHTML이라고 칭해야 합니다. 즉, CSS+XHTML이 정확한 표준이 되는 것이지요.

위의 말처럼 레이아웃을 체처두고 텍스트 문단만을 HTML 태그 대신 CSS로 적용하면 많은 잇점이 생기게 됩니다. 구조화가 되었기 때문에 간단한 수정은 한줄만 바꾸어도 곧바로 적용이 됩니다.

## 문제의 핵심 XHTML로의 접근

XHTML은 XML형태로의 HTML을 구현하기 위해서 만들어 졌습니다. 아마도 W3C는 HTML 4를 마지막으로 그 이상은 없으며 XHTML로의 이행을 바랬을지도 모르겠습니다.

의도가 무엇이던간에 XHTML 1.0버젼은 그 자체로 HTML보다 엄격한 규칙이 존재하지만, HTML 4의 재구성버젼이고, 따라서 기존 HTML을 렌더링하는 브라우져에 보여지게 됩니다. 문제가 되는 것은 XHTML 1.1버젼입니다.(XHTML 2.0도 있으나 이 부분은 컴퓨터만이 아닌 많은 디바이스에서 대용량 문서를 구현하는 것도 포함하는 매우 광범위한 문서 기준이므로 생략합니다.)

W3C의 행보를 보면 HTML을 XHTML로 흡수하고, 다른 MathML과 같은 태그기반도 흡수하려는 생각으로 보입니다. 당연한 것이 XML의 기본 생각이 모든 데이터에 구조화된 태그를 붙여 상호 연동이 수월하도록 하는데 있습니다. 사실 이 얘기는 매우 오래전부터 논의되어 왔습니다.

## XHTML의 실체가 무엇인가?

[W3C](http://www.w3.org/TR/xhtml11/) 인용:

> XHTML document type that is based upon the module framework and modules defined in Modularization of XHTML [XHTMLMOD]. The purpose of this document type is to serve as the basis for future extended XHTML 'family' document types, and to provide a consistent, forward-looking document type cleanly separated from the deprecated, legacy functionality of HTML 4 [HTML4] that was brought forward into the XHTML 1.0 [XHTML1] document types.

위 내용에서도 알 수 있듯이 XHTML 1.1은 현재 그리고 미래의 모듈 프레임웍을 구현하기 위한 스팩입니다. 즉, CSS는 디자인의 구조화를 위해서 생겨난 것에 비해서 XHTML은 HTML을 XML형식의 프레임웍으로 구현하고, 웹이 아닌 다른 디바이스까지 포함하기 위한 광범위한 스펙이 됩니다.

## 그렇다면 CSS로 레이아웃을 잡는 것은 갑자기 왜 나온 얘기인가?

CSS와 XHTML 스펙에는 레이아웃에 대한 이야기는 없습니다. 그렇다면 테이블 레이아웃이 표준이 아니라는 이야기는 어디서 나온 이야기일까요?

W3C의 문서 중 "[Web Content Accessibility Guidelines 1.0](http://www.w3.org/TR/WCAG10/)"를 보면 그 답을 알 수 있습니다. 이 문서는 CSS나 XHTML의 권고(사실상 표준이라고 쓰입니다.)와는 틀린 가이드라인입니다. 이 문서에서 테이블 레이아웃에 대해서 다음과 같이 기술하고 있습니다.

[W3C](http://www.w3.org/TR/WCAG10/) 인용:

> Using markup improperly -- not according to specification -- hinders accessibility. Misusing markup for a presentation effect (e.g., using a table for layout or a header to change the font size) makes it difficult for users with specialized software to understand the organization of the page or to navigate through it. Furthermore, using presentation markup rather than structural markup to convey structure (e.g., constructing what looks like a table of data with an HTML PRE element) makes it difficult to render a page intelligibly to other devices (refer to the description of difference between content, structure, and presentation).

즉, 테이블 레이아웃은 디자인의 쉽고 어려움과는 전혀 상관없이 프로그램에서 데이터를 알기가 힘들고, PC 이외의 다른 기기에서 렌더(HTML을 실제 이미지로 변환하는 것)의 어려움이 있다는 것입니다. 즉, 코드의 확장성을 염두에 둔 가이드라인이라는 것입니다. XHTML로 디자인을 하면 코드 변경없이 모바일에서도 서비스가 된다고 생각하면 쉽습니다. Google은 모바일용 웹사이트에서 XHTML을 지원하고 있습니다.

## 실전을 이야기 할 때

위의 글에서 CSS라는 것은 웹표준과는 그다지 상관없고, XHTML과 합쳐질 때 표준이 된다는 사실을 알았습니다. 이제 실전에 적응해 봅시다.

어떤 회사가 웹사이트를 CSS2.0+XHTML1.1 스펙에 맞게 디자인을 했다고 칩니다. 그 회사는 모바일용 웹사이트를 따로 제작하지 않고, 같은 문서에 CSS 파일의 변경만으로 모바일용 웹문서 디자인을 끝냈습니다. 또한, CSS만의 변경으로 시작장애인용 웹사이트를 글씨가 크고, 네비게이션도 크게 디자인했습니다.

위의 이야기는 실제로 일리가 있어 보입니다. 하지만, 실전에서 이렇게 사용되는 경우가 관리가 부담되는 개인 웹사이트 외에 있을까요?

우선 나누어 생각해 보면 모바일은 기본적으로 매우 작은 화면을 갖습니다. 따라서, 한 페이지에 나오는 정보의 양도 매우 적습니다. 웹사이트의 로직 부분도 당연히 틀려져야 합니다. 모바일의 한정적인 정보를 보여주기 위해 웹용으로 제작된 코드를 그대로 사용할 이유가 전혀 없는 것입니다. 즉, 모바일용 웹사이트는 다시 제작되어야 합니다.

시작장애인용 웹사이트도 마찬가지입니다. 시작장애인용 웹사이트를 CSS의 교체만으로 당연히 디자인이 가능합니다. 하지만, HTML 문서를 새로 만드는 것이 훨씬 빠를 것입니다.

위의 글에서 CSS+XHTML 문서를 이용해야 되는 이유는 콘텐츠의 재활용(확장성)에 있다는 것을 W3C문서에서 알 수 있었습니다. 그 말은 내가 만드는 페이지가 다른 디바이스에 나오거나 같은 디바이스라도 다른 디자인이 보여져야 할 때에만 의미가 있다는 말입니다.

## XHTML이 디자인과 컨텐츠를 분리해준다?

이 분야의 가장 유명한 모델 중 하나는 MVC(모델,뷰,컨트롤러)패턴입니다. 여기서 디자인과 관계되어있는 뷰, 즉 프리젠테이션 영역에 속합니다. 프리젠테이션은 단순히 어떻게 디자인되느냐가 아니라 사용자에게 어떻게 보여주느냐 하는 것으로 그 둘은 많은 차이를 가지고 있습니다.

비지니스 로직에서 원화로 1000원을 프리젠테이션으로 넘겨주었다고 합시다. 프리젠테이션 영역에서는 1000원을 1,000원으로 표시할 수도 있고, KRW 1000이라고 표시할 수도 있습니다. 즉, 프로젠테이션에는 "조건이 있는 코드"가 들어가야 한다는 의미입니다.

이 이야기는 비지니스 로직과 프리젠테이션 로직의 분리 문제는 개발 정책상의 문제이고, 실제 이런 것들이 필요할 때, CSS의 교체로 리뉴얼을 하는 것 보다는 템플릿을 이용한 리뉴얼이 훨씬 유연한 환경을 제공합니다.

## 그럼 여기서 주장하는 것은 도대체 무엇?

처음 글을 작성할 때의 의도는 무엇이 올바른 것이냐 하는데 부터 시작했습니다. 그리고, 이런 부분은 정책의 문제이고, 웹표준이라는 것의 실체가 무엇인지 알아야 되는 당위성을 포함합니다. 쉽게 말하면 웹표준을 왜 따라야 하느냐 하는것이죠.

현실적으로 XHTML이 추구하는 방향에 가장 확실하게 부합하는 것은 디바이스 별 디자인이 별도로 들어가는 것입니다. 모바일용 웹페이지 따로, PC용 따로, PDA용 따로... 템플릿을 이용하면 이런 것은 매우 수월하게 만들 수 있습니다. 반면 CSS를 이용해서 제작한다고 하면 대부분 사람이 인정하듯이 쉽지 않은 일이 되어 버립니다. 그리고, 테이블 레이아웃에 중간중간 CSS를 적용하면 가장 빠르고 대부분의 브라우져에서 보여지는 웹사이트 제작이 가능합니다.

## 부연

일모리님이 지적하신 오페라로 제대로 보여지는 웹사이트 제작이 실질적으로 불가능하다는 이야기는 예전 저의 경험에서 나온 것입니다. 테이블을 쓸 때 전 보통 IE, 파이어폭스, 그리고 오페라에서 테스트를 하곤 했는데, CSS만으로 제작할 때 오페라에서 디자인을 같게 만드는 것이 불가능하게 생각되었기 때문입니다. 이 것은 개인적인 경험입니다.

nmind님이 지적하신 디자인과 컨텐츠의 분리는 그 자체가 중요한 것은 아니라고 생각됩니다. 여러가지 개발 모델들이 있기 때문에 개발팀의 선택에 따라 틀려질 것 같네요. 일반화 시키는 것은 약간 무리가 있어 보이네요.

다만, 테이블 레이아웃을 기술이 없어서 그렇다는 식은 좀 곤란하지 않나 싶습니다. 쉬운 길이 있으면 쉬운 길로 가는 것이 좋아 보이거든요.
