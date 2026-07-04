---
layout: single
title: "AI에게 직책(Role)을 주지 말고, 능력(Capability)을 요구하라"
date: 2026-06-16 21:00:00 +0900
categories: development opinion replworks
tags: AI LLM PromptEngineering AIWorkflow AIAgents SoftwareEngineering ProductDevelopment TechBlog Startup
author: Samgu Lee
header:
  og_image: /assets/images/repl-net-homepage.png
---

최근 몇 주 동안 [**ReplWorks**](https://www.repl.net)라는 사이드 프로젝트를 빌딩하고 있습니다.

![ReplWorks Homepage](/assets/images/repl-net-homepage.png)

처음 목표는 단순했습니다. AI가 중간에 길을 잃지 않고 프로젝트를 끝까지 완성할 수 있도록 **컨텍스트(Context)를 유지하고, 워크플로우를 표준화하는 시스템**을 만드는 것이었죠. 이를 위해 프로젝트의 뼈대가 될 여러 마크다운 문서들을 정의하기 시작했습니다.

- `PRODUCT_SPEC.md`
- `FRAMEWORK.md`
- `TASKS.md`
- `AGENTS.md`
- `AI_MEMORY.md`

당시의 저는 Cursor, Claude Code, OpenAI Codex 기반의 여러 오픈소스들이 그러하듯, 자연스럽게 **'Agent 중심'**의 아키텍처를 그리고 있었습니다.

```text
agents/
├── designer.md
├── frontend-engineer.md
├── backend-engineer.md
└── ios-engineer.md
```

이 구조가 너무나 당연하다고 생각했습니다. 하지만 실제로 시스템을 구동하고 테스트를 반복하면서, 무언가 어긋나고 있다는 위화감이 들기 시작했습니다.

생각해보면 사람은 '역할(Role)'이 필요합니다. 한정된 시간과 에너지를 가진 인간은 전문성을 극대화하기 위해 조직을 나눕니다.

- **PM**은 요구사항을 정리하고,
- **디자이너**는 UI/UX를 설계하며,
- **개발자**는 서버와 클라이언트를 구현합니다.

인간 사회에서는 매우 효율적인 이 조직도가, 과연 AI에게도 정답일까요?

AI는 다릅니다. 동일한 LLM 모델 내부에 이미 디자인 지식, 개발 지식, 제품 기획 및 비즈니스 로직이 전부 원자 단위로 녹아있습니다. 그런데 우리는 왜 인간의 조직도를 그대로 AI에게 투사하고 있었을까요?

우리가 흔히 쓰는 프롬프트의 시작점들을 다시 짚어봅시다.

> "You are a senior designer." (너는 시니어 디자이너야.)
>
> "You are a senior software engineer." (너는 시니어 소프트웨어 엔지니어야.)

이 문장을 실행한다고 해서 AI가 갑자기 디자이너로 '변신'하는 것은 아닙니다. 그저 자신이 가진 거대한 파라미터 공간(Parameter Space) 중에서 **디자인이라는 관점(Perspective)의 가중치를 조금 더 높여서 사용할 뿐**입니다. 엔지니어 프롬프트 역시 새로운 능력을 주입하는 게 아니라, 구현 가능성과 구조적 유지보수성을 더 진지하게 고려하라고 압박하는 것에 가깝습니다.

즉, AI에게 필요한 것은 **역할(Role)**이 아니라 **관점(Perspective)**이었습니다.

## 진짜 필요한 것은 직책이 아니었다

ReplWorks의 코어 기능을 설계하며 깨달음은 더 명확해졌습니다. 예를 들어 PRODUCT_SPEC.md를 리뷰하는 가상의 태스크를 짜본다고 가정해 봅시다.

처음에는 이렇게 명령했습니다.

> "Act as a senior software engineer. Review PRODUCT_SPEC.md"

하지만 결과물을 뜯어보니 제가 정말 원했던 건 **'시니어 엔지니어라는 페르소나'**가 아니었습니다. 내가 원한 건 구체적인 **동작(Action)**이었습니다.

```markdown
Plaintext
Identify:

- missing requirements (누락된 요구사항)
- ambiguous requirements (모호한 요구사항)
- conflicting requirements (충돌하는 요구사항)
- undefined states (정의되지 않은 예외 케이스)
```

직책이라는 추상적인 껍데기보다, 어떤 능력을 꺼내어 무엇을 날카롭게 검토할 것인가가 본질이었습니다.

## 인간 조직은 Role-Based, AI 워크플로우는 Capability-Based

전통적인 기업은 역할 기반(Role-Based)으로 움직입니다. PM, Designer, Frontend, Backend, QA가 각자의 사일로(Silo) 안에서 협업하죠. 사람이 동시에 모든 역할을 완벽하게 수행하는 건 불가능하기 때문입니다.

반면 AI는 필요하다면 **UX 관점, 제품 관점, 개발 관점, 비즈니스 관점을 '동시에' 교차로 사용**할 수 있습니다. 오히려 AI를 특정 Agent(디자이너, 개발자)라는 틀에 가둬두는 것은, 대규모 언어 모델이 가진 가장 큰 무기인 '통합적 사고 능력'을 제한하는 꼴이 됩니다.

여기서 ReplWorks의 피벗(Pivot)이 시작되었습니다. `designer.md`, `engineer.md` 같은 페르소나 파일들을 과감히 버렸습니다. 대신 **능력(Capability)** 중심으로 인프라를 재정의했습니다.

```markdown
Capabilities:

- requirement analysis (요구사항 분석)
- implementation planning (구현 계획 수립)
- ambiguity detection (모호성 탐지)
- ux evaluation (UX 평가)
- business rule validation (비즈니스 규칙 검증)
```

이제 하나의 태스크는 독립된 Agent가 처리하는 게 아니라, 필요한 역량들의 조합(Composition)으로 수행됩니다.

```markdown
generate-spec (기획서 생성)
= product thinking + ux thinking + implementation awareness

review-spec (기획서 리뷰)
= requirement analysis + ambiguity detection + implementation review
```

## AI 개발의 핵심은 Agent가 아니라 Workflow다

처음에는 문서를 표준화하려고 시작한 프로젝트였습니다. 그러다 프롬프트를 모듈화하기 시작했고, 결국 마지막에 깨달았습니다.

**내가 만들고 있는 것은 Agent 시스템이 아니라 Workflow 시스템이었구나.**

LLM을 프로덕션 레벨에서 다룰 때 중요한 질문은 *"어떤 힙한 Agent를 쓸 것인가"*가 아닙니다.

1. **어떤 컨텍스트(Context)를 정밀하게 주입하는가**
2. **어떤 능력(Capability)을 명확하게 요구하는가**
3. **어떤 순서(Sequence)로 작업을 파이프라이닝하는가**

결국 이 세 가지가 퀄리티를 결정합니다.

## 요약하며

인간의 조직은 **Role-Based**일 때 가장 효율적이지만, AI의 워크플로우는 **Capability-Based**일 때 가장 자연스럽고 강력합니다. AI는 계약서에 적힌 직무 기술서(Job Description)에 묶여있는 존재가 아니니까요.

앞으로 제가 작성할 프롬프트는 이렇게 바뀔 것 같습니다.

- ❌ "너는 시니어 디자이너야."
- ⭕ **"Focus on: information hierarchy, usability, accessibility, conversion"**
- ❌ "너는 시니어 엔지니어야."
- ⭕ **"Review for: implementation ambiguity, missing requirements, conflicting requirements"**

페르소나라는 모호한 가면을 씌우는 대신, 기대하는 능력을 명확하고 날카롭게 요구하는 것. ReplWorks를 빌딩하며 얻은 가장 값진 레슨입니다.
