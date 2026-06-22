---
layout: single
title: "잘 쓰던 내 CLI 도구가 '멀티 조직(Multi-Org)' 벽에 부딪혔을 때: GitHub Device Flow 전환기"
date: "2026-06-22 21:50:00"
categories: ai development
tags: github github-app device-flow golang cli dx
author: Samgu Lee
header:
  og_image: /assets/images/replworks-ai-issue-issues.png
---

제가 만든 [AI 기반 GitHub 이슈 생성 CLI 도구인 **`ai-issue`**]({% post_url 2026-06-14-introduce-ai-issue-to-you %})를 로컬에서 아주 만족스럽게 사용하고 있었습니다. 터미널에서 명령어 하나로 이슈를 발행해 주는 경험이 꽤 마음에 들었습니다.

그런데 어느 날 예상하지 못한 장벽을 만나게 되었습니다.

![replworks/ai-issue의 이슈들](/assets/images/replworks-ai-issue-issues.png)

바로 **다른 회사, 다른 조직(Organization)의 저장소에도 이슈를 올려야 하는 상황**이 생긴 것입니다.

## 1. 개인 토큰(PAT)의 한계

기존 `ai-issue`는 개발자의 개인 액세스 토큰(PAT)을 환경 변수나 설정 파일에 저장해 사용하는 방식이었습니다.

혼자 사용하는 도구라면 크게 문제 될 것이 없었습니다. 하지만 `replworks` 조직과 `eternops` 조직을 오가며 사용하기 시작하자 불편함이 생겼습니다.

- 조직마다 다른 PAT를 관리해야 하거나
- 하나의 토큰에 여러 조직 권한을 몰아 넣어야 하거나
- 토큰을 발급하고 복사해서 붙여넣는 과정 자체가 번거로웠습니다.

물론 Fine-grained PAT를 사용하면 권한 범위를 제한할 수는 있습니다. 하지만 여러 조직을 오가며 사용하는 CLI 도구의 사용자 경험으로는 여전히 만족스럽지 않았습니다.

개발자에게 가장 큰 적은 결국 **마찰(Friction)** 이라고 생각합니다.

사용자에게 긴 문자열 형태의 토큰을 요구하는 대신, TV나 넷플릭스 로그인처럼 브라우저에서 한 번 승인하면 끝나는 경험이 더 자연스럽다고 생각했습니다.

그래서 인증 구조를 **GitHub App 기반 인증 + Device Flow 방식**으로 전환하기로 했습니다.

## 2. GitHub App 세팅과 생각지 못한 반전

GitHub App을 만들면서 몇 가지 흥미로운 점을 발견했습니다.

### 1) 설치 범위는 `Any account`

앱 생성 과정에서 다음 항목은 반드시 **Any account** 로 설정해야 했습니다.

> Where can this GitHub App be installed?

그래야 `replworks` 뿐만 아니라 `eternops` 같은 다른 조직에서도 동일한 앱을 설치하여 사용할 수 있습니다.

### 2) Webhook은 필요하지 않았습니다

`ai-issue`는 서버 애플리케이션이 아니라 로컬 터미널에서 동작하는 CLI 도구입니다.

GitHub 이벤트를 수신할 일이 없으므로 Webhook 기능은 비활성화하는 편이 더 깔끔했습니다.

### 3) Private Key는 런타임에서는 사용하지 않았습니다

GitHub App을 생성한 뒤 설치하려고 하니 GitHub은 Private Key(`.pem`)를 생성하라고 안내했습니다.

이번 프로젝트에서는 Device Flow를 통해 사용자 인증만 수행하기 때문에, 실제 CLI 실행 시점에는 Private Key를 사용하지 않습니다.

다만 GitHub App 생성 과정에서는 최소 한 번 Private Key를 생성해야 설치 기능이 활성화되므로, 키를 생성해 다운로드한 뒤 그대로 보관만 해두었습니다.

결국 CLI 내부에는 Client ID만 포함하면 충분했습니다.

사용자는 이제 다음과 같이 로그인할 수 있습니다.

```bash
❯ ai-issue login
Open this URL in your browser:
https://github.com/login/device
Enter this code: FCCC-5421
Browser opened automatically.
Login successful. Token saved locally.
```

![Device Activation 화면](/assets/images/github-device-activation.png)

```bash
❯ ai-issue diagnose
=== AI Issue Publisher Diagnostics ===
✅ Git: OK
✅ Repository validation: replworks/ai-issue
✅ Publisher validation: @replworks-bot
✅ Clipboard support: Available
✅ GitHub App token: Loaded
✅ Repository access: replworks/ai-issue

Run `ai-issue` to publish.
```

그러면 브라우저가 열리고 GitHub 인증을 한 번 수행한 뒤 여러 조직의 저장소에 자유롭게 이슈를 발행할 수 있게 됩니다.

## 3. 로컬 테스트 하려다 만난 Go 1.24 의존성 지옥

인증 구조를 바꾸고 로컬에서 테스트를 진행하던 중 또 다른 문제가 나타났습니다.

`golangci-lint`를 설치하지 않고 `go run` 방식으로 실행했더니, 깔끔하던 `go.mod` 파일에 수백 줄의 `// indirect` 의존성이 추가된 것입니다.

린트 도구 하나 실행했을 뿐인데 프로젝트의 가독성이 무너지는 모습은 보고 싶지 않았습니다.

그래서 선택한건 `homebrew` 였습니다.

```bash
# 더러워진 go.mod 복구
go mod tidy

# homebrew 로 설치
brew install golangci-lint
```

`Makefile`은 다음처럼 구성했습니다.

```makefile
lint: ## runs golangci-lint via go run
 golangci-lint run ./...
```

덕분에 프로젝트 의존성과 개발 도구 의존성을 깔끔하게 분리할 수 있었습니다.

## 마치며

이번 작업을 하면서 느낀 것은, 잘 동작하던 도구도 사용 범위가 넓어지는 순간 기존 아키텍처의 한계가 드러난다는 점이었습니다.

PAT 기반 인증은 단순하고 익숙하지만, 여러 조직을 오가며 사용하는 CLI 도구에서는 Device Flow가 훨씬 자연스러운 사용자 경험을 제공해 주었습니다.

아직 완성된 것은 아니지만, 적어도 이제는 토큰을 발급하고 복사해서 붙여넣는 과정 없이 브라우저 인증 한 번으로 여러 조직의 저장소를 다룰 수 있게 되었습니다.

혹시 비슷한 문제를 겪고 계신다면 GitHub App과 Device Flow 조합을 한 번 검토해 보시는 것도 괜찮을 것 같습니다.

p.s.

1인 개발 프로젝트지만, [저는 결정, 승인 및 테스트를 하고, Discussion AI는 제안을, Execution AI는 코딩을 담당](https://www.repl.net/workflow/)하는데요, 그것을 전통적인 개발팀이 개발하는 Git 개발 프로세스 그대로 운영하고 있습니다.

어떻게 운영되는지는 [replworks/ai-issue 의 이슈메뉴](https://github.com/replworks/ai-issue/issues?q=is%3Aissue%20state%3Aclosed)에서 보실 수 있습니다.
