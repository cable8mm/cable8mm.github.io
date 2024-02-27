---
layout: single
title: "내가 선택한 최고의 블로깅 플랫폼 Jekyll"
date: 2024-02-26 14:32:00
categories: blog
tags: opinion
author: Samgu Lee
header:
  og_image: /assets/images/jekyll-og.png
---

여러가지 블로깅 플랫폼을 사용해 본 후 Jekyll를 선택한 이유를 설명해 보겠습니다.

![JamStack 블로깅 플랫폼 Jekyll]({{ page.header.og_image }})

Jekyll(/ˌdʒek.əl/)은 한국 발음으로 제컬이라고 하며, 지킬박사와 하이드에서의 그 지킬이 Jekyll 입니다. [Jekyll](https://jekyllrb.com)은 데이터베이스를 사용하지 않고, 블로거가 작성한 마크다운 타입의 문서를 HTML로 변환해서 보내는 역할을 하는 일종의 사이트 빌더입니다.

> Transform your plain text into static websites and blogs.
>
> \- Jykyll

## Jekyll의 장점, 서버비까지 100% 무료

깃헙이 공식적으로 지원하고 있으며, Jekyll을 사용하면 무료로 [깃헙 페이지](https://pages.github.com)에 나의 블로그를 만들고, 도메인을 연결할 수 있습니다.

![Jekyll의 쇼케이스](/assets/images/jekull-showcase.png)

내가 블로깅 툴을 운영하면서 필요했던 것은 세가지 입니다.

1. 내가 만든 문서에 HTML코드나 디자인, 혹은 광고 관련 코드가 저장되서 저장되면 안된다.
2. 나의 도메인과 연결할 수 있어야 하며, 사용제약이 있으면 안된다.
3. 테마가 있어야 하며, 테마를 커스텀할 수도 있어야 한다.

내가 사용해 본 블로깅 플랫폼은 `wordpress`, `tattertools`, `tistory`, `naver blog`, `naver post`, `google blogger`, `gitbooks`, `Wix` 등 입니다.

이 모든 툴들은 데이터베이스를 이용하며, 디자인 코드가 나의 글에 포함되기 때문에 콘텐츠에 집중하기가 쉽지 않습니다. 이 문제를 해결하기 위해서 해외에서는 `Medium`이나 `dev.to` 등이 나오기도 했습니다.

## JamStack 블로깅 플랫폼

내가 필요한 두가지 기능을 지원하는 블로깅 플랫폼은 없었는데요, 순수 HTML 개발 환경을 추구하는 `JamStack`을 공부하면서 알게 된 웹사이트 제네레이터 중 몇가지가 눈에 띄었습니다.

1. [Jekyll](https://jekyllrb.com)
2. [Docusaurus](https://docusaurus.io)
3. [Astro](https://astro.build)

이 세가지 플랫폼은 모두 깃헙 페이지에 내 글을 올리고 도메인을 연결할 수 있습니다. 또한 마크다운으로 글을 쓰면 대부분의 것들이 자동으로 이루어 집니다.

> Jekyll is one of the most mature static site generators around and has been a great tool to use — in fact, before Docusaurus, most of Facebook's Open Source websites are/were built on Jekyll! It is extremely simple to get started. We want to bring a similar developer experience as building a static site with Jekyll.
>
> \- docusaurus 도움말 중 [디자인 철학 섹션](https://docusaurus.io/docs#design-principles) 일부 인용

특히 Docusaurus는 메타(구 페이스북)가 Jekyll로 사이트를 제작하다가 그 이상의 기능이 필요해서 직접 만들어서 배포하는 것으로 웹사이트 빌더로 손색이 없습니다.

전 너무 많은 기능을 좋아하지 않습니다. 제가 원하는 것은 마크다운으로 문서만 만들면 나머지는 자동으로 배포가 되어야 하며, 서버 관리 포함해서 아무런 행위도 필요하지 않아야 한다는 것입니다.

## 그래서 선택한 Jekyll

Jekyll을 선택한 이유는 [깃헙이 공식적으로 지원하는 유일한 플랫폼](https://docs.github.com/ko/pages/setting-up-a-github-pages-site-with-jekyll/about-github-pages-and-jekyll)이라는 점이지만, 제작 철학도 저와 잘 맞았습니다. Jekyll의 개발 커뮤니티를 보면 사용하는 개발자들이 여러가지 제안을 하지만, 글쓰기 작업에 부가적인 행위가 필요할 경우 거부됩니다.

![글의 이력을 관리할 수 있는 깃헙 PR](/assets/images/github-page-screenshot.png)

즉, 오랜 기간이 지났지만 여전히 Jekyll는 [마크다운](https://docs.github.com/ko/get-started/writing-on-github/getting-started-with-writing-and-formatting-on-github/basic-writing-and-formatting-syntax)을 만드는 것으로 모든 작업이 마무리 됩니다.

전 문서를 작성하는 도구로 [Visual Studio Code](https://code.visualstudio.com) + Markdown Preview 를 사용하며, 자동화 툴로 아래의 것들을 이용합니다.

1. 문서 포멧 맞춤기
2. 깨진 링크 리포팅
3. 나의 깃헙 저장소에서 글 작성이 마무리 후 배포
4. 배포 전에 나의 컴퓨터에서 미리보기

## 마크다운과 Jekyll, 제약이 주는 편안함

블로깅을 하게 되면 디자인과 기능에 상당히 신경이 쓰입니다. 그래서 내 글에 기능과 디자인 코드가 포함됩니다.

임계점이 넘어가면 내 글은 이미 글이 아니라 브로셔가 되어 가며, 블로그 도구를 이전할 수도 없게 되며, 최종적으로는 글을 작성하지 않게 됩니다.

![글쓰기에 집중할 수 있는 마크다운 편집기](/assets/images/my-writing-screenshot.png)

마크다운은 글의 색깔도 바꿀 수 없습니다. 타이틀이 아니면 폰트 크기도 키울 수 없죠. 이런 제약은 모바일이던 컴퓨터던 보는 사람이 편하게 볼 수 있는 기능을 플랫폼에서 추가할 수 있게 해 줍니다.

그리고, 웹 편집기에 비해서 비교도 안되게 편한 마크다운 편집기를 컴퓨터에 설치해서 글을 쓰는 것은 최고의 경험을 제공합니다.

![테마 기능을 제공하는 Jekyll](/assets/images/jekyll-sample-blog.png)

이 것이 제가 돌아돌아 Jekyll로 온 이유입니다.

Jekyll가 어떻게 관리되고 있는지는 [레포지토리를 오픈](https://github.com/cable8mm/cable8mm.github.io)해 놨으니 누구나 볼 수 있습니다.
