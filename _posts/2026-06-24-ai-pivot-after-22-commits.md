---
layout: single
title: "AI에게 나도 모르는 것을 시켰을 때 망한 이야기 (ft. 7시간 만에 22커밋 찍고 피벗한 사연)"
date: 2026-06-24 00:40:00 +0900
categories: ai development
tags: ai llm chrome-extension mcp codex development
author: Samgu Lee
header:
  og_image: /assets/images/ai-pivot-after-22-commits.png
---

## 1. 프롤로그: 인간의 욕심은 끝이 없고

ChatGPT와 Gemini는 성향이 너무 달라서 둘을 같이 쓰게 됩니다. ChatGPT는 냉정한 I성향이라면 Gemini는 활발한 E 성향이죠.

ChatGPT는 비교적 정확한 정보가 필요할때, Gemini는 아이디어를 넓게 탐색하거나 조금 더 편안한 대화를 하고 싶을 때 사용합니다.

그래서, 전 종종 이런 식으로 작업을 합니다.

- ChatGPT에게 물어보고
- Gemini에게 그 내용을 전달하고
- ChatGPT에게 물어보고
- Gemini에게 그 내용을 전달하고
- ...

처음엔 몇번 이런 식으로 진행이 되었을 때 재밌다라는 생각을 했는데요, 생각보다 자주 이렇게 일을 하는 저 자신을 바라보면서 이게 무슨 삽질인가... 라는 생각이 들더군요.

> "아, ChatGPT 답변 복사해서 Gemini에 붙여넣고,
> 또 그 답변 복사해서 ChatGPT에 넣는 거...
> 이거 누가 자동화 안 해주나?"

소프트웨어 엔지니어로서 참을 수 없는 비효율이었습니다.

LLM이 나온 지금 누군가는 만들었겠지 라는 기대로 오픈소스와 상용서비스 모두 뒤져봤습니다. 왜인지는 모르겠지만, 모든 솔루션들이 `api`를 사용하고 있었습니다. `api`... 전 `api`보다 채팅창에서 대화하는 것을 좋아합니다.

그래서 두 거대 언어 모델(LLM)이 서로 릴레이식으로 대화하며 문서를 고도화하는 **두 개의 모델이 서로 질문하고 답변하고 내가 중재를 할 수 있는 도구**를 만들기로 결심했습니다.

조건은 단 하나였습니다.

> "사용성이 우아할 것."

사용자가 평소 사용하던 크롬 브라우저와 로그인 세션을 그대로 활용하면서 동작하는 앱을 상상했습니다.

## 2. 폭풍 같았던 7시간, 그리고 22개의 커밋

전 AI 와의 개발에 있어서 [REPL Works 프레임워크](https://www.repl.net)를 사용합니다. AI의 메모리를 문서화 시키면서 step by step 으로 개발하는 방식입니다.

개발에 들어가기 전에 `PRODUCT_SPEC.md`, `ARCHITECTURE.md`, `FRAMEWORK.md` 그리고 `TASKS.md` [네 개의 문서](https://www.repl.net/documents/)를 몇시간에 걸쳐서 만들고, 개발을 시작하자마자 AI 코딩 어시스턴트(Codex)와 호흡을 맞추며 엄청난 속도로 코드를 작성했습니다.

### #1 ~ #3

프로젝트 기초를 다지고 CLI 인터페이스와 미션 상태 관리 시스템을 만들었습니다.

### #4 ~ #7

브라우저 자동화 레이어, 메시지 추출 엔진, 라우팅 시스템을 구현했습니다.

이때까지만 해도 `9222` 포트로 기존 크롬에 연결하면 모든 것이 해결될 것이라고 생각했습니다.

### #8 ~ #14

중간에 사용자가 개입할 수 있는 시스템, 멀티 탭 바인딩, 지속 가능한 미션 러너까지 추가했습니다.

린트와 포맷 설정까지 마치고 나니 정말 완성된 제품이 탄생하는 것처럼 느껴졌습니다.

터미널에서 테스트 코드가 돌아가는 모습을 보며 생각했습니다.

> "역시 AI랑 코딩하니까 생산성이 미쳤네."

딱 5시간째가 되기 전까지는 말입니다.

## 3. "그거 안 되는데요?" 크롬 보안 모델에 머리가 아파지다

문제는 15번째 커밋 근처에서 터졌습니다.

코드는 완벽해 보였는데 크롬이 계속 연결을 거부했습니다.

```bash
❯ curl http://127.0.0.1:9222/json/version
curl: (7) Failed to connect to 127.0.0.1 port 9222 after 0 ms: Couldn't connect to server
```

원인을 파악해 보니 2025년 3월 [크롬은 보안 강화를 위해 기본 사용자 프로필에 대한 원격 디버깅 사용을 제한](https://developer.chrome.com/blog/remote-debugging-port?hl=ko)하고 있었습니다.

이미 로그인 정보와 개인정보가 들어 있는 프로필을 외부 프로그램이 마음대로 제어하는 것을 어렵게 만든 것입니다.

우회하려면 별도의 빈 프로필을 만들어야 했습니다.

```bash
google-chrome \
--remote-debugging-port=9222 \
--user-data-dir=~/chrome-debug-profile
```

이렇게 하면 동작은 합니다.

하지만 치명적인 문제가 생깁니다.

- 매번 터미널을 열어야 합니다.
- 새로운 프로필에서 크롬이 실행됩니다.
- ChatGPT와 Gemini에 다시 로그인해야 합니다.

문득 이런 생각이 들었습니다.

> 자동화를 편하게 하려고 만드는 앱인데,
> 왜 사용자는 매번 터미널을 열고 구글 로그인을 다시 해야 하지?

개발자인 저부터도 사용할 의향이 없었습니다.

결국 저는 제가 잘 알지 못하는 영역, 즉 크롬 보안 모델을 충분히 이해하지 못한 상태에서 AI가 할 수 있다는 말만 믿고,

> "네가 제안한대로 알아서 구현해 줘."

라고 맡긴 셈이었습니다. AI는 저보다 똑똑할 테니까요.

![Codex의 속삭임](/assets/images/ai-pivot-after-22-commits.png)

그리고 기술적인 막다른 길(Dead End)에 도달했습니다.

## 4. 살릴 것인가, 죽일 것인가

하루 동안 만든 30-40여 개의 커밋과 20여 개의 PR이 주마등처럼 스쳐 지나갔습니다. [ai-issue]({% post_url 2026-06-14-introduce-ai-issue-to-you %})를 만들 떈 이런 일이 발생하지 않았습니다.

> "이 프로젝트는 여기서 폐기해야 하나?"

잠시 고민했습니다. Codex는 작동은 하니 일단 써(!)라고 제안을 하더군요.

```text
My recommendation:

- If you want something that works reliably today, use a dedicated Chrome profile for the relay tool.
- If you want, I can help you set that up in the least painful way, including a launch command and a cleaner README note so it feels straightforward.
```

악마의 속삭임. 하지만, 하지만 그 순간 깨달았습니다. 저부터도 절대 안 쓸 것 같았습니다. 사실 이 앱은 설치용 앱으로 패키징을 할 예정이었습니다. Codex에게 솔직하게 말했습니다.

> After reviewing the UX, I have decided to completely discard the --remote-debugging-port=9222 approach. Forcing the user to manually launch Chrome via the terminal with specific flags and re-authenticate their ChatGPT/Gemini accounts is an unacceptable user experience.
>
> What do you think about pivoting to a **Chrome Extension + Node.js (MCP) Server Hybrid Architecture**?

AI도 의외로 담담하게 인정했습니다.

> Yes, I think that pivot is materially better for the UX you want.

그렇게 도출한 대안이

> **Chrome Extension + Node.js MCP Server**

구조였습니다.

외부 프로그램이 크롬에 침입하려고 하니까 막히는 것이라면,

브라우저 내부에서 동작하는 익스텐션이 DOM을 읽고 제어하고,

그 익스텐션과 Node.js 프로세스를 웹소켓으로 연결하는 방식입니다.

이 구조라면 사용자가 별도의 브라우저 프로필을 관리하지 않아도 되고,

평소 사용하던 로그인 세션을 대부분 그대로 활용할 수 있습니다.

## 5. 에필로그: 코드를 지우기 전에 문서를 고쳤다

방향이 정해지자마자 AI는 MVP코드를 만들어 준다고 하더군요. 그 방식은 REPL Works의 방식이 아닙니다.

`PRODUCT_SPEC.md`와 `ARCHITECTURE.md`와 `FRAMEWORK.md`와 `TASKS.md`를 먼저 새 구조에 맞게 전부 개정했습니다.

9222 포트와 Playwright 중심 구조를 제거하고, 새로운 Extension 기반 구조를 문서에 반영했습니다.

그리고 마지막 커밋을 남겼습니다.

```text
docs: pivot the entire codes to incredible app (#22)
```

오늘 하루 동안 저는

- 삽질했고
- 실패했고
- 아키텍처를 갈아엎었고
- 문서를 다시 썼습니다.

그리고 그 모든 일을 하루 안에 끝냈습니다.

AI는 매우 유능한 프로그래머이자 아키텍쳐이자 디자이너이자 기획자입니다.

하지만 제가 크롬의 보안 모델을 이해하지 못한 상태에서

> "(넌 나보다 머리가 좋으니)알아서 구현해 줘."

라고 맡긴 순간, 저는 결과물을 검증할 능력을 잃어버렸습니다.

결국 문제는 AI가 아니라 저였습니다.

AI는 막다른 길까지는 엄청 빠르게 데려다 줍니다.

하지만

> "(너가 아무리 머리가 좋아도)이 길은 안 된다."

라고 판단하고 방향을 바꾸는 일은 아직 사람의 몫인 것 같습니다.

AI 시대의 개발자는 더 이상 모든 것을 직접 구현할 필요는 없을지도 모릅니다.

하지만 최소한,

**"이 길은 막다른 길이다."**

라고 판단할 수 있을 정도의 이해는 여전히 필요하다는 것을 배웠습니다.
