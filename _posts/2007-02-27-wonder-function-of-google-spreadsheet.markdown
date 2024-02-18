---
layout: single
title:  "구글 스프레드쉬트의 멋진 함수 기능"
date:   2007-02-27 09:49:21 +09:00
categories: service
tags: google spreadsheet
author: Samgu Lee
---
구글 오피스로도 불리우는 "구글 워드프로세서&스프레드쉬트"는 시험적이면서도 매우 독특한 두가지 함수를 제공한다. 이 함수들은 구글의 서로 다른 서비스를 이용한 것으로 MS오피스와 같은 설치형 프로그램에서는 구현하기 힘든, 온라인 오피스만의 기능이라고 할 수 있다.

![구글 스프레드쉬트의 구글 함수](/assets/google-function-on-google-spreadsheet.jpg)

두가지 함수는 GoogleFinance와 GoogleLookup 함수. 이 두개의 함수를 알아보자.

## GoogleFinance 함수

이 함수를 이용하면 주식시장 시세 및 기타 데이터를 업데이트할 수 있다. 다음의 코드를 보자.

```javascript
GoogleFinance(“GOOG”)
GoogleFinance(“GOOG”, “volume”)
```

위의 함수는 각각 구글의 현재 주가와 주가총액을 나타내는 식이다. 함수에 사용된 GOOG는 구글 고유의 기호(Symbol)로, GOOG 대신 YHOO를 넣으면 야후의 값이 나타나게 된다.

이 함수의 더 많은 속성은 [도움말 페이지](http://docs.google.com/support/spreadsheets/bin/answer.py?answer=54198&hl=ko)를 참고하자.

## GoogleLookup 함수

이 함수는 위에서 언급한 파이낸스 함수보다 멋지다! 구글에 관심이 있는 사용자라면 Q&A 서비스를 알 것이다. 구글 검색엔진은 단편적인 질문에는 정답이라 생각하는 단어를 표시해 준다.

예를 들어서, 구글의 검색창에 문근영 생일을 넣는다면, 구글은 단번에 생년월일을 알려준다. 이 기능은 한국판에 [적용](http://googlekoreablog.blogspot.com/2007/01/qa.html)된 것은 얼마되지 않지만, 영문판의 경우 상당히 활성화되어 있는 기능이다.

구글 스프레드쉬트는 이 기능을 구글룩업(GoogleLookup) 함수에 넣었다.

다음을 보도록 하자.

```javascript
GoogleLookup(“Paraguay”, “internet users”)
GoogleLookup(“John Lennon”, “date of birth”)
```

위의 함수는 각각 파라과이의 인터넷 사용자수와 존 레논의 생일을 보여준다.

구글 스프레드쉬트는 오픈오피스를 기반으로 하나씩하나씩 함수들을 구현하고 있다. 하지만, 구글 함수들은 설치형에서는 볼 수 없는 흥미로운 결과를 보여준다.

팔글에선 위의 내용을 구글 스프레드쉬트로 구현한 화면을 [공유](http://spreadsheets.google.com/pub?key=pb6WYFbZ8SD6FJ0QzNV7KUQ)해 보았다. 흥미롭게도, 구글 함수를 쓴 부분에 자동으로 각주가 붙어서 출처를 알 수 있도록 돕고 있다.

![구글 오피스로 만든 웹페이지, 각주가 자동으로 붙는다](/assets/sample-using-google-docs.jpg)

구글 오피스가 실제로 널리 사용될런지는 확신할 수 없지만, 구글 오피스는 최소한 구글이 쓰는 정식 명칭보다는 훨씬 훌륭하다.
