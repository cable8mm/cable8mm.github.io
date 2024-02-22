---
layout: single
title:  "개발자가 알아야 하는 기본(Essentials) 지식들"
date:   2024-02-22 10:07:00
categories: opinion
tags: development
author: Samgu Lee
header:
    og_image: /assets/images/untitlsssssed.png
---
많은 회사들이 특유의 개발 문화와 원칙을 만들어 갑니다. 사내 혹은 그룹도 마찬가지이며, 개발자로서 꼭 가지고 있어야 하는 기술 소양을 설명합니다.

![Various Stacks]({{ page.header.og_image }})

> {tip} 기술 소양이란 단어는 수학의 Axios([공리-무조건 옳다고 가정하고, 증명하지 않는다.](https://namu.wiki/w/%EA%B3%B5%EB%A6%AC))의 느낌으로, 개발을 진행할 때 개발자가 당연히 알고 있다고 가정하는 기술들을 말합니다. 편의상 직무별로 분류하지는 않습니다.

## 언어

### 패키지 매니저

[Composer](https://getcomposer.org/), [NPM](https://www.npmjs.com/) 혹은 [Cocoapods](https://cocoapods.org/)와 같이 가장 많이 사용하는 패키지매니져를 이용하는 방법과 만드는 방법을 알고 경험을 해 봐야 합니다. [Apple](https://developer.apple.com/documentation/xcode/swift-packages)과 [Microsoft](https://learn.microsoft.com/en-us/windows/package-manager/)는 공식 패키지매니저를 제공하고 있고, 저장소로 깃헙을 사용합니다. 패키지를 만든 후 패키지매니저 레퍼지토리에 올리는 방법까지 알아야 합니다.

### 오퍼레이터

integer 이외의 타입에서 오퍼레이터가 어떻게 작동하는지 알아야 합니다. 특히 오퍼레이터 오버로드를 지원하는 언어들에서는 보통 어떻게 개발되는지 깃헙을 통해서 익혀야 할 필요가 있습니다.

### 디버거

디버깅을 하는 방법은 크게 세가지가 있습니다.

1. 프린트
2. 디버거
3. 로그파일
4. 테스트 프레임워크

1번 방법이 가장 편하고 가볍게 이용할 수 있습니다. 2번의 경우 headless 개발, 말하자면 화면이 없거나 로직이 복잡할 경우 break point를 이용하기 위해서 사용합니다. 다만, 이벤트를 이용할 경우에는 제대로 된 값이 나오지 않는 경우가 있습니다.

3번은 stream이나 이벤트 코딩을 할 경우 많이 사용하는데요, 로그파일에 `tail -f` 명령어를 이용해서 화면에 띄워놓고 코딩을 합니다. 로그파일을 중심으로 하기 때문에 [리눅스 pipe 커맨드](https://www.scaler.com/topics/pipe-command-in-linux/)를 과감하게 사용할 수 있어야 원하는 디버깅을 자유롭게 할 수 있습니다.

4번은 [CICD](https://github.blog/2022-02-02-build-ci-cd-pipeline-github-actions-four-steps/)가 널리 보급된 후 필수가 되고 있는데요, 현대 언어들은 예외없이 주력 테스트 프레임워크를 지원합니다. 테스트 프레임워크로 만들어진 테스트 코드는 CICD단계에서 매번 실행되기 때문에 매우 편하고 제가 추천하는 방법입니다.

물론 네가지 모두 모국어를 사용하듯이 편하게 사용할 수 있어야 합니다.

### 테스트

프레임워크는 라이프사이클을 이해하는 것이 무엇보다 중요합니다. 이 경우 프레임워크에서 제공하는 테스트 코드가 어떤 원리로 작동되는지 코드레벨에서 이해해야 합니다.

### 구현

내가 제안하는 구조를 다른 개발자에게 설명하는 방법은 크게 두가지가 있습니다. pseudocode와 다이어그램입니다.

두가지 방법 모두를 이용할 수 있어야 하며, 특히 시퀀스 다이어그램은 툴을 이용해야 하므로 익숙해 지면 질 수록 나의 디자인을 설명하기가 수월해 집니다. 전 markdown 문서와 잘 맞는 [mermaid 다이아그램](https://mermaid.js.org/)을 이용하고 있습니다.

## 테크닉

### 정규표현식

[정규표현식](https://developer.mozilla.org/ko/docs/Web/JavaScript/Guide/Regular_expressions)은 언어마다 차이가 거의 없습니다. 즉, 한번 익혀 놓으면 어떤 언어를 사용하던지 문자열 처리를 어렵지 않게 처리할 수 있습니다.

특히 웹을 개발하면 문자열 처리가 중요해 지기 때문에 반드시 익혀야 합니다. 사람은 죽어서 이름을 남기고, [펄 언어는 죽어서 정규표현식을 남겼습니다](https://perldoc.perl.org/perlre).

### 빌드

자신의 코드가 배포될 때 까지의 과정이 어떻게 진행되는지 알아야 합니다. 현대 개발은 컴파일 언어 뿐만이 아니라 자바스크립트와 같은 스크립트 언어들도 빌드 후 배포됩니다.

컴파일 언어에 비해 스크립트의 빌드는 훨씬 복잡하며, 문제가 생길 가능성이 높습니다. 따라서, 빌드를 하는 전과정을 이해하지 않으면 빌드할 때 발생하는 문제를 해결하기가 어렵습니다.

[Webpack](https://webpack.js.org/)이나 [Vite](https://vitejs.dev/) 와 같은 번들링과 빌드를 지원하는 툴의 소스코드를 이해하는 것이 가장 빠른 방법입니다.

### 깃과 깃헙

깃은 현대 개발에 있어서 이미 가장 중요한 중심이 되고 있습니다. CICD 때문인데요, 따라서 레포지토리를 만들고, 브랜치를 관리하고 PR과 Conflict를 처리할 수 있어야 합니다. 의외로 까다로운데요, 코딩 스타일과 깃헙 액션 등을 과감히 이용하지 않으면 여러명의 개발자들이 동일 레포지토리에서 개발하기가 불가능합니다.

보통 유명한 레포지토리들은 10개 이상의 깃헙액션이 사용되며, [문서와 시스템 전체가 CICD로 자동 배포](https://resources.github.com/ci-cd/)되고 있습니다. 심지어 여러가지 버전이 동시에 개발될 때에도 깃과 깃헙만으로 운영되고 있을 정도입니다.

### 마크다운

[마크다운](https://docs.github.com/en/get-started/writing-on-github/getting-started-with-writing-and-formatting-on-github/basic-writing-and-formatting-syntax)은 문서를 깃으로 만들고 운영하기에 최고의 문서 포멧이며, 별도의 프로그램을 사용하지 않아도 문서를 이해할 수 있을 정도로 매우 단순한 구조입니다. 지금 이 글도 마크다운으로 쓰고 있습니다.

Word나 엑셀을 이용해서 문서를 만들고 있다면 지금부터 마크다운으로 만들어 보세요. 마크다운으로 문서를 만들면 [`md-to-pdf`](https://github.com/simonhaenisch/md-to-pdf) 패키지 등을 이용해서 커맨드로 pdf로 변환할 수 있습니다. 그리고, 그 문서를 깃헙으로 관리하면 매번 필요한 문서를 제작할 필요가 없어집니다.

### 개발 용어

컨벤션, 패턴 용어는 별다른 설명 없이 대화할 수 있어야 합니다. 단, 공식 문서에 용어 그대로 사용해야 하며, 편의상 용어를 바꾸지 않습니다.

> {tip} 테크닉은 꼭 외우고 있어야 할 필요는 없지만, 공식 문서를 보고 할 수 있어야 합니다.

## 레퍼런스 & 가이드

1. 공식 레퍼런스를 영문으로 읽을 수 있거나 읽어야 한다는 강한 욕망이 있어야 합니다.
2. 어떤 언어, 프레임워크, 시스템 등의 자료를 찾을 때 공식 레퍼런스나 가이드를 우선 확인할 수 있어야 합니다.
3. W3C drift, PHP.net document, Laravel Document, Apple Developer Document, Android Developer Document 등 자신의 주력 언어나 프레임워크의 공식 문서는 반복적으로 읽어야 합니다.

개발자가 익혀야 하는 기본을 적어봤습니다. 그리고, [의외로 영어 실력이 중요](https://velog.io/@riwonkim/%EA%B0%9C%EB%B0%9C%EC%9E%90%EB%8A%94-%EC%96%B4%EB%94%94%EA%B9%8C%EC%A7%80-%EA%B3%B5%EB%B6%80%EB%A5%BC-%ED%95%B4%EC%95%BC-%ED%95%98%EB%8A%94%EA%B0%80-%EC%98%81%EC%96%B4%EC%97%90-%EB%8C%80%ED%95%9C-%EC%9D%98%EA%B2%AC)하며, 다른 훌륭한 개발자의 코드를 주기적으로 리뷰하는 것도 도움이 됩니다. [깃헙](https://github.com/)과 [스택오버플로우](https://stackoverflow.com/)는 개발에 있어서 너무나도 중요해서 언급할 필요도 없을 정도입니다.
