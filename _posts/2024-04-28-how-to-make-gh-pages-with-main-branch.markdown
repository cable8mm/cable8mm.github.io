---
layout: single
title: "Github 소스 레포지토리에 API 도큐먼트를 깃헙 페이지에 만들기"
date: 2024-04-28 13:54:00 +0900
categories: development
tags: github pages gh-pages
author: Samgu Lee
header:
  og_image: /assets/images/screenshot-doctum-api-documents.png
---

소스를 작성하면 테스트 코드와 더불어 API 문서를 만들어 동료나 혹은 다른 개발자가 사용하기 쉽게 도큐먼트를 제공합니다.

![Doctum API documents](/assets/images/screenshot-doctum-api-documents.png)

여러가지 라이브러리나 솔루션이 있겠지만, PHP 에서 사용할 수 있는 가장 쉬운 방법과 깃헙 페이지에 올릴 수 있는 방법을 소개합니다.

## API 문서 만들기

PHP에서 가장 쉽게 사용할 수 있는 라이브러리는 라라벨에서도 사용되는 [doctum](https://github.com/code-lts/doctum) 입니다. doctum 깃헙 레포지토리에서 설치 방법이 자세히 나와있는데요, 요약하자면,

```shell
curl -O https://doctum.long-term.support/releases/latest/doctum.phar

mv doctum.phar ~/bin/
```

이제 소스의 `composer.json` 파일에 아래의 내용을 추가합니다.

```json
"scripts": {
    "apidoc": "rm -rf build; rm -rf cache; doctum.phar update doctum.php --output-format=github --no-ansi --no-progress -v;",
    "opendoc": "open build/index.html"
}
```

이제 `composer apidoc` 명령어로 api 문서를 만들 수 있고, `composer opendoc` 명령어로 api 를 브라우져로 띄울 수 있게 되었습니다.

## 깃헙 페이지로 배포하기

소스코드의 브랜치는 일반적으로 `main` 혹은 `master` 입니다. 깃헙은 `gh-pages`라는 특별한 브랜치를 제공하는데요, 이 브랜치는 `orphan` 으로 사용됩니다. `orphan`은 다른 브랜치와는 완전히 별도로 관리됨을 의미입니다.

아래와 같은 명령어를 이용해서 깃헙에 `gh-pages` 브랜치를 만듭니다.

```shell
git checkout --orphan gh-pages\
git reset --hard\
git commit --allow-empty -m "first commit to gh-pages branch"\
git push origin gh-pages\
git checkout main
```

깃헙 레포지토리를 방문해서 `gh-pages` 브랜치가 생성되었는지 확인해 보세요.

## 깃헙 페이지에 api 문서 배포하기

우선 깃헙 페이지에 필요한 api 문서는 로컬에서 만들어지는 것이 아닙니다. 깃헙 액션으로 만듭니다. 개발 머신에 `doctum`을 설치한 이유는 테스트를 하기 위함입니다.

우선 깃헙 레포지토리에서 깃헙 페이지를 활성화 합니다.

상단에서 `Settings`을 클릭하고, 좌측 메뉴에서 `Pages`를 클릭 후 `Build and deployment` `Source` 에서 `Github Actions`를 선택하세요.

![Github Pages](/assets/images/screenshot-of-github-page.png)

깃헙에서의 준비는 끝났습니다. 이제 깃헙 액션으로 doctum으로 만들어진 api 문서를 깃헙 페이지로 배포하는 액션을 `.github/workflows` 폴더에 넣습니다.

```yml
name: deploy-to-github-pages

on:
  release:
    types: [released]

permissions: {}

jobs:
  publish-pages:
    permissions:
      contents: write
    uses: cable8mm/.github/.github/workflows/deploy-to-github-pages.yml@main
```

위의 스크립트는 Release를 만들면 깃헙 페이지에 api문서를 만들어서 배포하는 액션입니다.

이런 방법으로 저의 오픈소스 프로젝트인 [The Xeed](https://github.com/cable8mm/xeed) 에서는 [API 문서](https://www.palgle.com/xeed/) 도메인으로 api 문서를 제공하고 있으며, 레포지토리 우측 website 섹션에 api 주소를 표기해 놨습니다.

이 방법에 대한 코멘트는 <https://github.com/cable8mm/cable8mm.github.io> 의 이슈를 통해 여러분의 의견을 공유 해 주세요.
