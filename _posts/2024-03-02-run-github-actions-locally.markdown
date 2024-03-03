---
layout: single
title: "깃헙 액션(Github Action)을 로컬에서 실행하기"
date: 2024-03-02 13:54:00
categories: development
tags: github action local
author: Samgu Lee
header:
  og_image: /assets/images/github-and-docker.png
---

깃헙이 개발에 차지하는 비중이 커지면서, 깃헙 액션을 이용해서 CI와 CD를 구현하는데, 깃헙 액션을 테스트 하기 위한 방법으로 로컬에서 깃헙 액션을 구동하는 방법을 알아봅니다.

![](/assets/images/github-and-docker.png)

## 준비

글의 분량 상 맥을 기준으로 합니다. 윈도우라고 하더라도 순서는 같으며, 핵심이 되는 `act`는 윈도우에서도 구동이 되기 때문에 아무런 문제가 없습니다.

- Homebrew
- Git
- 도커(Docker)
- act

```sh
/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
# Install Homebrew

brew install git
# Install git
```

그리고 도커를 구동하기 위해서 [Docker Desctop](https://www.docker.com/products/docker-desktop/)을 홈페이지에서 다운 받은 후 설치한 후 설정을 체크합니다.

![도커 설정](/assets/images/docker-setting.png)

- Allow the default Docker socket to be used (requires password)
- Allow privileged port mapping (requires password)
- Automatically check configuration

터미널에서 `docker` 명령어가 작동하는지 확인한 후 작동하지 않으면 `.zshrc` 파일에서 아래를 추가해 줍니다.

```sh
export PATH=$PATH:~/.docker/bin

source .zshrc
```

그 후 마지막으로 [act를 설치](https://nektosact.com/installation/homebrew.html)합니다.

```sh
brew install act
# Install act
```

## 실습

깃헙 액션이 있는 레포지토리를 클로닝 합니다. 만약 그런 레포지토리가 없거나 알지 못한다면 아래와 같이 해 보세요.

```sh
git clone https://github.com/cable8mm/n-format

cd n-format
```

그 후 `act -l` 명령어를 실행하면 깃헙 액션 리스트가 보입니다.

```sh
INFO[0000] Using docker host 'unix:///var/run/docker.sock', and daemon socket 'unix:///var/run/docker.sock'
Stage  Job ID   Job name  Workflow name       Workflow file  Events
0      phplint  phplint   PHP Linting (Pint)  lint.yml       workflow_dispatch,push
0      build    build     Test                test.yml       push,pull_request
```

Job name이 `phplint` 와 `build` 가 보이는데요, 잡 이름으로 실행하세요.

```sh
act -j phplint
act -j build
```

## 마무리

로컬에서 모든 깃헙 액션이 실행되는 것은 아닙니다. 예를 들어서, 제가 즐겨 쓰는 `stefanzweifel/git-auto-commit-action@v4` 액션은 코딩 스타일을 검사해서 수정한 후 자동으로 커밋해 주는 액션인데요, act로 실행할 경우 오토커밋이 작동하지 않기 때문에 이 단계에서 멈춥니다.

물론 깃헙과의 인증 프로세스를 만든다면 이런 문제가 없겠지만, 우리가 하려는 것은 로컬에서 구동하는 것이지 깃헙과의 연동이 아니겠죠.

다른 사람이 만들어 놓은 액션을 그대로 사용한다면 로컬에서 깃헙 액션을 구동하는 것이 의미가 없겠지만, 깃헙 액션으로 CICD를 구현하는 등 직접 액션을 만든다면 깃헙에 코드를 푸쉬하고 액션을 구동하고 수정하고 다시 푸쉬하고, 이런 작업을 몇일 동안 반복하는데 로컬 구동은 많은 도움이 됩니다.

도커는 코딩할 때에는 특히 맥 사용자라면 그다지 도움이 되지 않을 수도 있으나, 배포나 테스팅의 경우에는 워크플로(workflow)를 만드는데 도움이 됩니다.

도커의 전문가가 될 필요는 없지만, 도커 사용 방법은 알아두는걸 추천합니다.
