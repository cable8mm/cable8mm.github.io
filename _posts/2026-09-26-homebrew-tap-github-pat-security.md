---
layout: single
title: "GitHub PAT로 Homebrew Tap을 배포하다가 발견한 보안 문제"
date: 2026-09-26 14:46:00 +0900
categories: development
tags: development github homebrew devops security
author: Samgu Lee
header:
  og_image: /assets/images/homebrew-tap-github-pat-security.png
---

최근 [`coolrestore`](https://github.com/replworks/coolrestore)의 배포 설정을 정리하다가 GitHub PAT 하나를 다시 확인하게 되었습니다.

![깃헙 배포 권한과 PAT 문제 해결](/assets/images/homebrew-tap-github-pat-security.png)

몇 달 전에 Homebrew Tap 배포를 위해 만들어 놓은 토큰이었습니다. 당시에는 특별히 문제가 있다고 생각하지 않았습니다. [`ai-issue`](https://github.com/replworks/ai-issue)와 [`repl-cli`](https://github.com/replworks/repl-cli)에서도 같은 방식으로 사용하고 있었고, 지금까지 배포가 실패한 적도 거의 없었기 때문입니다.

그런데 토큰 설정을 다시 열어보니 제가 생각했던 것과 전혀 다른 권한을 가지고 있었습니다.

![깃헙 PAT 토큰 상세화면](/assets/github-personal-access-tokens.png)

순간 조금 당황했습니다.

제가 필요했던 것은 [`homebrew-tap`](https://github.com/replworks/homebrew-tap) 저장소 하나에 Cask 파일을 push할 수 있는 권한이었습니다. 그런데 실제로 만들어 놓은 토큰은 [REPLWorks 조직](https://github.com/replworks)의 모든 현재 및 미래 저장소에 대해 코드를 읽고 쓸 수 있는 권한을 가지고 있었습니다.

한마디로 **슈퍼토큰**이었습니다.

## 왜 이런 토큰을 만들었을까?

REPLWorks에서 만드는 CLI 도구들은 대부분 GoReleaser를 이용해서 배포하고 있습니다. 최근 만들고 있는 `coolrestore`도 그렇고, `ai-issue`와 `repl-cli`도 같은 방식입니다.

예를 들어 `coolrestore`에서 tag를 push하면 GitHub Actions가 실행되고 GoReleaser가 Release를 생성한 뒤 바이너리를 업로드합니다. 그리고 Homebrew를 통해 설치할 수 있도록 별도의 `replworks/homebrew-tap` 저장소에도 Cask 파일을 생성합니다.

구조로 보면 간단합니다.

```text
coolrestore
    │
    ├── GitHub Release
    │
    └── replworks/homebrew-tap
             └── Cask
```

여기에서 약간 귀찮은 문제가 있습니다.

GitHub Actions가 기본으로 제공하는 `secrets.GITHUB_TOKEN`은 현재 workflow가 실행되는 저장소를 대상으로 사용하기 때문에 `coolrestore`에서 `homebrew-tap`에 파일을 push하는 용도로는 사용할 수 없습니다.

그래서 별도의 Personal Access Token이 필요했습니다.

제가 처음 이 작업을 구성했을 때는 그냥 PAT 하나를 만들었습니다.

이름도 기억하기 쉽게 `replworks-homebrew-tap-token` 정도로 붙였습니다. 그리고 GitHub Actions에는 `HOMEBREW_TAP_TOKEN`이라는 secret으로 등록했습니다.

GoReleaser에는 다음과 같이 전달했습니다.

```yaml
- uses: goreleaser/goreleaser-action@v6
  with:
    version: latest
    args: release --clean
  env:
    {% raw %}GITHUB_TOKEN: ${{ secrets.HOMEBREW_TAP_TOKEN }}{% endraw %}
```

잘 됐습니다.

`GITHUB_TOKEN` 자리에 제가 만든 PAT를 넣으니 현재 저장소의 Release도 정상적으로 생성되고, `homebrew-tap`에도 Cask 파일이 올라갔습니다.

`ai-issue`와 `repl-cli`에서도 같은 방식으로 구성했습니다.

그리고 몇 달 동안 아무 문제가 없었습니다.

## "잘 되니까" 문제가 보이지 않았습니다

당시의 작업은 Gemini와 함께 했습니다. 다른 AI에 비해서 Gemini는 일반적인 상황에 대한 지식이 다른 AI보다 풍부하다고 판단했기 때문입니다.

반면 이번 프로젝트(`coolrestore`)는 Claude와 함께 작업했습니다. 코딩은 Codex로 했지만 판단을 Gemini와 Claude로 다르게 가져갔죠. 여기서 Gemini와 Claude의 답변이 달라진 겁니다.

제가 원했던 것은 사실 두 가지였습니다.

현재 저장소에서는 GitHub Release를 만들고, 다른 저장소인 `homebrew-tap`에는 Cask 파일을 push하는 것입니다.

그런데 Gemini는 두 작업을 하나의 PAT로 해결했습니다.

전 당시에 이것이 편하다고 생각했습니다. 토큰 하나만 관리하면 되고, GoReleaser에도 하나의 `GITHUB_TOKEN`만 전달하면 되기 때문입니다.

그런데 Claude는 강하게 이 방식의 위험성을 나에게 지속적으로 알려왔으며, 문제가 생길 때 내가 온전히 책임져야 한다고 했으며, 내가 그 역할을 충분히 인지하면 Claude 자신도 그 방향으로 진행할 거라는 대답을 내놨죠.

난 Claude와 ChatGPT에게 이번 절차에 대한 상세 내용을 전달 받고, 최대한 손이 많이 가지 않지만 보안은 더 뛰어난 방향을 합의해서 Claude에게 전달했습니다.

Claude가 강하게 어필했던 문제의 발단은 PAT의 권한이 너무 넓었던 것입니다.

`homebrew-tap`에만 접근할 수 있어서 두 작업이 가능했던 것이 아니라, 애초에 REPLWorks의 모든 저장소에 접근할 수 있었기 때문에 어디에서 사용해도 동작했던 것입니다.

## 만약 이 토큰이 유출된다면?

이 부분을 생각해보니 문제가 훨씬 명확해졌습니다.

예를 들어 `coolrestore`의 GitHub Actions에서 이 토큰이 유출됐다고 가정해 보겠습니다.

제가 원했던 권한의 범위는 이 정도입니다.

```text
coolrestore
    │
    └── Homebrew Tap
            └── Cask push
```

그런데 실제 토큰의 권한은 이렇습니다.

```text
REPLWorks
    ├── coolrestore
    ├── ai-issue
    ├── repl-cli
    ├── homebrew-tap
    └── 기타 모든 저장소
```

그리고 이 저장소들의 코드를 읽고 쓸 수 있습니다.

즉 `coolrestore` 하나를 배포하기 위해 만든 토큰이 유출되었을 때 `coolrestore`만 영향을 받는 것이 아니라 조직 전체 저장소가 영향을 받을 수 있는 구조였습니다.

실제로 토큰이 유출되었다는 이야기는 아닙니다. 다만 CI/CD에서 사용하는 credential이라면 항상 "이것이 유출되었을 때 어디까지 영향을 받을 수 있는가?"를 생각해야 합니다.

특히 GitHub Actions는 여러 외부 action과 의존성을 함께 사용하기 때문에 credential의 권한 범위를 좁게 유지하는 것이 중요합니다. 다만 이 이유로 배포할 때 마다 손이 간다던지 하는 이슈가 추가로 발생하는건 동시에 여러개의 프로젝트를 운영하는 저로서는 받아들이기 힘들었습니다.

결국 제가 만들어 놓은 구조는 기능적으로는 문제가 없었지만 보안적으로는 필요 이상의 권한을 가지고 있었고, 운이 좋게 GitHub Merge 후 Release 할 때 자동으로 배포까지 되는 프로세스는 유지할 수 있었습니다.

## Secret의 위치와 권한은 다른 문제였습니다

이번에 하나 더 제대로 이해하게 된 것이 있습니다.

저는 그동안 `repo secret`과 `org secret`을 생각하면서 secret을 어디에 저장하느냐와 실제 권한 범위를 조금 섞어서 생각했던 것 같습니다.

하지만 둘은 별개의 문제였습니다.

예를 들어 다음과 같이 생각할 수 있습니다.

|                        | Repository Secret | Organization Secret |
| ---------------------- | ----------------- | ------------------- |
| 특정 repository만 접근 | 가능              | 가능                |
| 모든 repository 접근   | 가능              | 가능                |

Secret을 조직에 등록했다고 해서 그 안에 들어 있는 토큰까지 모든 repository에 접근할 필요는 없습니다.

반대로 repository의 secret으로 등록했다고 해서 토큰 자체의 권한이 그 repository 하나로 제한되는 것도 아닙니다.

결국 확인해야 하는 것은 secret의 저장 위치가 아니라 **토큰 자체가 어디까지 접근할 수 있는가**였습니다.

이번에 제가 잘못 생각했던 부분도 바로 이것이었습니다.

## 그래서 토큰을 두 개로 분리했습니다

먼저 Claude 제안에 따라 현재 repository의 GitHub Release를 만드는 작업은 GitHub Actions가 제공하는 `GITHUB_TOKEN`을 사용하도록 변경했습니다.

```yaml
permissions:
  contents: write
```

그리고 GoReleaser에는 기존처럼 `GITHUB_TOKEN`을 전달합니다.

```yaml
env:
  {% raw %}GITHUB_TOKEN: ${{ secrets.GITHUB_TOKEN }}{% endraw %}
```

이 작업에는 별도의 PAT가 필요하지 않습니다.

그 다음 [`homebrew-tap`](https://github.com/replworks/homebrew-tap)에 push하기 위해서 기존 PAT의 권한을 모든 레포지토리에서 homebrew-tap 레포지토리로 권한을 축소했습니다.

![권한이 축소된 PAT 키](/assets/replworks-pat-for-homebrew-tap-repository.png)

이번에는 Repository access를 `Only select repositories`로 제한하고 [`homebrew-tap`](https://github.com/replworks/homebrew-tap) 하나만 선택했습니다.

그리고 Permission도 필요한 것만 남겼습니다. 이렇게 하면 이 토큰이 할 수 있는 일은 상당히 명확해집니다.

현재 repository의 Release는 `GITHUB_TOKEN`이 담당하고, Homebrew Tap에 대한 push만 별도의 PAT가 담당합니다.

## GoReleaser에서도 명확하게 분리했습니다

GitHub Actions에서는 두 토큰을 각각 다른 환경변수로 전달합니다.

```yaml
- uses: goreleaser/goreleaser-action@v6
  with:
    version: latest
    args: release --clean
  env:
    {% raw %}GITHUB_TOKEN: ${{ secrets.GITHUB_TOKEN }}{% endraw %}
    {% raw %}HOMEBREW_TAP_GITHUB_TOKEN: ${{ secrets.HOMEBREW_TAP_TOKEN }}{% endraw %}
```

그리고 `.goreleaser.yml`에서 Homebrew Cask repository가 사용할 토큰을 명시했습니다.

```yaml
homebrew_casks:
  - repository:
      owner: replworks
      name: homebrew-tap
      {% raw %}token: "{{ .Env.HOMEBREW_TAP_GITHUB_TOKEN }}"{% endraw %}
```

이 부분도 처음에는 별것 아니라고 생각했는데 중요합니다.

토큰을 두 개 만들어 놓는 것만으로는 아무 의미가 없습니다. GoReleaser가 어떤 작업에 어떤 토큰을 사용할 것인지 명확하게 연결해 주어야 합니다.

결과적으로 지금은 구조가 이렇게 되었습니다.

```text
GitHub Actions
       │
       ├── GITHUB_TOKEN
       │       │
       │       └── 현재 repository
       │              └── GitHub Release
       │
       └── HOMEBREW_TAP_GITHUB_TOKEN
               │
               └── homebrew-tap
                      └── Cask push
```

Release를 할 때 자동으로 배포되는 절차는 지켜지면서 보안은 더 높아지니, 처음보다 마음이 편합니다.

## 토큰을 만들 때 무엇을 확인해야 하는가

이번 일을 겪고 나니 PAT를 만들 때 확인해야 할 것이 아주 단순해졌습니다.

처음에는 토큰 이름을 보고 있었습니다.

`HOMEBREW_TAP_TOKEN`이라고 이름을 지었으니 당연히 Homebrew Tap용 토큰이라고 생각했습니다.

그런데 토큰 이름은 아무런 권한도 제한하지 않습니다.

실제로 확인해야 하는 것은 Repository access와 Permissions입니다.

특히 Repository access에서 `All repositories`를 선택하는 순간부터는 "이 토큰이 정말 모든 repository에 접근해야 하는가?"를 한 번 더 생각해봐야 합니다.

저의 경우에는 답이 아니었습니다.

Homebrew Tap 하나에 파일을 push하면 되는 작업이었기 때문입니다.

## "되는 것"과 "필요한 권한만 가지고 되는 것"은 다릅니다

이번 일을 겪으면서 CI/CD credential을 보는 관점도 조금 달라졌습니다.

예전에는 "배포가 잘 되는가?"를 가장 먼저 확인했습니다.

이번에는 거기에 하나를 더 추가하게 되었습니다.

> 이 작업을 하기 위해 필요한 것보다 더 많은 권한을 가지고 있지는 않은가?

사실 개발하다 보면 권한을 넓게 주는 것이 편할 때가 많습니다.

안 되면 권한을 하나 더 추가하고, 그래도 안 되면 전체 repository에 접근할 수 있도록 설정하면 대부분 해결됩니다.

저도 그렇게 했던 것 같습니다.

하지만 그 편리함은 결국 credential이 유출되었을 때의 blast radius로 돌아옵니다. 소규모 개발팀의 경우 Best Practice가 너무너무 중요합니다. 별도 절차마다의 담당자가 없기 때문에 최대한 검증된 기술과 코드를 추구해야죠.

이번 경우에는 `homebrew-tap`에 push하기 위해 조직 전체 repository에 대한 쓰기 권한을 주고 있었습니다.

굳이 그럴 이유가 없었습니다.

`ai-issue`와 `repl-cli`는 아직 예전 슈퍼토큰을 사용하고 있습니다.

이번에 `coolrestore`를 수정한 것을 시작으로 두 프로젝트도 같은 방식으로 교체할 예정입니다. 이미 토큰 권한도 줄어들었으니, 지금 배포를 하면 아마도 에러가 나겠죠.

돌이켜보면 아주 단순한 문제였습니다.

**하나의 토큰으로 여러 작업을 처리하는 것이 편하다는 이유로, 필요한 권한보다 훨씬 큰 권한을 주고 있었습니다.**

몇 달 동안 아무 문제 없이 잘 작동했기 때문에 더 늦게 발견했습니다.

이번 일을 계기로 앞으로 CI/CD에서 토큰을 만들 때는 "이게 되는가?"뿐만 아니라 **"이게 유출되면 어디까지 영향을 받을 수 있는가?"**를 같이 확인하려고 합니다.

실무적으로는 최소 2개의 AI와 협업으로 프로젝트를 진행해야 한다는 것을 느꼈습니다. 특히 운영/배포의 경우 테스트하기가 쉽지 않기 때문에 더 많은 AI와의 검토가 필요한 것 같습니다.
