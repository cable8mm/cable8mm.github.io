---
layout: single
title: "Replworks AI Pipeline: 왜 우리는 WORKING_SPEC이라는 중간 계층을 생각하게 되었나"
date: "2026-06-22 12:25:00"
categories: ai
tags: ai llm prompt-engineering software-architecture compiler-thinking replworks working-spec
author: Samgu Lee
header:
  og_image: /assets/images/llm-development-compiler.png
---

AI로 코드를 생성하는 방식은 점점 자연스러워지고 있습니다.  
하지만 실제로 개발을 해보면 한 가지 반복되는 문제가 있습니다.

> 같은 요구사항을 줘도 결과 코드의 방향이 계속 달라진다.

이 문제는 단순한 "프롬프트 문제"라기보다는, 조금 더 구조적인 문제일 가능성이 있습니다.

![LLM Development Compiler](/assets/images/llm-development-compiler.png)

## 1. 현재 LLM 기반 개발 흐름의 구조

대부분의 AI 기반 개발 흐름은 대략 다음과 같이 구성됩니다.

```text
IDEAS.md
→ PRODUCT_SPEC.md
→ ARCHITECTURE.md
→ FRAMEWORK.md
→ TASKS.md
→ AI Code Generation
```

이 구조는 충분히 잘 작동합니다. 하지만 실제로 TASK 단위로 AI를 실행해보면 문제가 발생합니다.

## 2. 문제: 매번 "전체 문서를 다시 해석"합니다

AI는 TASK 하나를 수행할 때마다 다음 과정을 반복합니다.

- PRODUCT_SPEC 전체를 다시 읽고
- ARCHITECTURE를 다시 해석하고
- FRAMEWORK 제약을 다시 적용하고
- TASK 정의를 다시 매핑합니다

이 과정은 명시적으로 보이지 않지만 항상 발생합니다.

그리고 여기서 다음과 같은 문제가 생깁니다:

- 문서 간 중요도 충돌
- 모델마다 다른 해석
- TASK마다 일관성 흔들림
- 불필요한 컨텍스트 노이즈

결과적으로 "같은 시스템인데 코드 스타일이 계속 달라지는 문제"가 발생합니다.

## 3. 아이디어: WORKING_SPEC이라는 "컴파일 결과물"

여기서 나온 아이디어가 하나 있습니다.

> 전체 설계를 매번 해석하지 말고,  
> TASK 단위로 "압축된 실행 명세"를 만들자

그 결과물이 WORKING_SPEC입니다.

## 4. WORKING_SPEC의 개념

WORKING_SPEC은 다음과 같은 역할을 합니다.

- PRODUCT_SPEC + ARCHITECTURE + FRAMEWORK + TASKS를 입력으로 받습니다
- 현재 TASK 기준으로 중요한 것만 남깁니다
- 나머지 정보는 제거하거나 비우선화합니다
- 실행에 필요한 정보만 남깁니다

즉:

```text
PRODUCT_SPEC
ARCHITECTURE
FRAMEWORK
TASKS
↓
WORKING_SPEC (compressed execution IR)
↓
AI Code Generation
```

---

## 5. WORKING_SPEC은 "현재 작업용 사양서"입니다

WORKING_SPEC은 전체 시스템의 정의가 아닙니다.

오히려 반대에 가깝습니다.

> "이번 TASK를 수행하기 위한 최소한의 실행 명세"

예를 들면 다음과 같습니다.

**Task: VoiceSession cancellation**

- Functional goal: interruption 시 TTS 즉시 중단
- Non-negotiable: state machine consistency 유지
- Constraint: Swift Concurrency only
- Constraint: Combine 사용 금지
- Requirement: cancellation latency < 100ms
- Requirement: OSLog event 반드시 기록

핵심은 이것입니다:

> "AI가 지금 무엇을 중요하게 봐야 하는지"를 명시적으로 정의하는 것입니다.

## 6. 왜 이 구조가 의미가 있을 수 있는가

이 구조의 핵심 가설은 단순합니다.

### 기존 방식

AI는 매번 전체 문서를 해석합니다.

- 해석 비용이 매번 발생합니다
- 중요도 판단이 매번 달라질 수 있습니다
- 결과 코드도 흔들릴 수 있습니다

### WORKING_SPEC 방식

해석을 구조적으로 줄이고, 실행에 집중합니다.

- TASK에 맞는 압축된 컨텍스트 제공
- 중요도 이미 정렬됨
- 모델은 "구현"에 집중

## 7. 사실 이것은 새로운 개념은 아닙니다

이 아이디어는 완전히 새로운 것은 아닙니다.

이미 유사한 개념들이 존재합니다:

- Compiler IR
- LLVM pass 구조
- Prompt chaining
- DSPy optimization
- Eval-driven prompt tuning

하지만 차이점이 하나 있습니다.

> LLM 개발 전체를 "컴파일 파이프라인"으로 보는 관점입니다

## 8. Backend LLM 분기 가능성

이 구조가 흥미로운 이유는 여기서 확장됩니다.

WORKING_SPEC는 모델별로 변형될 수 있습니다.

```text
WORKING_SPEC.gpt.md
WORKING_SPEC.claude.md
WORKING_SPEC.gemini.md
```

각 모델은 선호하는 입력 구조가 다르기 때문에:

- GPT: 간결한 constraint 중심
- Claude: 철학 + 구조 중심
- Gemini: 예시 중심

같은 WORKING_SPEC이라도 backend pass를 통해 변형할 수 있습니다.

## 9. 결과적으로 생기는 구조

이 관점에서 보면 전체 시스템은 다음과 같이 정리할 수 있습니다.

```text
IDEAS.md

→ Design Layer
PRODUCT_SPEC.md
ARCHITECTURE.md
FRAMEWORK.md

→ Planning Layer
TASKS.md

→ Compilation Layer
WORKING_SPEC.md

→ Execution Layer
LLM Backend
```

## 10. 결론

이 아이디어의 핵심은 단순합니다.

> LLM에게 "문서 전체를 이해하라"고 요구하는 것이 아니라  
> "지금 이 작업을 위한 최소 실행 사양만 보게 만드는 것"입니다

WORKING_SPEC는 모델을 더 똑똑하게 만드는 것이 아닙니다.

대신 다음을 목표로 합니다:

- 해석 비용을 줄이고
- 중요도를 미리 정렬하고
- 실행 단위를 명확하게 만드는 것

결과적으로 우리는 LLM을 단순한 코드 생성기가 아니라

> "컴파일 타겟으로 취급할 수 있는 실행 엔진"

으로 바라보게 됩니다.

p.s.

이 개념에 대한 후속 논의는  
<https://github.com/replworks/replworks.github.io/issues/63>  
에서 이어갈 예정입니다.
