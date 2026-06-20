---
layout: single
title: "AI 개발 입문자라면 Agent Framework를 공부하지 마세요"
date: "2026-06-20 14:55:00"
categories: ai development
tags: ai CrewAI LangGraph AuthGen ReplWorks
author: Samgu Lee
header:
  og_image: /assets/images/agent-frameworks-are-not-good-at-development.png
---

## 저는 2주를 쓰고 PRODUCT_SPEC.md로 돌아왔습니다

AI와 개발을 시작한 지 세 달 반 정도 되었습니다. 그리고, [몇개의 오픈소스를 공개](https://github.com/replworks/ai-issue)하고, 활용하고 있습니다.

![Agent frameworks are not good at development](/assets/images/agent-frameworks-are-not-good-at-development.png)

처음에는 저도 멀티 에이전트 프레임워크가 미래라고 생각했습니다. 직접 [CrewAI](https://crewai.com/)를 사용해 보았고, [LangGraph](https://www.langchain.com/langgraph)와 [AutoGen](https://www.microsoft.com/en-us/research/project/autogen/)도 공부했습니다.

"PM Agent", "Architect Agent", "Developer Agent", "QA Agent"가 서로 협업하면서 서비스를 만들어 주는 모습을 상상하면 꽤 그럴듯해 보입니다.

하지만 결론부터 이야기하면, 저는 개발 프로젝트에서는 아직 사용할 이유를 찾지 못했습니다.

물론 제가 틀릴 수도 있습니다.

하지만 적어도 **인하우스 서비스 개발과 운영 관점에서는 그렇습니다.**

## 운영되는 서비스는 끝나지 않습니다

제가 20년 넘게 IT 업계에 있으면서 얻은 결론은 단순합니다.

> [운영되지 않는 코드는 자산이 아닙니다.]({% post_url 2026-06-20-codes-are-not-assets %})

서비스는 출시하면 끝나는 것이 아닙니다.

사용자 피드백이 들어오고,

기능이 추가되고,

아키텍처가 수정되고,

때로는 기존 기능을 삭제해야 합니다.

이 과정은 몇 달이 아니라 몇 년 동안 반복됩니다.

그래서 중요한 것은 누가 무엇을 하는지가 아니라, **무엇이 바뀌었는가** 입니다.

## 실제 애자일 팀은 역할이 계속 바뀝니다

인하우스 서비스를 운영하는 팀에서는 역할이 고정되어 있지 않습니다.

- PM이 직접 코드를 읽습니다.
- 개발자가 기획을 수정합니다.
- QA가 아키텍처 변경을 제안합니다.
- CTO가 지표를 보고 기능 삭제를 결정합니다.

하지만 대부분의 Agent Framework는 다음과 같은 구조를 전제로 합니다.

```text
PM Agent
-> Architect Agent 
-> Developer Agent
-> QA Agent
```

인간 조직을 모델링하는 방식입니다.

하지만 운영 중인 서비스는 조직도를 따라 진화하지 않습니다.

운영 중인 서비스는 문제를 발견하고,

명세를 수정하고,

아키텍처를 변경하고,

다시 배포하는 피드백 루프로 진화합니다.

## 저는 결국 문서 몇 개만 남겼습니다

2주 정도 Agent Framework를 공부한 뒤, 저는 오히려 [더 단순한 구조](https://www.repl.net/workflow/)로 돌아왔습니다.

```text
PRODUCT_SPEC.md
↓
ARCHITECTURE.md
↓
FRAMEWORK.md
↓
TASKS.md
↓
AGENTS.md
↓
AI
↓
Code
```

아키텍처가 바뀌면 `ARCHITECTURE.md`를 수정합니다.

기능이 추가되면 `TASKS.md`를 수정합니다.

AI가 지켜야 할 규칙은 `AGENTS.md`에 정의합니다.

문서의 변경 이력은 Git이 관리합니다.

서비스를 운영하다가 문제가 발생하면 문서를 수정하는 것이 아니라 GitHub Issue를 생성합니다.

그리고 사람이 판단해서 다음 작업을 `TASKS.md`에 반영합니다.

현재까지는 이 방식이 제가 찾은 [가장 단순하고 관리 가능한 AI 개발 방식](https://www.repl.net/)입니다.

## Agent Framework가 실패한다고 생각하지는 않습니다

저는 CrewAI, LangGraph, AutoGen이 실패할 것이라고 주장하지 않습니다.

다만 아직까지는 개발 프로젝트를 운영하면서 계속 진화시키는 문제를 해결하기에는 너무 조직 중심적이라고 느꼈습니다.

그리고 AI와 개발을 막 시작한 사람이라면, CrewAI를 공부하는데 2주를 쓰기 전에, 먼저 `PRODUCT_SPEC.md` 하나를 만들고 서비스를 세상에 배포해 보는 것을 추천합니다.

서비스는 운영되기 시작하는 순간부터 배움을 줍니다.

운영되는 제품은 자산이 될 수 있습니다.

하지만 아직 운영되지 않는 Agent Graph는 적어도 제게는 자산처럼 느껴지지 않았습니다.

2주를 쓰고 얻은 개인적인 결론입니다.

혹시 저처럼 AI 개발을 시작하며 Agent Framework를 공부하고 계신다면, 잠시 멈추고 스스로에게 질문해 보시기 바랍니다.

> 내가 만들고 싶은 것은 AI 조직인가?
>
> 아니면 운영되는 제품인가?

p.s. 혹시 Agent Framework 를 사용해서 개발 프로젝트 온보딩과 운영을 성공적으로 하신 분이 있다면 공유해 주세요.
