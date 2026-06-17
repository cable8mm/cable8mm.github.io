---
layout: single
title: "config에 AI 모델명이 사라졌다? Laravel AI SDK 완벽 활용기 (Gemma 연동부터 모델 분리 팁까지)"
date: "2026-06-17 23:59:00"
categories: development opinion replworks
tags: laravel php ai gemini gemma
author: Samgu Lee
header:
  og_image: /assets/images/laravel-config-ai.png
---

최근 Laravel 13이 릴리스되면서 생태계에 정말 흥미로운 변화가 많아졌습니다. 그중에서도 단연 눈에 띄는 녀석은 백엔드에서 AI 에이전트를 가장 완벽하게 다룰 수 있도록 돕는 **공식 Laravel AI SDK**의 등장일 것입니다.

그런데 패키지를 설치하고 설레는 마음으로 `config/ai.php` 설정을 열어본 분들은 아마 저와 같은 의문을 가지셨을 겁니다.

![Laravel AI SDK 설정](/assets/images/laravel-config-ai.png)

> *"어라? 기본 프로바이더(openai, gemini...)는 지정되어 있는데, 정작 중요한 '모델 이름(gpt-4o나 gemini-2.5-flash 같은)'은 어디서 설정하지?"*

오늘은 이 미스터리(?)한 설정 원리와 함께, 실무에서 필수적인 **멀티 모델 분리 전략(텍스트용/이미지용)**, 그리고 요즘 핫한 오픈소스 모델인 **Gemma(젠마) 활용법**까지 깔끔하게 정리해 드리겠습니다.

## 1. config에 모델명이 없는 이유: Laravel의 '스마트 매칭' 시스템

결론부터 말씀드리면, 모델명이 보이지 않는 건 버그가 아니라 **Laravel다운 스마트함** 때문입니다.

laravel/ai 가이드 중 [Agent Configuration](https://laravel.com/docs/13.x/ai-sdk#agent-configuration):

```markdown
The `UseCheapestModel` and `UseSmartestModel` attributes allow you to automatically select the most cost-effective or most capable model for a given provider without specifying a model name.
```

[Laravel AI SDK](https://laravel.com/docs/13.x/ai-sdk) 내부에는 각 AI 공급자(Provider)별로 가장 똑똑한 모델 (`Smartest`)과 가장 가성비가 좋은 모델 (`Cheapest`)이 이미 매핑되어 있습니다. 개발자가 모델명을 일일이 지정하지 않으면, Laravel이 내부 룰셋에 따라 **가장 균형 잡힌 메인 최신 모델을 자동으로 선택**해 줍니다.

실제로 코드를 작성할 때 아래와 같은 PHP 어트리뷰트(Attribute)를 사용해 보면 체감이 됩니다.

```php
use Laravel\Ai\Attributes\UseCheapestModel;
use Laravel\Ai\Attributes\UseSmartestModel;

#[UseCheapestModel]
class SimpleSummarizer implements Agent {
    // Laravel이 알아서 가장 저렴한 하이쿠(Haiku)나 플래시(Flash) 모델로 연결합니다.
}
```

**⚠️ 스타트업을 위한 Real 가이드:**
이 방식은 프로토타이핑할 때 정말 편하지만, 패키지가 업데이트되면서 내부 기본 모델이 바뀌면 프롬프트 결과가 미묘하게 달라지거나 비용 폭탄을 맞을 수 있습니다. 따라서 서비스의 안정성이 중요한 **프로덕션 환경에서는 아래처럼 `providers` 배열 안에 모델명을 명시해 주는 것을 권장**합니다.

```php
// config/ai.php
'providers' => [
    'openai' => [
        'driver' => 'openai',
        'key' => env('OPENAI_API_KEY'),
        'model' => 'gpt-4o', // 👈 전역 기본 모델 고정!
    ],
],
```

## 2. 실무 팁: Gemini 하나로 텍스트와 이미지 모델 따로 쓰기

AI 서비스를 만들다 보면 하나의 공급자(예: Gemini)를 쓰더라도 **텍스트 분석에는 고성능 모델(Gemini Pro)**을, **이미지 생성에는 전용 모델(Imagen)**을 따로 분리해야 하는 상황이 백 프로 발생합니다.

이때 설정을 억지로 쪼갤 필요 없이, Laravel AI SDK의 아키텍처를 활용하면 아주 우아하게 분리할 수 있습니다.

### 방법 A. 런타임(Runtime)에서 동적 오버라이드

기본 텍스트 설정은 글로벌하게 유지하고, 이미지 생성 코드가 실행되는 시점에만 모델을 갈아끼우는 방식입니다. `default_for_images` 설정을 활용합니다.

```php
use Laravel\Ai\Image;
use Laravel\Ai\Enums\Lab;

// 이미지 생성할 때만 전용 모델을 명시
$image = Image::of('A donut sitting on the kitchen counter')
    ->generate(
        provider: Lab::Gemini,
        model: 'imagen-3.0-generate-002' // 👈 이미지 전용 타겟팅
    );
```

### 방법 B. 에이전트(Agent) 클래스에 어트리뷰트 고정 (강력 추천)

특정 복잡한 논리를 처리하는 AI 에이전트가 무조건 고성능 모델을 거쳐야 한다면, 해당 클래스 상단에 어트리뷰트를 지정하는 것이 가장 깔끔합니다.

```php
namespace App\Ai\Agents;

use Laravel\Ai\Attributes\Model;
use Laravel\Ai\Attributes\Provider;
use Laravel\Ai\Contracts\Agent;
use Laravel\Ai\Enums\Lab;

#[Provider(Lab::Gemini)]
#[Model('gemini-2.5-pro')] // 👈 이 에이전트는 config 설정을 무시하고 무조건 Pro를 씁니다.
class ComplexReasoner implements Agent 
{
    use Promptable;
    // ...
}
```

이렇게 해두면 `Image::of()`는 config에 설정된 가성비 모델을 따르고, `ComplexReasoner` 에이전트는 무조건 Pro 모델을 사용하게 되어 완벽한 역할 분담이 가능해집니다.

---

## 3. 보너스: Google의 오픈 모델 'Gemma'도 지원하나요?

**네, 완벽하게 지원합니다.** Gemma는 오픈 가중치 모델이라 클라우드 API 비용을 아끼거나 로컬 인프라를 구축하려는 스타트업에게 훌륭한 선택지죠. Laravel AI SDK에서는 크게 두 가지 방법으로 Gemma를 녹여낼 수 있습니다.

### 하나, OpenRouter 드라이버 활용 (가장 간편함)

Laravel AI SDK는 OpenRouter를 공식 지원합니다. API 키 하나만 있으면 클라우드에 호스팅된 다양한 크기의 Gemma 모델을 바로 찌를 수 있습니다.

```php
$response = (new SalesCoach)->prompt(
    '분석해줘...',
    provider: Lab::OpenRouter,
    model: 'google/gemma-3-27b-it' // 원하시는 Gemma 모델 명시
);
```

### 둘, Ollama와 커스텀 Base URL 매칭 (비용 0원 로컬 환경)

자체 인프라나 개발 환경 PC에 Ollama를 띄우고 Gemma를 받아두었다면, `config/ai.php`에서 `url` 파라미터를 수정해 로컬로 리다이렉트할 수 있습니다.

```php
'openai' => [
    'driver' => 'openai',
    'key' => 'not-needed-for-local',
    'url' => env('OLLAMA_BASE_URL', 'http://localhost:11434/v1'), // 👈 로컬 엔드포인트 개방
],
```

## 🚀 글을 마치며

[Laravel AI SDK](https://laravel.com/docs/13.x/ai-sdk)는 겉보기에는 단순해 보이지만, 파고들수록 멀티 모델 Failover(유지보수 기능), 구조화된 출력(Structured Output), 그리고 오늘 소개한 모델 유연성까지 스타트업이 엔터프라이즈급 AI 서비스를 빠르게 빌드하는 데 필요한 모든 것을 갖추고 있습니다.

지금 바로 여러분의 프로젝트에 `laravel/ai`를 설치하고, 똑똑한 에이전트를 라라벨 친화적인 코드로 구현해 보세요!
