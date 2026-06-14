---
layout: single
title: "AI Issue Publisher: AI와의 대화, 3초 만에 깃헙 이슈(Issue)로 박아버리는 방법"
date: 2026-06-14 23:36:00
categories: development
tags: ai-issue github issues ai development replworks
author: Samgu Lee
header:
  og_image: /assets/images/issues-generated-by-ai-issue.png
---

안녕하세요, 개발자 여러분! 오늘도 ChatGPT, Claude, Cursor랑 밤새도록 티키타카하면서 코드 짜고 계신가요?

요즘 AI랑 대화하다 보면 **"와, 이거 진짜 괜찮은 아이디어인데?", "이 리팩토링 제안은 나중에 꼭 반영해야겠다"** 싶은 순간들이 정말 많죠. 하지만 밀려드는 작업 속에 깜빡하고 창을 닫아버리거나, 나중에 찾으려고 히스토리를 끝없이 스크롤해 본 경험… 다들 한 번쯤 있으실 겁니다.

AI와의 대화를 통해 만들어진 이슈를 내 계정이 아닌 다른 계정으로 올리고 싶으신가요? 그것도 깃헙 약관에 위반되지 않게 말이죠.

![AI 계정으로 이슈 올리는 가장 빠른 방법](/assets/images/issues-generated-by-ai-issue.png)

그렇게 대화창 속에 묻혀버리는 주옥같은 AI의 아이디어들을 단 한 줄의 명령어만으로 깃헙 이슈(Github Issues)로 내 계정이 아닌 AI Bot 계정으로 만들 수 있는 아주 유용한 CLI 도구를 공개해서 소개해 드리려고 합니다.

이름하여 **`AI Issue Publisher`** 입니다!

## AI가 쓰고, 인간이 결정한다

이 도구의 핵심 철학은 아주 명확합니다. **"Author ≠ Publisher (작성자와 발행자는 다르다)"**

* **AI**는 아이디어를 정교하게 작성하고,
* **인간(개발자)**은 그 내용을 검토한 뒤,
* 이걸 진짜 우리의 작업(Work)으로 만들지 **명시적으로 결정**하는 것이죠.

AI가 자동으로 내 레포지토리에 이슈를 마구잡이로 생성하는 게 아니라, 내가 복사한 내용만 쏙 골라 깃헙 이슈로 깔끔하게 템플릿화해 줍니다.

## 🛠 3초 만에 설치하기

Mac 사용자라면 우리의 친구 홈브루(Homebrew)로, Go 개발자라면 `go install`로 간편하게 설치할 수 있습니다.

### Homebrew (추천)

```bash
brew install replworks/tap/ai-issue
```

### Go

```bash
go install github.com/replworks/ai-issue/cmd/ai-issue@latest
```

설치가 잘 되었는지 확인하려면 아래 진단 명령어를 입력해 보세요.

```bash
ai-issue diagnose
```

---

## 초기 설정 (Token 등록)

깃헙에 이슈를 등록해야 하니 권한이 필요하겠죠?

GitHub에서 **Fine-grained Personal Access Token**을 하나 발급받아 줍니다. 권한(Permissions) 설정에서 **Issues: Read and write**만 체크해 주시면 됩니다.

그 후 터미널 프로필(`~/.zshrc` 또는 `~/.bashrc`)에 토큰을 환경변수로 등록해 주세요.

```bash
export GITHUB_TOKEN=github_pat_여러분의_토큰_값
```

> **💡 꿀팁: AI 전용 아이덴티티 부여하기**
> 이슈가 생성될 때 기본적으로 `@ai-backlog-bot`이라는 이름으로 등록되어 AI가 만든 이슈임을 한눈에 알 수 있게 해줍니다. 만약 봇 이름을 바꾸고 싶다면 아래 환경변수도 같이 등록해 주세요!
> `export AI_ISSUE_PUBLISHER=replworks-bot`

## 실전 사용법: "복사하고, 치면 끝!"

사용법은 허무할 정도로 간단합니다.

1. ChatGPT나 Claude와 나눈 대화가 있다면, "지금 내용을 이슈로 올릴꺼야. markdown으로 만들어줘."라고 해 보세요. 그 문서를 "복사" 아이콘을 클릭합니다.
2. 터미널을 열고 해당 깃헙 레포지토리 디렉토리로 이동한 뒤, `ai-issue` 치고 엔터!

```bash
ai-issue
```

클립보드에 있는 문서를 미리 보여주는데요, 엔터만 한번 더 누르면 끝입니다!

### 예시 화면

AI가 아래와 같이 마크다운으로 답변을 줬다고 해봅시다.

```markdown
# Add timestamps to logging system

Current logs do not contain timestamps, making debugging difficult.

### Acceptance Criteria
- Include UTC timestamps
- Preserve current log format
- Add tests
```

이걸 복사한 상태에서 `ai-issue`를 실행하면?

```bash
$ ai-issue
✅ Issue created successfully!
https://github.com/realworks/ai-issue/issues/42
```

눈 깜짝할 사이에 42번 이슈가 생성된 것을 확인할 수 있습니다.

> **바로 등록하기 부담스럽다면?**
>
> 이슈를 실제로 생성하기 전에 미리 보기만 하고 싶다면 `--dry-run` 옵션을 붙여보세요!
> `ai-issue --dry-run`

---

## 에러가 나나요? 트러블슈팅 가이드

혹시 명령어를 실행했는데 막힌다면 아래 내용을 체크해 보세요.

* **Repository could not be determined**
  * 👉 해당 커맨드는 반드시 **Git 레포지토리 내부(로컬 저장소 폴더 안)**에서 실행해야 합니다. 툴이 자동으로 현재 Git origin 주소를 읽어서 깃헙에 올리기 때문입니다.
* **Clipboard is empty**
  * 👉 커맨드를 치기 전에 AI 대화 내용을 먼저 복사했는지 확인해 주세요!
* **Resource not accessible by personal access token**
  * 👉 깃헙 토큰 권한 문제일 확률이 높습니다. Fine-grained PAT를 썼는지, Issues Read/Write 권한을 줬는지, 토큰 만료일이 366일 이하인지 다시 확인해 보세요.

정 안 된다 싶을 때는 만능 진단 명령어인 `ai-issue diagnose`를 쳐보면 툴이 알아서 어디가 문제인지 콕 집어 줍니다.

---

## 📝 마무리하며

매일 AI 어시스턴트를 끼고 사는 모던 개발자들에게 백로그 관리를 극도로 효율화해 주는 아주 가려운 곳을 긁어준 도구라는 생각이 듭니다. 좋은 아이디어가 스쳐 지나가기 전에 여러분의 깃헙 백로그에 차곡차곡 쌓아보세요!

오픈소스인 만큼 기여(Contribution)나 버그 수정에 관심이 있다면 Go 언어로 작성된 코드(`go test ./...`)를 뜯어보시는 것도 추천합니다. (라이선스는 든든한 MIT!)

오늘도 즐거운 ⚡️초고속 개발⚡️ 되세요!
