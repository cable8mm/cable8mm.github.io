---
layout: single
title: "GMail의 메일 제목이 깨지는 현상, 혹시 버그?"
date: 2006-06-19 13:18:57
categories: gossip
tags: google gmail
author: Samgu Lee
---

GMail은 메일 표준을 거의 완벽하게 지키고 있습니다. 하지만 가끔 제목이 깨지는 경우가 있는데 이유를 알아봅니다.

원래 메일을 보내고 받는 역할을 하는 메일서버는 다국어를 염두에 두지 않았기 때문에 한글을 이용할 경우 깨지는 것이 정상입니다. 하지만, 현재 많은 꽁수(?)가 들어갔기 때문에 한국대 한국은 서로가 서로를 대충 지원해 주기 때문에 깨지는 경우는 좀처럼 발생하지 않습니다만, 외국의 웹메일등은 한글을 사용할 때 국내 메일서버와 호환이 되지 않는 현상이 발생할 수 있습니다. 왜 이런 일이 발생할까요?

한글이 깨지는 현상을 이해하기 위해선 인코딩이라는 용어를 이해할 필요가 있습니다. 같은 음악이라도 MP3, OGG, WMA 등의 다양한 확장자가 존재하듯이 언어도 어떻게 인코딩을 하느냐에 따라서 같은 한글이지만 틀린 데이터가 될 수도 있습니다.

무슨 말이냐 하면, "안녕"이라는 단어를 컴퓨터로 표현할 경우 완성형, 조합형 또는 확장완성형 등의 여러가지 표현 방법이 있습니다. 물론 정확한 인코딩 용어는 따로 있습니다. 현재 유니코드의 발전으로 인해 대게의 컴퓨터에서 유니코드를 지원하기 때문에 메일 서버도 유니코드 인코딩이 대세로 굳어지고 있습니다.

## 웹에서의 인코딩

웹사이트를 만들어 본 분이라면 euc-kr이라는 말을 들어보았을 것입니다. 들어보지 못한 분은 브라우져에서 "보기" -> "문자인코딩"을 선택하면 서유럽어, 유니코드, 한글 등의 메뉴가 보이는 것을 확인할 수 있습니다. 즉, 웹사이트를 만든 제작자가 euc-kr이라는 방식으로 인코딩을 할 경우 보는 사람도 euc-kr로 봐야 제대로 보입니다. 유니코드 기반인 UTF-8이라는 방식으로 제작할 경우 UTF-8로 봐야 제대로 보입니다.

대부분 브라우져에서 자동으로 세팅이 맞춰주기 때문에 이 부분은 신경을 쓰지 않아도 되지만, 가끔 한글이 와장창 깨져서 나올 때가 있습니다. 이 것이 인코딩이 맞지 않아서 입니다.

정리하면, 모든 한글은 보낸 이의 인코딩 방식을 알아야 제대로 볼 수 있다는 의미입니다.

## euc-kr은 한국 내에서만 쓸 수 있는 방식

euc-kr은 한글의 고유 인코딩 방식입니다. 전통적으로 유니코드가 일반화 되지 않았을 때에 가장 많이 사용되던 인코딩 방식이고, 지금도 대부분의 포탈사이트들이 웹사이트를 제작할 때 euc-kr로 제작합니다. 하지만, 최근 테터툴즈는 euc-kr을 버리고 UTF-8을 기본으로 채택하기도 했습니다.

메일은 대부분 한국 내에서 보내지고 받습니다. 웹메일 업체들은 인코딩이 따로 설정되어 있지 않으면 euc-kr로 해석을 하기 때문에 따로 인코딩하지 않고 보내도 잘 보입니다. 하지만, 이 이유 때문에 외국의 웹메일에서 한글이 가끔 깨지는 현상이 발생하게 됩니다.

## 한글이 안깨지게 할 수는 없나?

GMail은 많은 경우 인코딩을 하지 않아도 언어를 판독해서 인코딩을 찾아주는 기능이 있습니다. 물론, 메일 본문의 인코딩 방식을 참조하게 됩니다. 하지만, 보내는 메일 서버가 인코딩 방식을 전혀 알려주지 않을 경우 GMail은 한글을 제대로 인식하지 못하게 됩니다.

이 현상은 보내는 사람이 메일 표준을 지키지 않아서 입니다. 영어가 아닌 문자는 인코딩을 해서 전송을 해야 합니다. 한국의 웹메일에서 깨지지 않고 보이는 것은 당연히 euc-kr 방식의 인코딩인 것으로 해석을 했기 때문이지 더 뛰어나서는 아닙니다.

따라서, 받는 쪽에서 기본 인코딩을 euc-kr로 하는 방법도 있기는 하지만, 그 기능을 GMail에서는 지원하지 않습니다. 사실 그런 기능을 웹메일에서 지원하는 경우는 보질 못했습니다. 하지만, 아웃룩 익스프레스 같은 경우 기본 인코딩을 지정해 줄 수 있기 때문에 euc-kr로 세팅하면 한글 메일은 깨지지 않고 잘 보입니다. 하지만, 이것도 중국어나 일본어 등의 메일이 인코딩을 하지 않고 올 경우 깨지는 현상을 피할 수는 없습니다.

## 최선의 선택

보내는 회사의 메일서버 관리자에게 인코딩을 해 달라고 말하는 방법이 가장 좋습니다. 이 문제는 보내는 쪽의 문제이지 받는 쪽의 문제가 아니기 때문입니다. GMail의 출현으로 네이버나 다음도 보내는 옵션에서 유니코드로 발송하기가 추가되었다는 사실이 이를 반증합니다.

다만, Google 데스크톱에 들어있는 이메일 플러그인에는 자동으로 인코딩 방식을 디텍팅해 주는 기능이 더 강력하기 때문에 GMail에서 제대로 보이지 않는 것도 데스크톱 이메일 플러그인에서는 제대로 보이는 경우가 많습니다.
