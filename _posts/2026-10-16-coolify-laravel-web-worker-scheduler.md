---
title: "Coolify에서 Laravel을 web / worker / scheduler 3개로 배포하기"
date: 2026-10-16 13:30:00 +0900
excerpt: "Coolify는 Docker Compose에서 롤링 업데이트가 되지 않습니다. 앱 3개를 만들고 환경변수 하나로 역할을 나누는 배포 설정과 헬스체크 규칙을 정리했습니다."
categories: development
tags: coolify, laravel, docker, horizon, deployment, 배포
author: Samgu Lee
header:
  og_image: /assets/images/coolify-laravel-web-worker-scheduler.png
---

라라벨(Laravel) 프로젝트에서 배포는 Laravel Forge나 Laravel Envoyer를 사용하면 간단하게 구성할 수 있습니다. 하지만 장점만 있는건 아니죠.

![Coolify와 Laravel](/assets/images/coolify-laravel-web-worker-scheduler.png)

우선 이 두개의 서비스는 유료입니다. 그리고, 컨테이너 기반이 아닙니다.

컨테이너 기반의 배포는 장단점이 있습니다. 장점은 환경(environment)를 동일하게 구성하여 안정적인 개발 배포 스케일 확장을 할 수 있게 됩니다. 게다가 언어나 프레임워크가 섞인 시스템에서도 문제가 없죠.

단점은 도커를 사용하지 않을 때 보다 무언가 복잡해진 느낌을 받는다는 겁니다. 문제는 이겁니다. 난 개발을 하는데 도커는 왠지 개발자가 해야되는 일이 아닌것 같다는 느낌이 듭니다. 그래서 도커 위에서 개발하는 것도 거부감이 들고 도커 명령어를 공부해야 하는 것도 익숙해 지는 것도 내심 좋아하지 않는 경우도 있습니다.

이럴 경우 개발자가 도커에 신경쓰지 않고 개발할 수 있는 매니지드 서비스가 필요한데 오픈소스 제품 중 단연 Coolify가 압도적으로 완성도가 높습니다. GitHub 스타는 현재 63,000개 입니다.

![Coolify의 스타 63000개 이상](/assets/images/coolify-stars.png)

Coolify에 라라벨 프로젝트를 배포할 때 최선이라고 생각하는 방식을 공유합니다.

우선, 도커 컨테이너 1개에 웹과 워커, 스케쥴러를 모두 실행하는건 나중에 웹 애플리케이션을 늘릴 수가 없기 때문에 고려하지 않았습니다.

그리고, 스케쥴러와 워커를 1개의 도커 컨테이너에 넣는것도 둘의 생명주기가 다르기 때문에 배포를 할 때 오류가 발생할 가능성이 높고, 결정적으로 스케쥴러는 무중단 배포를 하게 되면 중복 구간이 생길 수 있기 때문에 두번 실행될 가능성이 있습니다.

따라서, 웹, 워커, 스케쥴러 이렇게 세 가지 프로세스가 필요한데, Coolify는 Docker Compose에서 롤링 업데이트를 지원하지 않기 때문에 앱을 도커 컨테이너 3개로 나누어 배포합니다.

![wifinote.net 의 Coolify 프러덕션](/assets/images/wifinote-coolify-production.png)

## 1. 원칙

- 레포에는 `Dockerfile`과 같은 도커파일을 공유하기 위해서 `docker/entrypoint.sh`만 둡니다.
- 나머지 서버 설정은 Coolify에서 합니다.

인프라 설정이 코드에 섞이지 않으면 헬스체크 주기나 볼륨 같은 변경을 코드 배포 없이 처리할 수 있습니다.

## 2. entrypoint.sh로 역할 분기

같은 이미지를 사용하고, `WIFINOTE_ROLE` 환경변수로 실행할 프로세스를 정합니다.

```bash
if [[ "$#" -eq 0 ]]; then
    case "${WIFINOTE_ROLE:-web}" in
        web)       set -- apache2-foreground ;;
        worker)    set -- php artisan horizon ;;
        scheduler) set -- php artisan schedule:work ;;
        *)
            echo 'WIFINOTE_ROLE must be either web, worker, or scheduler.' >&2
            exit 1
            ;;
    esac
fi

exec "$@"
```

Coolify 버전에 따라 Custom Start Command나 Custom Docker Options 칸이 없을 수 있습니다. 환경변수 분기는 UI와 상관없이 동작합니다.

## 3. Coolify 설정

같은 이미지로 앱 3개를 만들고 환경변수만 다르게 지정합니다.

| 앱        | 환경변수                  | Post-deployment                                       | 헬스체크                          |
| --------- | ------------------------- | ----------------------------------------------------- | --------------------------------- |
| web       | `WIFINOTE_ROLE=web`       | `php artisan migrate --force && php artisan optimize` | 기본 HTTP                         |
| worker    | `WIFINOTE_ROLE=worker`    | 없음                                                  | Command: `pgrep -f horizon`       |
| scheduler | `WIFINOTE_ROLE=scheduler` | 없음                                                  | Command: `pgrep -f schedule:work` |

`.env`를 복호화하는 `LARAVEL_ENV_ENCRYPTION_KEY`는 3개 앱 모두에 필요합니다.

## 4. Post-deployment 규칙

- 마이그레이션은 web의 Post-deployment에서만 실행합니다. 여러 컨테이너에서 동시에 실행하면 충돌할 수 있습니다.
- Pre-deployment에는 마이그레이션을 넣지 않습니다. 이전 컨테이너에서 실행되므로 새 코드가 반영되기 전입니다.
- `storage:link`는 Dockerfile 빌드 단계에서 실행하기 때문에 Post-deployment에는 넣지 않습니다.
- worker와 scheduler는 Ports Exposes와 도메인을 비웁니다. Dockerfile에 `EXPOSE 80`이 있으면 포트가 자동으로 잡힐 수 있으니 확인이 필요합니다.

## 5. worker, scheduler 헬스체크

HTTP를 서빙하지 않는 두 앱은 Command 방식을 사용합니다. 주의할 점이 몇 가지 있습니다.

- Command 칸에 따옴표, 파이프, 리다이렉트가 들어가면 `The health check command field format is invalid.` 에러가 납니다. `sh -c "..."` 형태도 마찬가지이므로 특수문자 없는 단일 명령만 사용합니다.
- 입력하기 전에 컨테이너 터미널에서 `명령; echo $?`로 종료 코드가 0인지 확인합니다. `pgrep: not found`가 나오면 이미지에 procps가 없는 것입니다.
- `php artisan --version`은 프레임워크 부팅만 확인하므로 장애를 잡지 못합니다.

헬스체크가 일부러 보지 않는 항목도 있습니다. Redis 장애는 Sentry가 알려 주고, Horizon의 paused 상태는 운영자가 의도해서 거는 것이므로 실패로 처리하지 않습니다.

## 6. 볼륨

`public` 디스크를 사용한다면 web에 `/var/www/html/storage/app/public` 영속 볼륨을 마운트합니다. 컨테이너 파일시스템은 재배포하면 초기화됩니다. worker가 이 경로의 파일을 만들거나 읽는다면 같은 볼륨을 worker에도 마운트해야 합니다.

## 마치며

![와이파이 노트](https://wifinote.net/assets/seo/og.png)

코드는 Dockerfile과 entrypoint.sh 두 개로 끝나고, 나머지는 Coolify에서 설정합니다. 헬스체크는 프로세스가 살아 있는지만 확인하고, 장애 감지는 Sentry에 맡기고 있습니다.

살짝 광고를 하자면 [와이파이 노트](https://wifinote.net/)는 이렇게 운영됩니다.
