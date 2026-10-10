---
title: "문서 2시간, 개발 1시간: AI와 대화로 Laravel 패키지를 같은 날 배포했습니다"
date: 2026-10-11 02:40:00 +0900
excerpt: "AI 코딩에서 제일 오래 걸린 건 코딩이 아니라 문서였습니다. AGENTS.md와 필수 4종 문서, 믿을 수 있는 CI/CD로 이미지 포지(Image Forge) Laravel 패키지를 만들어 같은 날 Packagist에 배포하고, wifinote.net에 적용해 v1.1.0까지 올린 과정을 정리했습니다."
categories: development
tags: laravel packagist ai-coding agents-md github-actions ci-cd image-forge replworks
author: Samgu Lee
header:
  og_image: /assets/images/laravel-imageforge-ai-development.png
---

Laravel에서 이미지 URL을 만들 때마다 모델마다 URL 조립 코드를 넣는 게 불편했습니다. 비즈니스 로직도 아닌 코드와 설정이 대규모로 들어가고, [동적 이미지 프록시 서비스 이미지 포지(Image Forge)](https://if.repl.net) 의 규격이 바뀔 때마다 수정하고 테스트하는 것도 일이었습니다. 그래서 패키지로 만들기로 했습니다.

![이미지 포지(Image Forge)의 플레이그라운드](/assets/images/laravel-imageforge-ai-development.png)

> `replworks/laravel-imageforge`

[REPL Works 방식](https://www.repl.net)으로 개발했는데, 결과부터 말씀드리면 이렇습니다.

- 개발 필수 4종 문서를 만드는 데 **2시간** (복잡한 제품은 6시간까지 걸릴 때도 있습니다)
- AI와 개발하는 데 **1시간이 조금 안 됨**
- 실제 서비스에 적용하며 개밥 먹고 업데이트하는 데 **1-2시간**
- 릴리스 v0.1.0, v1.0.0, v1.1.0이 모두 **같은 날(2026-10-10)**

## 순서가 뒤집혔습니다

보통은 코딩이 오래 걸리고 문서는 다른 분이 써 주거나 내가 쓸 때는 엑셀이나 다이어그램 위주로 만듭니다. 이번에는 반대로 했습니다. 코드를 시키기 전에 AI가 읽을 문서 4종을 먼저 만들었습니다.

- [**PRODUCT_SPEC**](https://www.repl.net/documents/product-spec/): 무엇을 만드는가
- [**TECH_STACK**](https://www.repl.net/documents/tech-stack/): 어떤 기술, 어떤 버전, 어떤 규칙으로 만드는가
- [**ARCHITECTURE**](https://www.repl.net/documents/architecture/): 어떻게 동작하는가
- [**TASKS**](https://www.repl.net/documents/tasks/): 다음에 무엇을 할 것인가

이 문서들은 사람이 읽으려는 게 아니라 [코딩하는 AI가 읽는 문서](https://www.repl.net/documents/)입니다. 그리고 모든 문서의 입구가 [`AGENTS.md`](https://www.repl.net/documents/agents/)입니다. 어떤 문서가 무엇을 책임지는지, 충돌하면 무엇이 우선인지, 마음대로 새 문서를 만들지 말라는 규칙까지 여기에 들어 있습니다.

## 문서에 2시간이 걸린다는 것

문서 작업이 오래 걸리는 건 REPL Works 방식에서는 어쩔 수 없습니다. 개발 프로젝트를 해 본 분이라면 아시겠지만, 개발에 시간이 오래 걸리는건 제작이 아니라 테스트와 개선입니다. REPL Works는 [이 부분의 문제 해결이 가장 중요하다는 생각에서 출발한 개발 방법론](https://www.repl.net/faq/)입니다.

이번 패키지는 작은 편이라 2시간이었고, 복잡한 제품은 6시간까지 걸릴 때도 있습니다. 사람도 마찬가지지만 AI도 코딩이 길어져 세션의 모든 내용을 기억하지 못할 때 문서가 필요합니다. 그리고 그 문서는 개발과 함께 갱신되는 Live 문서여야 합니다.

아래 내용은 `AGENTS.md`에서 Live 문서를 강제하는 제약입니다.

```markdown
## CONFLICT_HANDLING

When documents conflict:

1. Follow the higher-priority document.
2. Report the conflict to the human.
3. Fix the lower-priority document together with the human before continuing.

Never resolve a conflict silently.
Never leave a conflict in place after the task is complete.
```

무엇을 만들지, 어떤 기술과 버전을 쓸지, 어떻게 동작하게 할지는 어차피 누군가 정해야 합니다. 문서 없이 AI에게 맡기면 그 결정을 대화하면서, 틀리고 고치면서 하게 됩니다. 더 중요한건 개발 도중에 발생하는 수정 내용이 개발에 들어가기 전에 문서에 업데이트 되고 논리적 정합성을 체크한다는 점입니다. 이 부분이 무너지면 `AGENTS.md`에 따라 AI는 개발을 하지 못합니다.

그래서 이 방식이 모든 작업에 맞다고 말하지는 않습니다. 한 번 쓰고 버릴 스크립트라면 문서 2시간은 과합니다. 다만 계속 키우고 고쳐 나갈 제품이라면, 문서에 쓴 시간은 개발이 중단된 프로젝트라도 언제든 이어서 개발할 수 있기 때문에 개발자에게 심리적 안심을 만들어 줍니다.

## 실제로 한 일은 거의 "next"뿐입니다

AI에게 처음 한 말은 이게 전부였습니다.

> AGENTS.md 읽고 TASKS.md 수행하자

그 뒤로는 거의 "next"만 입력했습니다.

![Next Next Next](/assets/images/next-next-next.png)

작업(T-001, T-002...)이 하나 끝날 때마다 AI는 Pint, PHPUnit을 돌리고 TASKS.md에 완료 표시를 했습니다. 다음 작업은 제가 시키기 전에는 시작하지 않았습니다. 테스트는 1개에서 시작해 T-007 시점에 30개(assertion 79개)까지 늘었고, PR도 작업 단위로 쌓였습니다.

## 중간 결정은 다른 AI에게 물었습니다

설계는 Claude가 했고, 개발은 Codex가 하고 있었는데, 개발 중간에 발생하는 추가 기능에 대한 결정은 Gemini에게 물어봤습니다. Gemini는 확실하지 않은 내용을 말할 때가 있어서 모르는 분야에서는 믿기 어렵지만, 제가 진실과 거짓을 판별할 수 있는 분야에서는 꽤 친절하고 자세하게 설명해 줍니다. 이슈가 된 부분은 제가 예전에 직접 개발해 본 적이 있었는데 기억이 가물가물한 상태였습니다. 그래서 Gemini의 답을 제가 검토하면서 방향을 잡았습니다.

그 결과 처음에 검토했던 모델 casts 방식은 버렸습니다. 대신 이렇게 정했습니다.

```php
class Template extends Model
{
    use HasImageForge;

    protected array $imageForgeFields = ['preview_path', 'image_path'];
}

$template->previewPathImageForge(w: 320, h: 240)->storage();
$template->imagePathImageForge(w: 640)->storage();
```

DB에는 상대경로 문자열을 그대로 두기 위해서였습니다. 또 Laravel에서는 `/storage/` 경로가 붙고 안 붙고가 Blade에서 쓰는 함수에 따라 갈리기 때문에 `storage()`와 `asset()`을 따로 두었습니다.

AI에게 맡길 때는 제가 판단할 수 있는 영역인지가 중요하다고 느꼈습니다. 판단할 수 있으면 AI가 초안을 주고 제가 검토하면 되고, 판단할 수 없으면 AI의 답을 믿어도 되는지부터 확인해야 합니다.

AI는 가능한 방법을 곧잘 늘어놓지만, 그중 무엇이 최선인지는 말해 주지 않습니다. 그 판단은 오롯이 사람의 몫입니다.

## 왜 이게 가능했는가

돌아보면 세 가지였습니다.

**1. 문서가 AI의 기억을 대신했습니다.** AI는 대화가 끊기면 맥락을 잃습니다. 하지만 PRODUCT_SPEC과 TASKS가 있으면 새 세션이든 다른 AI든 같은 지점에서 이어갈 수 있습니다. 실제로 REPL Works 초기에는 기술 스택 문서 없이 AI에게 맡겼더니 버전을 틀리고 코드를 엉뚱한 곳에 두는 실수가 반복됐고, 그 경험이 [TECH_STACK 문서](https://www.repl.net/documents/tech-stack/)가 생긴 이유였습니다.

**2. AGENTS.md가 규칙을 강제했습니다.** AI가 알아서 판단하는 영역이 줄어드니 결과가 예측 가능해졌습니다.

**3. 믿을 수 있는 CI/CD가 있었습니다.** AI가 "됐습니다"라고 말하는 것과 실제로 되는 것은 다릅니다. 어떤 스택을 사용해도 기능 1개에 반드시 테스트 코드가 들어갑니다. 또한 GitHub Actions가 매번 검증해 주니 저는 코드를 일일이 보지 않아도 됐습니다.

그리고 제가 만드는 모든 배포는 GitHub에 release를 만들기만 하면 끝납니다. Coolify를 통해 배포 절차는 단순하지만 Rolling Update로 배포 중단이 되도 서비스는 중지되지 않습니다. 성공을 해도 테스트 코드가 모두 성공해야 하고, 서버가 살아있어야 새로운 코드가 작동됩니다.

이런 것들이 확실해야 AI와 더 마음 편하게 개발할 수 있다라는게 그 동안의 경험입니다.

문서도, 작업 목록도, 코드도, 검증도, 배포도, 롤백도 전부 GitHub 안에서 이루어집니다. 그래서 저는 AI와의 대화로 제품에서 배포까지, 프로덕션 레벨로 갈 수 있었다고 생각합니다.

## 그래서 프로덕션 레벨인가

네, 실제로 쓰고 있습니다.

![와이파이 노트 템플릿 썸네일 리스트](/assets/images/wifinote-template-thumbnails.png)

[와이파이 노트](https://wifinote.net)라는 제품의 모든 템플릿 썸네일을 크기별로 [이미지 포지](https://if.repl.net)라는 제품을 통해 동적으로 변환하도록 바꿨고, 그 URL을 이 패키지가 만듭니다. 모든 기능에 대해 Unit, Feature, E2E 테스트도 마쳤습니다. 그리고 `replworks/laravel-imageforge`라는 이름으로 [Packagist](https://packagist.org/packages/replworks/laravel-imageforge)에 올렸습니다.

[릴리스 기록](https://github.com/replworks/laravel-imageforge/releases)은 이렇습니다. 모두 같은 날입니다.

- **v0.1.0**: 설정, 원본 URL, Forge URL 생성, `HasImageForge` Trait, README, GitHub Actions
- **v1.0.0**: README 정리, Blade 디렉티브 추가
- **v1.1.0**: escape하지 않는 raw Blade 디렉티브 추가

### 개밥(Dogfooding)을 먹어 보니 필요했던 것: Blade 디렉티브

Blade 디렉티브는 처음 설계에 없었습니다. 모델과 연결된 이미지는 이미 해결했지만, 모델 없이 Blade에만 있는 이미지는 생각하지 못했습니다. 예를 들어 og image가 그렇습니다. 와이파이 노트에 실제로 적용해 보고 나서야 필요하다는 걸 알았습니다.

```blade
@imageForgeAsset('assets/seo/og.png', w: 1200, h: 630, f: 'jpeg')
@imageForgeStorage('uploads/og.png', w: 1200, h: 630)
```

그런데 적용하다 보니 문제가 생겼습니다. AI가 처음 만들어 준 디렉티브 코드에는 `e()`가 들어 있었습니다. 출력할 때 escape를 해 주는, 보안상 올바른 기본 동작입니다. 하지만 제 서비스에는 이미 `{{ $ogImage }}` 형태로 값이 들어가 있었고, 이 형태는 Blade가 한 번 escape를 합니다. 결국 escape가 두 번 일어나는 상황이었습니다.

AI의 코드가 틀린 건 아니었습니다. 그래서 오히려 결정이 어려웠고, AI와 아키텍처에 대해 30분 정도 논의했습니다. 기존 디렉티브의 동작을 바꾸면 이미 쓰는 코드에서 에러가 날 수 있어서, 기존 2개의 디렉티브는 그대로 두고 escape하지 않는 디렉티브 2개를 새로 추가해 호환성을 지키기로 했습니다. 이게 [v1.1.0](https://github.com/replworks/laravel-imageforge/releases/tag/v1.1.0)입니다.

```blade
@section('meta_image')
    @imageForgeAssetRaw('assets/seo/og.png', w: 1200, h: 630)
@endsection
```

섹션이나 변수에 담아 두었다가 나중에 `{{ }}`로 출력할 때는 raw 디렉티브(`@imageForgeAssetRaw`, `@imageForgeStorageRaw`)를, 바로 출력할 때는 기존 디렉티브를 쓰면 됩니다.

og image에 이미지 포지를 쓰면 좋은 점이 하나 더 있습니다. og image용 썸네일을 따로 만들 필요가 없어집니다. 원본 하나만 있으면 필요한 크기로 URL만 바꿔서 쓰면 되니까요. 저는 이걸 이미지 포지의 장점 중 하나라고 생각하고, [이미지 포지 웹사이트](https://if.repl.net) 쇼케이스의 썸네일에도 같은 방식으로 넣었습니다.

개밥을 먹으면서 1-2시간 더 걸려 반영했고, 이것도 문서를 고치고 AI와 개발하는 같은 방식으로 끝났습니다.

### v1.0.0으로 올린 이유

v1.0.0으로 올린 것은 "완성됐다"는 선언이 아니라 Composer 때문입니다. 0.x 버전에서는 `^0.1`처럼 지정하면 0.1.x에 묶이기 때문에, 이미 제품에서 쓰고 있다면 업데이트할 때마다 composer.json을 직접 고쳐야 합니다. 1.x로 올려 두면 `composer update`만으로 간단히 버전업할 수 있습니다. 이미 제품에 적용한 패키지라면 일찍 1.0으로 올리는 게 편합니다.

기존 동작을 바꾸지 않고 디렉티브만 추가해서 v1.1.0으로 올린 것도 같은 이유입니다.

## 만들고 나서 한 일

적용을 끝낸 뒤 이미지 포지 웹사이트에 "연동 패키지 & 생태계" 섹션을 만들어 배포했습니다. 이 배포도 GitHub에 release를 만들면 Coolify를 통해 배포됩니다.

![이미지 포지의 첫번째 쇼케이스](/assets/images/image-forge-showcase-at-first.png)

## 정리

AI 코딩에서 제일 오래 걸린 건 코딩이 아니라 문서였고, 그 시간 덕분에 나머지가 "next"의 반복으로 끝났습니다.

설계는 Claude, 개발은 Codex, 중간 결정은 Gemini로 나눠 썼는데도 결과가 흔들리지 않았습니다. 모델은 바꿔 가며 쓸 수 있는 도구였고, 일관성은 문서와 AGENTS.md, CI/CD가 지켜 줬습니다. 그래서 저는 모델의 성능보다 AI가 읽을 문서, 문서를 강제하는 `AGENTS.md`, 결과를 검증해 주는 CI/CD가 더 중요하다고 생각합니다.

이번 프로젝트는 [GitHub에 오픈](https://github.com/replworks/laravel-imageforge)되었습니다.
