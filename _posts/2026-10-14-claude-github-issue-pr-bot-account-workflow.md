---
title: "이슈에 @claude만 남겼더니 PR이 올라옵니다: 봇 계정으로 완성한 Claude + GitHub 협업 세팅"
date: 2026-10-14 16:00:00 +0900
excerpt: "이슈에 @claude를 멘션하면 Claude가 PR을 만들고, 저는 모바일에서 리뷰하고 머지만 합니다. 로컬 PR의 리뷰 요청 문제를 봇 계정으로 푼 과정과 저장소별 세팅 체크리스트를 정리했습니다."
categories: development
tags: claude, claude-code, github, github-actions, ai-workflow, 자동화
author: Samgu Lee
header:
  og_image: /assets/images/pr-with-claude.png
---

이슈에 `@claude`를 멘션하면 Claude가 브랜치를 만들어 작업하고, PR을 열고, 저를 리뷰어로 지정합니다. 저는 GitHub 모바일 앱으로 알림을 받아 리뷰하고 머지합니다.

처음에는 로컬에서 Claude Code로 작업한 PR에서 막혔습니다. 로컬 Claude Code는 제 컴퓨터의 `gh` 로그인을 그대로 쓰기 때문에 PR 작성자가 저로 찍히고, **GitHub는 PR 작성자 본인에게 리뷰를 요청할 수 없습니다.** 리뷰 요청 알림이 오지 않으니 모바일에서 리뷰하는 흐름이 성립하지 않았습니다. 그래서 봇 계정을 하나 만들어 PR을 대신 열게 했고, 이슈 기반 흐름과 로컬 흐름을 같은 모양으로 맞췄습니다.

이 글은 새 저장소에 이 흐름을 세팅할 때마다 보는 체크리스트입니다. 바로 세팅하려면 [실전: 새 저장소 세팅](#실전-새-저장소-세팅)만 따라 하시면 됩니다. 그 뒤의 [원리](#원리-각-설정이-하는-일)는 각 설정이 왜 필요한지, 처음 세팅하면서 실제로 막혔던 지점과 함께 적었습니다.

> 이 글은 macOS 기준이고, Claude Code와 GitHub 앱의 설치 화면은 2026년 10월 기준입니다. 화면이나 옵션은 버전에 따라 달라질 수 있습니다.

![Claude와 함께 하는 PR](/assets/images/pr-with-claude.png)

## 완성된 흐름

### GitHub 웹에서: 이슈로 시작

1. 제가 이슈를 만들고, 제목이나 본문에 `@claude`를 넣습니다.
2. Claude가 이슈에 답변을 남깁니다. 코드를 고쳐야 하는 일이면 브랜치를 만들어 작업하고 PR을 엽니다. 검토나 질문처럼 답변만으로 끝나는 일이면 PR 없이 이슈 댓글로 마칩니다.
3. PR은 Claude 앱(`claude[bot]`)이 열고, 리뷰어는 저, 담당자는 봇 계정입니다.
4. 저는 모바일 앱으로 리뷰 요청 알림을 받아 리뷰하고, 궁금한 점은 PR 댓글에 `@claude`를 붙여 묻습니다.
5. 리뷰가 끝나면 제가 머지합니다. PR 본문의 `Closes #이슈번호` 덕분에 이슈도 함께 닫힙니다.

### Claude Code 앱에서: 대화로 시작

1. 준비된 프롬프트로 협업 규칙을 알려줍니다. 저장소마다 한 번이면 됩니다.
2. 요청을 대화로 나누고 정리한 뒤, Claude에게 PR을 만들어 달라고 합니다. 작업이 끝나면 Claude가 먼저 PR을 만들자고 제안하는 경우가 많습니다.
3. 제가 승인하면 Claude가 PR을 만듭니다. PR은 봇 계정이 열고, 리뷰어는 저, 담당자는 봇 계정입니다.
4. 리뷰하고 머지하는 것은 웹 흐름과 같습니다.

### 한눈에 보기

| 시작                         | PR 작성자              | 리뷰어 | 담당자(assignee) | 머지 |
| ---------------------------- | ---------------------- | ------ | ---------------- | ---- |
| GitHub 웹: 이슈에 `@claude`  | Claude 앱(claude[bot]) | 나     | 봇 계정          | 나   |
| Claude Code 앱: 대화 후 승인 | 봇 계정                | 나     | 봇 계정          | 나   |

공통 규칙:

- 커밋 작성자는 항상 제 이름입니다. 끝에 `Co-Authored-By: Claude` 줄이 붙습니다. 이 부분은 고민을 조금 했는데요, 책임자를 넣는게 맞는 것 같아서 제 이름을 넣었습니다.
- 커밋 메시지는 [Conventional Commits 1.0.0](https://www.conventionalcommits.org/en/v1.0.0/)을 따릅니다.
- 리뷰가 필요한 PR에서는 PR 댓글에 `@claude 이 PR 리뷰해줘`라고 요청합니다. PR마다 도는 자동 리뷰는 쓰지 않습니다. PR을 대부분 Claude가 만들기 때문에, 자동 리뷰는 Claude가 자기 작업을 다시 리뷰하는 셈이었습니다.
- 사람이 조작해야 하는 테스트(결제창 E2E 같은 것)는 GitHub Actions에서 돌릴 수 없습니다. Claude가 PR에 "로컬에서 돌려야 할 테스트" 목록을 남기면, 로컬에서 같이 돌리고 머지합니다.

### 왜 봇 계정이 필요한가

앞에서 말한 대로 PR 작성자에게는 GitHub의 룰에 따라 리뷰를 요청할 수 없습니다. 리뷰 요청 알림을 받으려면 PR을 다른 계정이 열어야 합니다. GitHub는 사람 한 명이 무료 계정을 하나만 가질 수 있게 하면서도, 자동화 전용 계정은 따로 운영할 수 있다고 [이용약관](https://docs.github.com/en/site-policy/github-terms/github-terms-of-service)에 안내하고 있습니다. 그 자동화 계정을 봇으로 씁니다.

담당자는 두 흐름 모두 봇 계정입니다. 담당자가 봇 계정이면 AI가 맡은 작업, 저는 리뷰어로 구분됩니다. GitHub 앱(Claude)은 담당자로 지정할 수 없고 사용자 계정만 가능한데, 봇 계정은 GitHub에서는 일반 사용자 계정이라 지정할 수 있습니다.

---

## 실전: 새 저장소 세팅

사람은 GitHub 화면과 토큰이 필요한 일만 하고, 나머지는 Claude Code에 프롬프트 하나를 붙여 맡깁니다.

### 사람이 할 일

처음 한 번:

- [ ] 봇 계정 만들기
- [ ] Claude Code CLI 설치: `brew install --cask claude-code` → `claude` 실행해 로그인
- [ ] `gh auth login`으로 봇 계정 추가 (시크릿 창에서 **봇으로** 로그인)
- [ ] 내 계정으로 되돌리기: `gh auth switch --user <me>`

저장소마다:

- [ ] https://github.com/apps/claude 에서 Claude GitHub 앱을 이 저장소에 설치
- [ ] 터미널에서 `claude setup-token`으로 토큰을 만들어, 저장소 Settings → Secrets and variables → Actions에 `CLAUDE_CODE_OAUTH_TOKEN`으로 등록 (토큰은 Claude에게 보여주지 않습니다)
- [ ] Settings → Actions → General → Fork pull request workflows from outside collaborators: **Require approval for first-time contributors** 이상
- [ ] Settings → General → Pull Requests → **Always suggest updating pull request branches**: 켜기
- [ ] 저장소 폴더에서 `claude`를 실행하고, 아래 값 목록대로 바꾼 프롬프트를 붙여 넣기
- [ ] Claude가 올린 워크플로 PR을 머지
- [ ] 워크플로가 **아닌** 파일을 고치는 작은 이슈를 `@claude` 멘션과 함께 올리고, 번호를 Claude에게 알려주기

### 값 목록

프롬프트에서 아래 자리표시자를 찾아 전부 실제 값으로 바꿉니다.

| 자리표시자       | 뜻             | 예                       |
| ---------------- | -------------- | ------------------------ |
| `<me>`           | 내 GitHub 계정 | cable8mm                 |
| `<bot>`          | 봇 계정        | replworks-bot            |
| `<owner>/<repo>` | 저장소         | cable8mm/laravel-portone |
| `<main>`         | 기본 브랜치    | main                     |

`#N`은 바꾸지 마세요. Claude가 PR을 만들 때 이슈 번호로 채웁니다.

### 프롬프트

{% raw %}

```text
이 저장소에 "이슈 → Claude PR → 내가 리뷰·머지" 협업 흐름을 세팅해줘. 아래 순서대로 진행해. [사용자] 단계는 나에게 할 일을 짧게 알려주고, 완료를 기다린 뒤 다음으로 넘어가.

## 값
- 내 GitHub 계정: <me>
- 봇 계정: <bot>
- 저장소: <owner>/<repo>
- 기본 브랜치: <main>

## 순서
1. `gh auth status`로 <me>와 <bot>이 모두 로그인돼 있고 <me>가 활성인지 확인해. 아니면 [사용자]에게 `gh auth login`으로 봇을 추가하고 `gh auth switch --user <me>`로 되돌리라고 알려줘.
2. `gh secret list`로 `CLAUDE_CODE_OAUTH_TOKEN`이 있는지 이름만 확인해. 없으면 [사용자]에게 등록을 요청해. 토큰 값은 절대 묻지 마.
3. <bot>이 저장소 협업자인지 확인해. 아니면 Write 권한으로 초대하고, `gh auth switch --user <bot>`으로 바꿔 초대를 수락한 뒤, 반드시 `gh auth switch --user <me>`로 되돌려. 권한 검사에 막히면 우회하지 말고 [사용자]에게 넘겨.
4. `.github/workflows/claude.yml`을 작성해. anthropics/claude-code-action@v1의 공식 예제(examples/claude.yml)를 기반으로 하되 다음을 반영해.
   - 트리거: issue_comment(created), pull_request_review_comment(created), issues(opened, assigned), pull_request_review(submitted). 본문·제목·댓글에 `@claude`가 있을 때만 job을 실행.
   - job `if` 조건 앞에 `github.repository == '<owner>/<repo>' &&`를 붙여 포크에서는 건너뛰기.
   - 인증: `claude_code_oauth_token: ${{ secrets.CLAUDE_CODE_OAUTH_TOKEN }}`
   - `additional_permissions`로 `actions: read`를 줘서 PR의 CI 결과를 읽게 해.
   - `claude_args`는 아래 두 줄을 그대로 넣어.
     --allowed-tools "Bash(gh pr create:*),Bash(gh pr view:*)"
     --append-system-prompt "When you push a new branch for an issue, open the pull request yourself with gh pr create against <main> instead of only posting a link. Use a Conventional Commits 1.0.0 title, describe the change and how it was tested in the body, and add 'Closes #N' with the issue number as N. Request a review from the maintainer with --reviewer <me> and assign the pull request to <bot> with --assignee <bot>. Commit messages must also follow Conventional Commits 1.0.0. Tests that need a human or local secrets cannot run here: when the change needs them, do not claim it is verified; list in the pull request the tests the maintainer must run locally and ask them to run them."
   - 자동 리뷰 워크플로(claude-code-review.yml)는 만들지 마. 리뷰는 필요할 때 PR 댓글에 @claude로 요청한다.
   - 이미 claude.yml이 있으면 덮어쓰지 말고 차이를 보여준 뒤 고쳐.
5. 기존 워크플로 중 시크릿이나 GitHub Pages를 쓰는 것이 있으면, 포크에서 실패하지 않도록 `if: github.repository == '<owner>/<repo>'` 가드가 필요한지 보고 제안해. 내가 승인하면 같은 PR에 넣어.
6. 브랜치를 만들어 커밋하고 <me> 계정으로 푸시해. 커밋 메시지는 Conventional Commits 1.0.0, 작성자는 내 git 계정 그대로 두고 끝에 Co-Authored-By: Claude 줄을 붙여. PR은 아래 순서로 열어.
     gh auth switch --user <bot>
     gh pr create --base <main> --reviewer <me> --assignee <bot> ...
     gh auth switch --user <me>
   PR 본문에는 요약과 테스트 계획을 써. 끝나면 `gh auth status`로 <me>가 활성인지 확인하고 PR 링크를 알려줘.
7. [사용자] PR을 머지하고, 워크플로가 아닌 파일을 고치는 작은 이슈를 `@claude` 멘션과 함께 올려 번호를 알려줌.
8. 이슈의 Actions 실행이 끝나면 확인해.
   - Claude가 링크가 아니라 PR을 직접 만들었는지
   - PR 작성자가 Claude 앱인지
   - 리뷰어가 <me>, 담당자가 <bot>인지 (내가 이미 리뷰했다면 리뷰 요청 기록으로 확인)
   - PR 본문에 Closes #이슈번호 가 있는지
   문제가 있으면 Actions 로그를 보고 원인과 해결 방법을 알려줘.

## 세팅 후 이 저장소에서의 규칙
아래 규칙을 이 저장소의 세션 간 기억에 저장하고, 이후 세션에서도 따라.
- 커밋·푸시·PR은 내가 명시적으로 요청하거나 승인할 때만 한다. 작업이 끝나면 PR을 만들자고 먼저 제안해도 된다.
- 기본 브랜치에 직접 커밋하지 않는다. 기본 브랜치에 있으면 커밋할 때 새 브랜치를 만들고, 작업 브랜치에 있으면 거기에 커밋한다. 브랜치 이름은 알아서 짓는다.
- 커밋은 Conventional Commits 1.0.0, 작성자는 내 git 계정 + Co-Authored-By: Claude. 커밋을 봇 이름으로 하지 않는다.
- PR은 봇으로 열고 리뷰어 <me>, 담당자 <bot>. 끝나면 반드시 `gh auth switch --user <me>`.
- 자동 머지를 걸지 않고, 내가 요청하지 않으면 머지하지 않는다.
- 머지된 뒤에는 기본 브랜치로 돌아가 pull 하고, 머지된 로컬 브랜치를 지운다.
- 사람이 조작해야 하거나 로컬 비밀값이 필요한 테스트는 PR에 "검증됨"이라고 쓰지 않고, 로컬에서 돌릴 목록을 적어 나에게 요청한다. 함께 돌릴 때는 내가 할 일을 짧은 번호 목록으로 미리 알려준다.
- 저장소에 작업 규칙 문서(AGENTS.md 등)가 있으면 그 문서를 우선한다.
- 저장소 설정을 바꾸는 일은 내 승인을 받고 한다. 권한 검사에 막히면 우회하지 말고 나에게 방법을 알려준다.
```

{% endraw %}

### 시험하기

웹 흐름은 이슈를 올리고 Claude에게 번호를 알려주면 프롬프트 8번에서 Claude가 확인합니다. 직접 볼 때는 아래만 보면 됩니다.

- [ ] 이슈에 "Claude Code is working…" 댓글이 달린다
- [ ] Claude가 PR을 직접 만든다 (작성자: Claude 앱)
- [ ] 리뷰어가 나, 담당자가 봇이고, 모바일 앱으로 리뷰 요청 알림이 온다
- [ ] PR 본문에 `Closes #이슈번호`가 있고, 머지하면 이슈가 닫힌다

Claude Code 앱 흐름도 한 번:

- [ ] Claude Code 앱에서 작은 수정을 대화로 정리하고 PR을 요청한다
- [ ] PR 작성자 봇, 담당자 봇, 리뷰어 나, 커밋 작성자 나
- [ ] 끝난 뒤 `gh auth status`에서 내 계정이 활성 상태다

---

## 원리: 각 설정이 하는 일

실전 섹션의 프롬프트가 대신 해 주는 일을 사람이 직접 한다면 이렇게 됩니다. 프롬프트가 기대대로 동작하지 않을 때 이 섹션을 보고 고칩니다.

### 1. 봇 계정을 `gh`에 추가 (처음 한 번)

```bash
gh auth login
```

1. GitHub.com → HTTPS → Authenticate Git: Yes → **Login with a web browser**
2. 브라우저가 내 계정으로 로그인돼 있으면 **시크릿 창**에서 열고, **봇 계정으로** 로그인해서 코드를 입력합니다.
3. 끝나면 활성 계정이 봇으로 바뀌어 있습니다. **반드시 내 계정으로 되돌립니다.** 활성 계정이 git 푸시에도 쓰이기 때문입니다.

```bash
gh auth switch --user <me>
```

`gh auth status`에서 두 계정이 모두 보이고, 내 계정이 `Active account: true`면 됩니다.

> **막혔던 곳**: Claude 데스크톱 앱만 쓰고 있으면 터미널에 `claude` 명령이 없습니다(`command not found: claude`). CLI는 `brew install --cask claude-code`로 따로 설치합니다.

### 2. 봇 계정을 협업자로 초대

저장소 Settings → Collaborators → Add people → `<bot>` (권한: **Write**). 봇 계정으로 로그인해서 초대를 수락합니다.

### 3. Claude GitHub 앱과 시크릿

[Claude GitHub 앱](https://github.com/apps/claude)을 저장소에 설치합니다. 앱은 내용·이슈·PR·워크플로 쓰기 등 넓은 권한을 한꺼번에 요구합니다. 일부만 골라 허용할 수는 없습니다.

인증은 구독 토큰을 씁니다. `claude setup-token`으로 만든 토큰을 저장소 시크릿 `CLAUDE_CODE_OAUTH_TOKEN`으로 등록합니다.

Claude Code 안에서 `/install-github-app`을 실행하면 앱 설치, 시크릿 등록, 워크플로 PR까지 한 번에 해 줍니다. 다만 터미널 대화형 명령이라 Claude가 대신 실행할 수 없고, 만들어 주는 워크플로도 아래처럼 고쳐야 합니다. 그래서 실전 섹션에서는 앱과 시크릿만 사람이 하고, 워크플로는 Claude가 직접 쓰게 했습니다. `/install-github-app`을 쓴다면 워크플로 선택에서 `claude.yml`만 고르고 `claude-code-review.yml`(PR마다 자동 리뷰)은 고르지 않습니다.

### 4. `claude.yml` 고치기

> **막혔던 곳**: GitHub Actions의 Claude는 `.github/workflows/` 파일을 고칠 권한이 없습니다. 이슈로 "워크플로 고쳐줘"라고 하면 수정안만 댓글로 남깁니다. 워크플로 수정은 로컬에서 해서 PR로 올립니다.

#### (1) PR을 직접 만들고, 리뷰어·담당자 지정

기본값의 Claude는 브랜치에 푸시하고 **"PR 만들기" 링크만** 남깁니다. PR을 직접 만들게 하려면 `gh pr create`를 허용하고 지시를 추가합니다.

{% raw %}

```yaml
- name: Run Claude Code
  id: claude
  uses: anthropics/claude-code-action@v1
  with:
    claude_code_oauth_token: ${{ secrets.CLAUDE_CODE_OAUTH_TOKEN }}
    additional_permissions: |
      actions: read
    claude_args: |
      --allowed-tools "Bash(gh pr create:*),Bash(gh pr view:*)"
      --append-system-prompt "When you push a new branch for an issue, open the pull request yourself with gh pr create against main instead of only posting a link. Use a Conventional Commits 1.0.0 title, describe the change and how it was tested in the body, and add 'Closes #N' with the issue number as N. Request a review from the maintainer with --reviewer <me> and assign the pull request to <bot> with --assignee <bot>. Commit messages must also follow Conventional Commits 1.0.0. Tests that need a human or local secrets cannot run here: when the change needs them, do not claim it is verified; list in the pull request the tests the maintainer must run locally and ask them to run them."
```

{% endraw %}

> **보안 메모**: `gh pr create`를 허용하면 이슈 본문과 댓글에 쓴 내용이 그대로 Claude의 작업 지시가 됩니다. `@claude`를 부를 수 있는 사람이 믿을 만한 저장소에서 쓰시고, 외부 기여자가 이슈를 자유롭게 여는 공개 저장소라면 허용 범위를 한 번 더 점검하시길 권합니다.

#### (2) 포크에서는 건너뛰기

포크에는 시크릿도 Claude 앱도 없어서, 포크 주인이 Actions를 켜고 `@claude`를 쓰면 실패합니다. job의 `if` 조건 앞에 저장소 가드를 붙입니다.

```yaml
if: |
  github.repository == '<owner>/<repo>' && (
    ...기존 조건...
  )
```

시크릿이나 GitHub Pages를 쓰는 다른 워크플로에도 같은 가드를 붙입니다. `pull_request_target`으로 바꾸는 방법은 쓰지 않습니다. 신뢰할 수 없는 포크 코드가 시크릿이 있는 환경에서 실행됩니다.

### 5. 저장소 설정

| 설정                                                   | 위치                               | 값                                                | 이유                                                       |
| ------------------------------------------------------ | ---------------------------------- | ------------------------------------------------- | ---------------------------------------------------------- |
| Fork pull request workflows from outside collaborators | Settings → Actions → General       | Require approval for first-time contributors 이상 | 처음 온 외부 기여자의 PR이 바로 Actions를 돌리지 못하게    |
| Always suggest updating pull request branches          | Settings → General → Pull Requests | 켜기                                              | 이게 꺼져 있으면 PR에 **Update branch** 버튼이 안 보입니다 |
| 브랜치 보호: 필수 체크                                 | Settings → Branches                | CI 체크만 필수 (선택)                             |                                                            |
| 브랜치 보호: 승인 필수                                 | Settings → Branches                | **켜지 않습니다**                                 | 내 이름으로 연 PR은 내가 승인할 수 없어서 머지가 막힙니다  |

> 자동 머지(auto-merge)는 결국 쓰지 않았습니다. 모바일 앱에서 리뷰하면서 바로 머지하는 편이 편했습니다. 쓰려면 "Allow auto-merge"를 켜고 필수 체크도 걸어야 합니다. 필수 체크가 없으면 GitHub가 "이미 머지 가능한 PR"로 보고 자동 머지를 거부합니다.

### 6. 로컬 Claude Code가 규칙을 잊었을 때

실전 섹션의 프롬프트는 협업 규칙을 그 저장소의 세션 간 기억에 저장하게 합니다. 기억이 빠졌거나 다른 AI에게 알려줄 때는 아래를 붙여 넣습니다. `<...>`만 채우면 됩니다.

```text
이 저장소에서 쓰는 GitHub 협업 방식이다. 이대로 따라라.

## 참여자
- 나(<내 이름>, GitHub: <me>): 저장소 소유자. PR을 리뷰하고 머지한다.
- 로컬 AI(너): 내 컴퓨터에서 나와 함께 작업한다. git과 gh는 내 로그인을 쓴다.
- GitHub Actions의 AI: 이슈·PR 댓글에서 @claude로 호출된다.
- 봇 계정(<bot>): 로컬 AI가 PR을 열 때만 쓴다. 저장소 협업자이고 gh에 로그인돼 있다.

## 로컬 AI 규칙
1. 커밋·푸시·PR은 내가 명시적으로 요청하거나 승인할 때만 한다. 작업이 끝나면 PR을 만들자고 먼저 제안해도 된다.
2. 기본 브랜치에 직접 커밋하지 않는다. 기본 브랜치에 있으면 커밋할 때 새 브랜치를 만들고, 작업 브랜치에 있으면 거기에 커밋한다. 브랜치 이름은 알아서 짓는다.
3. 커밋 메시지는 Conventional Commits 1.0.0을 따른다.
4. 커밋 작성자는 내 git 계정 그대로 두고, 끝에 AI 공동 작성자(Co-Authored-By) 줄을 붙인다.
5. 브랜치 푸시는 내 계정으로 한다.
6. PR은 봇으로 열고, 나를 리뷰어로, 봇을 담당자로 지정한 뒤, 반드시 내 계정으로 되돌린다.
     gh auth switch --user <bot>
     gh pr create --base main --reviewer <me> --assignee <bot> ...
     gh auth switch --user <me>
7. PR 본문에는 요약과 테스트 계획을 쓴다.
8. 자동 머지를 걸지 않고, 내가 요청하지 않으면 머지하지 않는다.
9. 머지된 뒤에는 기본 브랜치로 돌아가 pull 하고, 머지된 로컬 브랜치를 지운다.

## CI에서 돌릴 수 없는 테스트
- 사람이 조작해야 하거나 로컬 비밀값이 필요한 테스트는 Actions에서 돌리지 않는다.
- 그런 검증이 필요한 변경이면 "검증됨"이라고 쓰지 않고, 로컬에서 돌릴 테스트 목록을 PR에 적어 나에게 요청한다.
- 로컬에서 함께 돌릴 때는 내가 할 일을 짧은 번호 목록으로 미리 알려준다.

## 기타
- 저장소에 작업 규칙 문서(AGENTS.md 등)가 있으면 그 문서를 우선한다.
- 저장소 설정을 바꾸는 일은 내 승인을 받고 한다. 권한 검사에 막히면 우회하지 말고 나에게 방법을 알려준다.
```

---

## 문제 해결

| 증상                                                   | 원인                                                             | 해결                                                                                  |
| ------------------------------------------------------ | ---------------------------------------------------------------- | ------------------------------------------------------------------------------------- |
| `command not found: claude`                            | Claude Code CLI 미설치                                           | `brew install --cask claude-code`                                                     |
| `@claude`를 써도 반응이 없음                           | 워크플로 PR을 아직 머지 안 함, 또는 멘션이 본문·제목·댓글에 없음 | `claude.yml`이 기본 브랜치에 있는지 확인                                              |
| PR 대신 "PR 만들기" 링크만 남김                        | 기본값 동작                                                      | 원리 4 (1)의 `claude_args` 추가                                                       |
| 워크플로를 고쳐 달라고 했는데 수정안만 남김            | Actions의 Claude는 `.github/workflows/`를 못 고침                | 로컬에서 고쳐 PR로 올림                                                               |
| 로컬에서 만든 PR에 리뷰어가 안 붙음                    | PR 작성자가 나라서, 본인 리뷰 요청 불가                          | PR을 봇 계정으로 연다                                                                 |
| 담당자에 Claude를 지정할 수 없음                       | GitHub 앱은 담당자 불가                                          | 봇 계정을 담당자로                                                                    |
| 포크에서 `@claude`를 쓰면 실패                         | 포크에는 시크릿과 Claude 앱이 없음                               | 원리 4 (2)의 포크 가드                                                                |
| PR에 Update branch 버튼이 없음                         | 설정 꺼짐                                                        | 원리 5의 설정 켜기, 또는 `gh api -X PUT repos/<owner>/<repo>/pulls/<n>/update-branch` |
| 자동 머지 설정 시 "unstable status" 또는 "not allowed" | Allow auto-merge 꺼짐, 또는 필수 체크 없음                       | 설정을 켜고 필수 체크를 건다                                                          |
| 로컬 PR 이후 git 푸시가 봇 이름으로 감                 | `gh auth switch`로 되돌리지 않음                                 | `gh auth switch --user <me>`                                                          |

자동 리뷰 워크플로(`claude-code-review.yml`)를 쓴다면 두 가지를 더 겪습니다. Claude 앱이 만든 PR에서 "Workflow initiated by non-human actor: claude (type: Bot)"로 실패하면 action 설정에 `allowed_bots: "claude"`를 추가합니다. 포크에서 온 PR에서는 시크릿이 넘어가지 않아 실패하므로, job에 `if: github.repository == '<owner>/<repo>' && github.event.pull_request.head.repo.full_name == github.repository`를 붙입니다.

---

## 마치며

세팅은 저장소마다 한 번이고, 그 뒤로는 이슈를 올리고 모바일에서 리뷰하는 것만 남습니다. 가장 오래 걸린 건 Claude가 아니라 "PR 작성자는 리뷰어가 될 수 없다"는 GitHub의 규칙을 우회하는 방법을 찾는 일이었습니다. 봇 계정 하나로 해결되고 나니 로컬 작업과 이슈 작업이 같은 모양의 PR로 모입니다.
