---
layout: single
title: "구글 워드프로세서로 티스토리 글올리기"
date: 2007-02-28 08:57:18
categories: service
tags: google wordprocessor tistory
author: Samgu Lee
header:
  og_image: /assets/tistory-must-set-because-of-space.jpg
---

라이틀리를 인수한 구글 워드프로세서에서 티스토리에 글을 올릴 수 있게 될까요?

라이틀리(Writely)를 [인수]({% post_url 2006-10-19-mna-guide-with-korea %})해서 구글에 편입시킨 구글 워드프로세서&스프레드쉬트는 블로그API를 이용해서 글을 올리는 기능을 제공한다. 하지만, 몇개의 블로그에서는 구글 워드프로세서로 글이 올라가지 않는다고 한다.

[VoIP on WEB2.0](http://mushman.tistory.com/entry/BlogAPI%EA%B0%80-%EA%B5%AC%EA%B8%80-%EB%8B%A5%EC%8A%A4%EC%97%90%EC%84%9C-%EC%A0%9C%EB%8C%80%EB%A1%9C-%EC%95%88%EB%90%98%EB%8A%94%EA%B5%B0%EC%9A%94)에서는 자세한 그림과 함께 설명해 놓았는데, TNC의 개발자로 있는 [겐도사마님](http://gendoh.tistory.com/2510869)은 이 문제에 대해서 다음과 같은 답변을 남겼다.

> 테스트 결과 구글 닥스가 제일 처음 블로그 정보를 제대로 해석하지 못하는 상황입니다. 작년에 태터에서 작업할때는 잘 되었던 것으로 기억하고 요즘 태터도 잘 안된다고 들었기에 아마 구글 닥스 내부적인 문제로 보고 있습니다.

일반적으로 구글의 베타서비스들은 한글 지원에 문제가 있고, 그에 착안해서 몇번의 테스트를 통해 무엇이 문제인지 알 수 있었다. 이 해결책을 이용하면 귀찮기는 하겠지만, 구글 워드프로세서에서 티스토리의 관리가 가능하다.

![구글로 티스토리에 글 올리기](/assets/tistory-must-set-because-of-space.jpg)

두 서비스간의 충돌이 일어나는 부분은 바로 "블로그 제목" 부분이다. 결론만 말하자면, 블로그 제목을 영문으로만 작성한다면 두 서비스의 원활한 사용이 가능하다. 예를 들어보자.

    (o)palgle
    (x)pal gle - 빈 칸 때문
    (x)palgle2.0 - 점 때문
    (x)팔글 - 한글이기 때문

겐도사마님의 코멘트로 미루어볼 때, 블로그API는 데이터를 전송하기 전에 블로그의 정보를 주고 받는데, 그 정보를 인코딩하는 과정에서 구글이나 혹은 TNC에서 인코딩을 하지 않았을 가능성이 높다.

기술적으로 갈증이 난다면, 구글이 처리하는 [블로그API](http://code.google.com/apis/blogger/gdata.html)를 살펴볼 필요가 있다.

구글 코드의 레퍼런스를 참고할 때, 구글은 제목과 본문을 다음과 같은 코드로 처리하라고 권고하고 있다.

```javascript
myEntry.setTitle(new PlainTextConstruct(“[제목]”));
myEntry.setContent(new PlainTextConstruct(“

[본문]

“));
```

자, 이제 정리를 해 보자.

티스토리와 구글 워드프로세서의 충돌은 블로그 제목 때문이고, 영문으로만 작성되어 있다면 충돌이 일어나지 않는다. 여기서 말하는 영문은 빈칸도 안되고, 마침표도 안되는, 말 그대로 영문 스펠링 26자만 해당된다.

답은 : 알파벳 26자로 블로그 제목을 적고, 구글 워드프로세서로 게시하면 원활한 블로깅이 가능하다... 라고는 해도, 이렇게까지 할 사람이 있을까?
