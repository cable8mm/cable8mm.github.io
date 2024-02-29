---
layout: single
title: "구글 코드 검색(Google Code Search)의 공포"
date: 2006-10-07 02:56:37
categories: opinion
tags: google code
author: Samgu Lee
header:
  og_image: /assets/codesearch_logo.gif
---

구글 검색(Google Web Search)에 주민등록번호가 나온다는 이야기처럼, 웹 프로그래머도 자신의 소스를 웹서버에 올리면 안될 것 같습니다.

구글 코드 검색은 가장 많은 소스를 인덱싱하고 있는데, 그 중에는 공개를 원하지 않지만, 편리성을 위해서 웹에 올린 소스들(심지어 압축을 한 소스마져도)을 검색해 줍니다.

![구글 코드 검색 로고](/assets/codesearch_logo.gif)

구글 코드 검색이 런칭된 이후 팔글에선 몇개의 검색어를 이용해서 결과를 살펴봤습니다. 구글랩(Google Labs)의 첫번째 서비스인데도 불구하고, 유니코드를 이용했기 때문에 한글 검색도 지원됩니다. "테터툴즈", "제로보드", "daum.net" 등의 검색결과는 매우 흥미로웠지만, 혹시나 하는 생각에 "정부"로 검색을 해 봤습니다.

"[정부](http://www.google.com/codesearch?q=%EC%A0%95%EB%B6%80&btnG=Search+Code)"의 검색결과 법제처에서 운영하는 동북아 법령 정보센터라는 곳에 JSP 코드가 압축되어 올라온 것이 확인되었습니다. "[대통령](http://www.google.com/codesearch?hl=en&lr=&q=%EB%8C%80%ED%86%B5%EB%A0%B9&btnG=Search)"으로 검색을 해도 비슷한 결과를 볼 수 있습니다. 확인 결과 단순한 게시판 소스인 것으로 확인됐지만, 구글 코드 검색으로 검색되지 않는 코드 마져도 검색을 해 준다는 사실이 확인되었고, 프로그래머들은 자신의 회사 코드가 구글 코드 검색에서 검색 되는지 확인을 할 필요가 있습니다.

외국 블로거들도 구글 코드 검색의 위험성을 알리고 있습니다. [래퍼엑스](http://www.reaper-x.com/2006/10/07/google-codesearch-launched-and-another-problem-has-arise.htm)라는 블로그에선 아파치에서 구글 코드 검색을 피해가는 방법을 설명하고 있고, [Tipsdr.com](http://www.tipsdr.com/?p=442)에선 구글 코드 검색을 이용해서 웹 서비스의 보안홀을 조심하라는 글이 올라오기도 합니다.

구글 코드 검색이 악용될 수 있는 언어는 컴파일이 필요 없는 소위 스크립트 언어라고 불리우는 것들입니다. 예를 들어서, PHP, JSP, ASP를 들 수 있습니다. [deathbycomet.com](http://deathbycomet.com/2006/10/05/some-of-your-db-passwords-are-belong-to-us/)에서 말하는 예재를 살펴 보도록 하겠습니다.

[구글 코드 검색을 이용한 암호 알아보기](http://google.com/codesearch?hl=en&lr=&q=lang%3Aphp+file%3Awp-config+user+-sample&btnG=Search) 링크를 클릭해 보세요.

![구글 코드 검색을 이용한 암호 알아내기](/assets/hack_with_google_code.jpg)

검색 결과를 보면 데이터베이스의 접속 계정과 암호를 알 수 있는 코드가 공개되어 있습니다.

일반적인 이야기지만, 웹서버에 소스가 올라와 있다고 해도 구글이나 어떤 검색엔진도 소스 코드를 얻어 올 수는 없습니다. 이 모든 것이 서버 관리자 혹은 프로그래머의 부주의에 의한 것이지만, 주민등록번호 유출때와 마찬가지로 이런 것들을 신경쓰기가 쉽지는 않습니다.

예를 들어서 웹서비스 개발을 SVN이나 혹은 CVS와 같은 협업툴을 이용할 경우 반드시 보안절차를 거칠 필요가 있고, robots.txt을 설정해 놓을 필요도 있습니다. 그리고, 백업용으로 전체 소스를 압축해서 보관하는 스크립트를 작성해서 주기적으로 실행하는 경우도 있으나, 이 경우도 구글 코드 검색에 의해서 누군가에게 알려질 수도 있습니다.

하지만, 이 내용이 일반적으로 PHP, ASP 그리고 JSP 혹은 CGI 등의 보안이 허술하다는 의미는 아닙니다. 주민등록번호가 검색엔진에 누출되었다고 해서 웹서버인 아파치 혹은 IIS 서버의 보안이 허술하다고 이해해서는 안되는 것과 마찬가지입니다.
