---
layout: single
title: "GitHub Release 기반 npm 자동 배포 구축하기 (GitHub Actions)"
date: 2026-07-08 00:11:00 +0900
categories: development
tags: github gitHub-actions npm cicd javaScript automation
author: Samgu Lee
header:
  og_image: /assets/images/npm-homepage.png
---

npm 패키지는 `npm publish` 한 번이면 배포할 수 있습니다. 하지만, Github으로 개발을 하는 환경이 사실상 표준이 되면서 Go, PHP 등 GitHub Release를 기준으로 패키지를 배포하는 프로젝트도 점점 많아지고 있습니다.

![npm 홈페이지](/assets/images/npm-homepage.png)

그래서 이번에는 **GitHub Release만 생성하면 npm 배포까지 자동으로 완료되는 파이프라인**을 구축했습니다.

예제는 오래전에 개발해서 React 전에 사용하던 오픈소스 프로젝트에서 실제 사용 중인 Workflow를 기준으로 설명합니다.

<https://github.com/cable8mm/jquery-infinite-with-template>

구현 자체는 어렵지 않았지만, 실제로는 몇 가지 예상하지 못한 문제를 만났습니다. 이 글에서는 최종적인 워크플로우와 함께, 실제로 겪었던 트러블슈팅을 공유합니다.

## 목표

최종적으로 만들고 싶었던 흐름은 아주 단순했습니다.

```text
git push
      ↓
GitHub Release 생성
      ↓
GitHub Actions 실행
      ↓
npm publish
      ↓
배포 완료
```

개발자는 Release만 생성하면 되고, npm 로그인이나 수동 배포는 더 이상 하지 않는 것이 목표였습니다.

## GitHub Actions 구성

Release가 생성되면 자동으로 실행되는 Workflow를 작성했습니다. 아래 action 은 최종본이며, 실제로 제가 사용하고 있습니다.

NPM_TOKEN 을 만드는 법은 글 하단에 설명하겠습니다.

```yaml
name: Publish to npm
on:
  release:
    types: [created]

jobs:
  build:
    runs-on: ubuntu-latest
    steps:
      - uses: actions/checkout@v7
      - uses: actions/setup-node@v6
        with:
          node-version: "24"
          registry-url: "https://registry.npmjs.org"

      - name: Update version
        run: |
          VERSION=${GITHUB_REF#refs/tags/v}
          npm version $VERSION --no-git-tag-version

      - run: npm ci
      - run: npm publish
        env:
          NODE_AUTH_TOKEN: ${{ secrets.NPM_TOKEN }}
```

핵심은 `release.created` 이벤트입니다.

GitHub Release가 생성되는 순간 Actions가 실행되고, 필요한 의존성을 설치한 뒤 npm에 패키지를 배포합니다.

## 첫 번째 문제

처음 만난 오류는 바로 이것이었습니다.

```text
npm ERR!
You cannot publish over the previously published versions.
```

처음에는 GitHub Actions 설정이 잘못된 줄 알았습니다.

하지만 원인은 훨씬 단순했습니다.

npm은 **이미 배포된 버전을 절대 다시 업로드할 수 없습니다.**

그리고, npm 은 `package.json`의 `version` 값을 사용합니다.

### 해결

Release Tag와 `package.json`의 `version`을 항상 동일하게 맞추도록 변경했습니다.

GitHub의 Release 값을 사용하기 위해서 아래 코드를 추가했습니다.

```yaml
- name: Update version
  run: |
    VERSION=${GITHUB_REF#refs/tags/v}
    npm version $VERSION --no-git-tag-version
```

이 코드는 `package.json`의 `version` 값을 Github Release 값으로 바꿉니다.

## 두 번째 문제

> npm error code EOTP

다음으로 만난 오류는 이것입니다.

```text
npm ERR! code EOTP
```

로컬에서는 정상적으로 Publish가 되는데 GitHub Actions에서만 실패했습니다.

원인은 npm 계정에 **2단계 인증(2FA)** 이 활성화되어 있었기 때문입니다.

GitHub Actions는 당연히 OTP를 입력할 수 없습니다.

### 해결

npm에서 **Access Token**을 생성할 때 `Bypass two-factor authentication (2FA)` 옵션을 활성화했습니다.

![npm bypass 2FA 화면](/assets/images/npm-create-access-token.png)

이 토큰은 CI/CD 환경에서 사용할 수 있도록 만들어진 토큰이라 GitHub Actions에서도 정상적으로 Publish가 가능합니다.

생성한 토큰은 GitHub Repository의

```text
Settings
→ Secrets and variables
→ Actions
```

에

```text
NPM_TOKEN
```

이라는 이름으로 저장했습니다.

![GitHub의 NPM_TOKEN 설명](/assets/images/github-npm-token.png)

이후 Workflow에서는

```yaml
env:
  NODE_AUTH_TOKEN: ${{ secrets.NPM_TOKEN }}
```

만 추가하면 인증이 완료됩니다.

## 구축 후 달라진 점

자동화 전에는 배포할 때마다 다음 작업을 반복했습니다.

- npm 로그인
- 버전 확인
- publish 실행
- 결과 확인

지금은 훨씬 단순합니다.

```text
코드 작성
↓
Release 생성
↓
배포 완료
```

개인적으로는 Homebrew, Composer, npm 모두 GitHub Release를 시작점으로 사용하는 형태로 통일했습니다. 덕분에 어떤 언어의 패키지든 동일한 배포 경험을 유지할 수 있게 되었습니다.

## Release 전에 자동으로 수행되는 작업

배포 전에는 PR로 코드가 업데이트 되는데요, 아래 기능이 모두 자동으로 작동합니다.

- 테스트 코드 실행
- lint
- changelog 자동 생성
- GitHub Release Note 자동 작성(GitHub 기본 기능)
- npm과 GitHub Release 버전 자동 동기화
- 코드의 API 명세를 GitHub Pages로 자동 배포

이렇게 구성하면 Release 버튼 하나만으로 배포가 끝나는 완전한 CI/CD 파이프라인이 됩니다.

## 마무리

GitHub Actions를 이용한 npm 자동 배포는 생각보다 구현이 어렵지 않습니다.

하지만 실제로 구축해 보면 대부분 다음 두 가지에서 시간을 많이 쓰게 됩니다.

- package.json 버전 관리
- npm 인증(2FA)

이 두 가지만 미리 알고 시작해도 시행착오를 크게 줄일 수 있습니다.

개인적으로는 GitHub Release를 배포의 단일 진실(Single Source of Truth)로 사용하는 방식을 선호합니다.

태그, 릴리스 노트, npm 버전이 모두 하나의 이벤트를 기준으로 관리되기 때문에 실수를 줄일 수 있었고, 여러 오픈소스 프로젝트를 운영하는 데도 큰 도움이 되었습니다.
