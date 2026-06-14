---
layout: single
title: "AI와 함께한 2주의 기록: 생산성의 함정을 넘어 '프로젝트 기억'을 설계하기까지"
date: 2026-06-13 17:54:00
categories: development
tags: ai development replworks github pages
author: Samgu Lee
header:
  og_image: /assets/images/replworks-homepage.png
---

지난 몇달간, 저는 AI와 함께 여러 프로젝트를 밀도 있게 진행했습니다.

- **AI Issue Publisher** [Github](https://github.com/replworks/ai-issue)
- **REPL Works** [Github](https://github.com/replworks/replworks.github.io)
- **Wifi-Note**
- **TalkTune**
- 그 외 다수의 실험적 프로젝트

처음 AI를 도입했을 때의 충격은 여전히 생생합니다. 웹사이트의 뼈대를 몇 시간 만에 구축하고, 기존 개발 방식과는 비교할 수 없을 정도로 빠른 속도로 기능을 구현해냈으니까요.

14개의 아이디어를 프로젝트에 필요한 문서를 AI와 일주일에 걸쳐서 작성했습니다. AI 추천대로 말이죠.

다음은 14개 아이디어 중 하나인 TalkTune 앱의 문서들입니다.

```text
docs
├── ai
│   ├── AGENTS.md
│   ├── MEMORY_SYSTEM.md
│   ├── PROMPT_SYSTEM.md
│   ├── SAFETY.md
│   └── TASKS.md
├── architecture
│   ├── ARCHITECTURE.md
│   ├── AUDIO_PIPELINE.md
│   ├── CONTENT_UPDATE_SYSTEM.md
│   ├── INITIAL_STRUCTURE_DESIGN.md
│   ├── IOS_ARCHITECTURE.md
│   ├── slice0
│   │   ├── APP_STRUCTURE.md
│   │   ├── AUDIO_PIPELINE.md
│   │   ├── CONVERSATION_RUNTIME.md
│   │   ├── RUNTIME_STATE_MACHINE.md
│   │   └── VAD_SYSTEM.md
│   └── SYSTEM_ARCHITECTURE.md
├── company
│   ├── BRAND.md
│   ├── PHILOSOPHY.md
│   ├── POSITIONING.md
│   └── VISION.md
├── content
│   ├── ENGLISH_ACQUISITION.md
│   ├── SCENARIO_ENGINE.md
│   └── TOPIC_LIBRARY.md
├── growth
│   ├── MONETIZATION.md
│   ├── NOTIFICATION_STRATEGY.md
│   └── RETENTION_METRICS.md
├── legal
│   ├── AI_TRANSPARENCY.md
│   ├── CHILD_SAFETY.md
│   └── PRIVACY.md
├── product
│   ├── IDEAS.md
│   ├── PRINCIPLES.md
│   ├── PRODUCT_SPEC.md
│   ├── RETENTION_SYSTEM.md
│   ├── USER_JOURNEY.md
│   └── USER_PERSONAS.md
├── prompts
│   ├── ANDROID_PROMPTS.md
│   ├── CODING_GUIDELINES.md
│   ├── IOS_PROMPTS.md
│   └── UI_GUIDELINES.md
├── README.md
├── roadmap
│   ├── MVP.md
│   ├── NOT_TO_DO.md
│   └── POST_MVP.md
└── ux
    ├── CHARACTER_SYSTEM.md
    ├── UX_PRINCIPLES.md
    └── VISUAL_DIRECTION.md
```

하지만 '생산성'이라는 허니문 기간이 지나자, 전혀 예상치 못한 곳에서 병목 현상이 발생하기 시작했습니다.

## AI는 '맥락(Context)'을 기억하지 못합니다

프로젝트의 규모가 일정 수준을 넘어서자 이상한 일들이 벌어졌습니다. 어제 합의한 아키텍처를 오늘 스스로 뒤엎고, 이미 구현 완료된 기능을 다시 만들겠다고 제안하며, 불과 몇 시간 전의 대화 내용조차 파편화되어 사라지고 있었습니다. 그리고, AI의 환각(Hallucination)이 얼마나 무서운 것인지고 깨닫게 되었죠.

처음에는 LLM 모델 자체의 한계라고 생각했습니다. 이래서 더 비싼 LLM을 쓰는건가? 하지만 여러 모델을 교체해 봐도 결과는 비슷했습니다. 결론은 명확했습니다.

> **문제는 모델이 아니라, '프로젝트 기억(Project Memory)'을 관리하는 시스템이 없다.**

우리가 새로운 팀원을 맞이할 때를 떠올려 보십시오. 그에게 왜 이 프로젝트를 시작했는지(Why), 그동안 어떤 의사결정을 거쳤는지(Context), 그리고 현재 우리 제품은 어떤 상태인지(Current Status)를 온보딩하는 과정이 필수적입니다. 그런데 AI와 개발할 때는 이 과정을 매번 반복하고 있었던 것입니다.

## 문서의 시스템화

저는 이 문제를 해결하기 위해 '문서화'를 시스템화하기 시작했습니다. 단순한 메모를 넘어, 프로젝트의 성격에 따라 역할을 명확히 나눈 문서 세트를 구축했습니다. 사람을 위한 문서와 AI을 위한 문서를 철저히 구분하기 시작했습니다.

- `docs/IDEAS.md`: 비전과 아이디어의 기원(사람용)
- `docs/PITCHING_SCRIPT.md`: 제품의 가치 제안과 핵심 메시지(사람용)
- `PRODUCT_SPEC.md`: 상세 요구사항 정의서(AI용)
- `ARCHITECTURE.md`: 기술적 의사결정의 근거(AI용)
- `FRAMEWORK.md`: 프레임워크 혹은 개발 표준 가이드(AI용)
- `TASKS.md`: 현재 작업 우선순위(AI용)
- `AGENTS.md`: AI 에이전트의 역할과 행동 규칙(AI용)

몇개의 비교적 작은 프로젝트를 진행하면서 필요한 문서를 수정하고, 툴을 만들고 프롬프트를 다듬었습니다.

### 생산성을 넘어 비용 효율성으로

여기서 흥미로운 발견이 있었습니다.

AI에게 코딩을 맡길 때 Codex를 이용했는데 엄청난 토큰 사용량 때문에 놀란 기억이 있습니다. 캐시를 한다고는 하지만, 하루 이틀만에 한달 사용 토큰량을 채워버렸거든요. 그런데, **문서화는 생산성뿐만 아니라 '비용' 문제도 해결해주었습니다.

** AI 에이전트에게 매번 전체 대화 맥락을 읽히는 것은 엄청난 토큰 비용을 발생시킵니다. 하지만 잘 정리된 문서 시스템은 AI가 전체를 읽지 않고도 '필요한 지식'에만 접근하게 하여, 토큰 효율성을 극적으로 높여주었습니다.

결국 제가 만든 것은 단순한 문서 파일들이 아니었습니다. **AI가 프로젝트의 맥락을 잃지 않도록 유지하는 '개발 프로세스' 그 자체였습니다.**

### REPL Works의 탄생

이 과정을 통해 탄생한 것이 바로 [**REPL Works**](https://www.repl.net)입니다.

수개월 동안 다듬은 문서들과 워크플로를 효율화 시키고, 문서들을 생성하는 프롬프트와 프로젝트 별로 규격화 할 수 있는 문서를 저장했습니다.

그리고, 워크플로와 Github을 결합한 형태의 진화된 워크플로를 실제로 적용하여 나온 두가지 제품은 이렇습니다.

- [AI 이슈 퍼블리셔](https://github.com/replworks/ai-issue)
- [REPL Works 공식 홈페이지](https://www.repl.net)

시행착오 없이 두 프로젝트 모두 48시간 안에 제작과 배포, 전체 리뉴얼과 배포를 완료했으며, 지금도 Github의 Issues, PR, Merge, Publish 를 Github Actions 들을 최대한 활용해서 운영하고 있습니다.

다음 기회에 REPL Works 호환 프로젝트들을 제작하고 운영할 때 어떤 문제가 생기고 어떤 방법으로 해결했는지를 차례차례 공유하겠습니다.
