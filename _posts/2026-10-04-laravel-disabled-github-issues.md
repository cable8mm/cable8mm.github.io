---
title: "탭이 사라졌습니다: Laravel이 GitHub Issues를 닫은 이유"
date: 2026-10-04 12:00:00 +0900
excerpt: "laravel/laravel 저장소에서 Issues 탭이 사라졌습니다. Taylor Otwell의 선택과 커뮤니티 반응, 그리고 이슈와 PR의 역할에 대해 생각해 봤습니다."
categories: opinion
tags: laravel github open-source ai opinion
author: Samgu Lee
header:
  og_image: /assets/images/taylor-disabled-github-issues.png
---

[laravel/laravel 저장소](https://github.com/laravel/laravel)에서 Issues 탭이 사라졌습니다. Taylor Otwell의 선택과 커뮤니티 반응, 그리고 이슈와 PR의 역할에 대해 생각해 봤습니다.

얼마 전 `laravel/laravel` 저장소에 들어갔다가 이상한 점을 발견했습니다. Issues 탭이 사라진 것입니다.

순간 제가 로그인 상태를 착각했나 싶었는데, 아니었습니다. Laravel이 GitHub Issues를 닫은 것입니다.

## 무슨 일이 있었나

9월 3일 Taylor Otwell이 X에 [이런 글](https://x.com/taylorotwell/status/2095516796748996843)을 올렸습니다.

![Taylor의 메시지](/assets/images/taylor-disabled-github-issues.png)

글을 올린 전 주에 대부분의 Laravel 오픈소스 패키지에서 GitHub Issues를 껐고, 버그를 만나면 코딩 에이전트에게 설명해서 PR을 올리라는 내용이었습니다. 코드가 완벽하지 않아도 괜찮고, PR 자체가 문제를 기록하는 역할을 하니 제대로 된 수정은 나중에 이어가면 된다고 했습니다. 그리고 앞으로 대부분의 오픈소스가 이렇게 운영될 것 같다고 덧붙였습니다.

범위를 정리하면 이렇습니다.

| 저장소                        | Issues                         |
| ----------------------------- | ------------------------------ |
| laravel/framework (코어)      | 켜져 있음 (Taylor가 직접 언급) |
| Socialite 같은 패키지         | 꺼짐                           |
| laravel/laravel (앱 스켈레톤) | 꺼짐 (직접 확인)               |

`laravel/laravel`을 따로 언급한 공지는 찾지 못했습니다. 다만 공식 기여 가이드에 [대부분의 first-party 저장소에서 Issues가 꺼져 있다](https://laravel.com/framework/docs/contributions#bug-reports)고 적혀 있고, 그 목록에 Laravel Application도 들어 있으니 같은 흐름으로 보입니다.

> To encourage active collaboration, Laravel strongly encourages pull requests that address problems, not GitHub issues. GitHub issues are disabled on most of our first-party packages.
>
> (라라발(Laravel) 팀이 활발한 협업을 장려하기 위해, (단순히 질문을 올리는) GitHub 이슈 생성보다는 문제를 직접 해결하는 풀 리퀘스트(PR)를 올려줄 것을 강력히 권장한다는 내용입니다. 실제로 라라발의 주요 퍼스트 파티 패키지들에서는 GitHub 이슈 탭이 비활성화되어 있습니다.)

가이드에는 [AI 관련 규칙](https://laravel.com/framework/docs/contributions#ai-generated-contributions)도 함께 있습니다. AI가 작성한 PR 설명은 닫히고, 이슈나 PR을 AI로 대량 생산하는 행위는 용납하지 않는다고 합니다.

## 커뮤니티는 어떻게 반응했을까?

제가 찾은 범위에서는 의견이 갈렸습니다.

**Laravel News**는 우호적이었습니다. [오래된 방식이라는 이유만으로 바꾸지 못할 이유는 없고, 안 맞으면 다시 켜면 된다는 입장](https://laravel-news.com/taylor-disabled-github-issues)입니다.

**Symfony**는 정반대로 가고 있습니다. [이슈만 받고, 수정은 메인테이너나 자체 AI가 하는 방식을 실험](https://symfony.com/blog/experimenting-with-issue-first-open-source-contributions)하고 있습니다.

Taylor 본인도 사람들이 이 방식을 어려워하고 있다는 점은 인정했습니다.

다만 Reddit이나 Hacker News까지 훑어보지는 못했습니다. 이것이 커뮤니티 전체의 여론이라고 말씀드리기는 어렵습니다.

## 이슈와 PR은 같은 것일까?

여기서 저는 한 가지가 마음에 걸렸습니다.

이슈는 **문제를 정의**하는 도구이고, PR은 **해결을 제안**하는 도구입니다. 둘을 합치면 접수 창구는 단순해지지만, 문제 정의가 코드 변경 속에 묻힙니다.

재현 조건이 불분명한 PR이 올라오면 리뷰어는 코드를 보기 전에 문제부터 다시 파악해야 합니다. 특히 AI가 만든 PR이라면 그럴듯하지만 엉뚱한 곳을 고쳤을 가능성도 있습니다. Caleb이 걱정한 부분이 바로 이것이라고 생각합니다.

하지만, 확실한 것은 Laravel 에 대한 글이 대폭 줄었다는 점입니다. 즉, 코드가 없으면 PR은 생성할 수가 없습니다. 하지만, 코드가 없어도 Issues에서 토론을 할 수가 있죠.

![조용한 Laravel 레포지토리](/assets/images/silent-laravel-repository.png)

토론이 활발한 Laravel 레포지토리에 남은건 현재 겨우 1건의 PR 뿐입니다.

## 그래도 이해가 되는 이유

반대로 Laravel의 선택이 이해되는 면도 있습니다.

[앱 스켈레톤 같은 저장소](https://github.com/laravel/laravel)는 파일이 적은 템플릿입니다. 버그 대부분은 코어나 패키지로 가고, 여기 올라오는 이슈는 설치나 설정 같은 지원 요청이 많았을 것입니다. 그런 곳에서는 이슈를 관리하는 비용이 얻는 가치보다 클 수 있습니다.

그래서 문제 정의가 중요한 코어는 이슈를 남기고, 지원 요청이 몰리는 곳은 닫은 것이라고 보면 나름 일관성이 있습니다.

## 마치며

결국 이번 일은 "이슈가 필요 없다"는 선언이라기보다, AI 시대에 **접수 창구를 어떻게 설계할 것인가**에 대한 실험이라고 생각합니다.

Laravel은 PR로, Symfony는 이슈로 각자 반대 방향을 택했습니다.

제가 오픈소스로 운영하고 있는 [REPL Works](https://www.repl.net/)에서는 [ai-issue 도구](https://www.repl.net/showcase/ai-issue/)를 이용해서 프롬프트를 만들며, 그것을 GitHub Issues로 올려서 PR을 만드는 AI에게 전달합니다.

AI와 개발함에 있어서 Issues는 많은 도움이 된다고 생각하는데, PHP 생태계에서는 어떻게 결론이 날런지 궁금해 지네요.
