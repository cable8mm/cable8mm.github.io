---
title: "Synology NAS에서 VS Code Remote-SSH가 안 될 때: Docker devbox 컨테이너로 해결하기"
excerpt: "DS718+(DSM 7.1.1)에서 Remote-SSH가 prerequisites 에러로 막히는 원인은 glibc 2.26입니다. NAS 본체는 건드리지 않고 Ubuntu 22.04 devbox 컨테이너로 우회하는 과정과, 실제로 겪은 삽질 6가지를 정리했습니다."
date: 2026-10-22 17:20:00 +0900
categories: development
tags: synology, nas, vscode, remote-ssh, docker, ssh, glibc
author: Samgu Lee
header:
  og_image: /assets/images/remote-ssh-extension-for-vscode.png
---

Synology NAS에 파일만 두기에는 아깝습니다. 상시 켜져 있고, 디스크도 넉넉하고, Docker도 돌아가니까 개발 서버로 쓰고 싶어지죠. 그래서 VS Code의 Remote-SSH 확장을 설치하고 NAS에 접속해 봤습니다.

![VSCode Remote-SSH](/assets/images/remote-ssh-extension-for-vscode.png)

그런데 이런 에러가 나옵니다.

```shell
The remote host does not meet the prerequisites for running VS Code Server
```

이 글은 이 에러의 원인을 확인하고, NAS 본체를 건드리지 않고 해결한 과정을 정리한 것입니다. 중간에 겪은 시행착오도 그대로 적었습니다.

## 1. 원인: glibc가 너무 낮습니다

최신 VS Code Server는 glibc 2.28 이상을 요구합니다. 제 환경은 이렇습니다.

- Synology DS718+ (apollolake, x86_64)
- DSM 7.1.1
- 로컬은 macOS, VS Code + Remote-SSH

NAS에는 `ldd`가 없어서 라이브러리를 직접 실행해 버전을 확인했습니다.

```bash
cat /etc/VERSION      # productversion="7.1.1"
/lib/libc.so.6        # GNU C Library ... version 2.26
```

glibc 2.26이니 접속이 안 되는 게 당연했습니다.

DSM 7.2로 올리면 해결될 수도 있겠지만, 올린 뒤에 glibc가 충분히 오르는지는 확인하지 못했습니다. 게다가 DSM 업데이트는 되돌리기 어렵고 설치된 패키지 호환성 문제도 생길 수 있습니다. 그래서 OS는 그대로 두고 컨테이너로 우회하는 방법을 선택했습니다.

## 2. 구조: 편집은 컨테이너, 실행은 NAS 호스트

NAS에 Ubuntu 22.04 컨테이너(`devbox`)를 띄우고, VS Code는 이 컨테이너에 SSH로 접속합니다.

포트는 2222를 씁니다. NAS 본체의 SSH가 이미 22번을 사용하고 있기 때문입니다. 22번은 NAS 본체용, 2222번은 개발용으로 자연스럽게 분리됩니다.

여기서 하나 주의할 점이 있습니다. devbox 컨테이너 안에는 Docker가 없습니다. 그래서 `docker compose` 같은 명령은 컨테이너 안이 아니라 **NAS 호스트**(22번 포트 SSH)에서 실행해야 합니다. 이걸 처음에 헷갈려서 `docker: command not found`를 한 번 봤습니다.

## 3. devbox 컨테이너 만들기

작업 폴더와, 컨테이너에 마운트할 프로젝트 폴더를 만듭니다. 마운트할 호스트 폴더는 미리 만들어 둬야 합니다. 없으면 컨테이너가 시작되지 않습니다.

```bash
mkdir -p /volume1/docker/devbox
sudo mkdir -p /volume1/docker/projects
sudo chown -R 1000:1000 /volume1/docker/projects
cd /volume1/docker/devbox
```

`chown`은 컨테이너의 `dev` 계정(uid 1000)이 이 폴더에 쓸 수 있게 하려는 것입니다. 뒤에서 이걸 빼먹어서 겪은 문제를 다시 다룹니다.

`Dockerfile`입니다.

```dockerfile
FROM ubuntu:22.04

ENV DEBIAN_FRONTEND=noninteractive
RUN apt-get update && apt-get install -y \
    openssh-server sudo git curl wget ca-certificates \
    build-essential \
    && rm -rf /var/lib/apt/lists/* \
    && mkdir -p /var/run/sshd

RUN useradd -m -s /bin/bash -G sudo dev \
    && echo "dev:<임시비밀번호>" | chpasswd

RUN sed -i 's/#PasswordAuthentication yes/PasswordAuthentication yes/' /etc/ssh/sshd_config

EXPOSE 22
CMD ["/usr/sbin/sshd", "-D"]
```

`docker-compose.yml`입니다.

```yaml
services:
  devbox:
    build: .
    container_name: devbox
    restart: unless-stopped
    ports:
      - "2222:22"
    volumes:
      - /volume1/docker/projects:/home/dev/projects
```

NAS 호스트에서 빌드하고 실행합니다.

```bash
sudo docker compose up -d --build
```

## 4. 로컬 SSH 설정과 접속 테스트

로컬 `~/.ssh/config`에 호스트를 등록합니다.

```
Host devbox
    HostName OrangeNAS
    Port 2222
    User dev
```

VS Code는 접속 실패 로그가 잘 남지 않습니다. 처음에는 터미널에서 먼저 붙어 보는 것이 정확합니다.

```bash
ssh -v -p 2222 dev@OrangeNAS
```

`-v`를 붙이면 인증 과정이 전부 보여서 어디서 막히는지 알 수 있습니다.

## 5. 겪은 문제 6가지

실제로 거의 모든 단계에서 한 번씩 막혔습니다. 증상별로 정리합니다.

| 증상                                                            | 원인                                                                   | 해결                                                        |
| --------------------------------------------------------------- | ---------------------------------------------------------------------- | ----------------------------------------------------------- |
| `Connection refused`                                            | 컨테이너가 `Created` 상태로 시작되지 않음                              | `sudo docker ps -a`로 상태 확인 후 `docker start`           |
| `Bind mount failed: '/volume1/docker/projects' does not exists` | 마운트할 호스트 폴더가 없음                                            | 폴더를 먼저 `mkdir`                                         |
| 비밀번호가 계속 `Permission denied`                             | Dockerfile의 `chpasswd`가 반영되지 않은 것으로 보임                    | `sudo docker exec -it devbox passwd dev`로 직접 설정        |
| VS Code에서 `/home/dev/projects`가 안 보임                      | compose의 마운트 목적지가 `/home/cable8mm/projects`로 잘못 잡혀 있었음 | `docker inspect`로 확인 후 compose 수정, `--force-recreate` |
| `EACCES: permission denied, mkdir`                              | `sudo mkdir`로 만든 폴더의 소유자가 root                               | `sudo chown -R 1000:1000 /volume1/docker/projects`          |
| 컨테이너 안에서 `docker: command not found`                     | docker 명령을 컨테이너 안에서 실행함                                   | NAS 호스트에서 실행                                         |

### Created 상태에서 멈춘 컨테이너

`Connection refused`는 "NAS까지는 갔는데 그 포트를 받는 프로세스가 없다"는 뜻입니다. 방화벽이 막았다면 보통 응답 없이 timeout이 납니다. 그래서 방화벽보다 컨테이너 상태부터 확인했고, `Created`에서 멈춰 있는 것을 발견했습니다.

```bash
sudo docker ps -a
sudo docker start devbox
# Error response from daemon: Bind mount failed: ... does not exists
```

`docker start`를 직접 해 보면 이렇게 진짜 이유가 에러 메시지로 나옵니다. 마운트할 폴더가 없었던 것이었습니다.

### 마운트 경로가 달랐던 문제

VS Code에서 폴더를 열려는데 `/home/dev/projects`가 없었습니다. 마운트 정보를 직접 확인했습니다.

```bash
sudo docker inspect devbox --format '{{json .Mounts}}'
```

목적지(`Destination`)가 `/home/cable8mm/projects`로 되어 있었습니다. compose의 경로가 계정 이름으로 잘못 들어가 있었던 것입니다. 이름만 다를 뿐 동작은 하지만, 세팅을 깔끔하게 유지하고 싶어서 `/home/dev/projects`로 고치고 컨테이너를 재생성했습니다.

```bash
sudo docker compose up -d --force-recreate
```

주의할 점은 재생성하면 컨테이너 안에서 바꾼 비밀번호와 등록한 SSH 키가 초기화된다는 것입니다. 다음 섹션이 그 이야기입니다.

## 6. SSH 키 인증으로 전환하기

VS Code가 접속할 때마다 비밀번호를 묻는 것은 번거롭습니다. 키 인증으로 바꿉니다.

```bash
ls ~/.ssh/id_ed25519.pub || ssh-keygen -t ed25519
ssh-copy-id -i ~/.ssh/id_ed25519.pub -p 2222 dev@OrangeNAS
```

비밀번호 없이 들어가지는지 확인합니다.

```bash
ssh -o PasswordAuthentication=no -p 2222 dev@OrangeNAS
```

`Permission denied (publickey)`가 나오면 키 등록이 안 된 것입니다. 이 확인이 끝나기 전에는 비밀번호 로그인을 끄면 안 됩니다. 로컬 `~/.ssh/config`에는 키 설정도 추가합니다.

```
Host devbox
    HostName OrangeNAS
    Port 2222
    User dev
    IdentityFile ~/.ssh/id_ed25519
    AddKeysToAgent yes
    UseKeychain yes
```

### 재생성하면 키가 사라집니다

`/home/dev/.ssh`는 컨테이너 내부 파일시스템이라, `--force-recreate`나 `--build`로 컨테이너를 다시 만들면 `authorized_keys`가 사라집니다. 재생성해도 유지하려면 `.ssh` 폴더를 호스트에 두고 볼륨으로 붙였습니다.

```yaml
volumes:
  - /volume1/docker/projects:/home/dev/projects
  - /volume1/docker/devbox/ssh:/home/dev/.ssh
```

```bash
sudo mkdir -p /volume1/docker/devbox/ssh
sudo chown -R 1000:1000 /volume1/docker/devbox/ssh
sudo chmod 700 /volume1/docker/devbox/ssh
```

컨테이너가 새로 만들어지면 호스트 키도 바뀌어서 로컬에서 경고가 뜹니다. 이때는 아래 명령으로 기존 항목을 지웁니다.

```bash
ssh-keygen -R "[OrangeNAS]:2222"
```

### 비밀번호 로그인 끄기 (선택)

키 로그인이 확실히 되는 것을 확인한 뒤에만 합니다. Dockerfile에 아래 줄을 넣으면 영구 적용됩니다.

```dockerfile
RUN sed -i 's/^#\?PasswordAuthentication.*/PasswordAuthentication no/' /etc/ssh/sshd_config
```

키가 유지되는 구조(`.ssh` 볼륨)를 먼저 갖춰 두지 않으면, 재생성한 뒤에 비밀번호도 키도 없어서 잠길 수 있습니다. 그때는 NAS 호스트에서 `sudo docker exec -it devbox bash`로 들어가 복구하면 됩니다.

## 7. 경로 정리: 같은 폴더, 다른 이름

이 구성에서 제일 헷갈린 부분은 같은 폴더가 보는 위치에 따라 경로가 달라진다는 점입니다.

| 위치                      | 경로                                         |
| ------------------------- | -------------------------------------------- |
| devbox 컨테이너 (VS Code) | `/home/dev/projects/...`                     |
| NAS 호스트 (docker 실행)  | `/volume1/docker/projects/...`               |
| `.env`의 bind mount 경로  | 호스트 경로 (`/volume1/docker/projects/...`) |

bind mount는 컨테이너 안이 아니라 NAS 호스트의 Docker 데몬이 해석합니다. 그래서 `.env`에는 `/home/dev/...`가 아니라 반드시 호스트 경로를 적어야 합니다.

## 8. 적용 사례: data-mirror(가칭) 설치

![ssh 접속 개발환경](/assets/images/remote-workspace.png)

이렇게 만든 환경에 제가 운용할 데이터 미러 저장소를 설치했습니다. 편집은 devbox에서, `docker compose` 실행은 NAS 호스트에서 합니다.

설치 폴더를 처음엔 `/volume1/data-mirror`로 했으나, 세팅 후에는 `/volume1/docker/projects/data-mirror`로 바꿨습니다.

```bash
# devbox 안에서
mkdir -p ~/projects/data-mirror/data
```

```dotenv
# .env
OUTPUT_DIR=/volume1/docker/projects/data-mirror/data
```

```bash
# NAS 호스트에서
cd /volume1/docker/projects/data-mirror
sudo ./deploy.sh    # data-mirror의 배포 설치 스크립트
```

수집 데이터가 수만 개 파일로 늘어나므로 VS Code가 감시하지 않도록 제외합니다.

```json
{
  "files.watcherExclude": { "**/data-mirror/data/**": true },
  "search.exclude": { "**/data-mirror/data/**": true }
}
```

- `data/` 폴더를 DSM 인덱싱이나 File Station으로 열지 않습니다. `@eaDir` 같은 보조 파일이 생기면 `verify`가 실패합니다.
- data-mirror 컨테이너는 root로 동작해서 `data/` 안의 파일이 root 소유로 만들어집니다. `dev` 계정으로는 읽기만 가능합니다.

## 마치며

정리하면 이렇습니다.

1. glibc가 2.28보다 낮으면 최신 VS Code Server는 붙지 않습니다. `/lib/libc.so.6`을 직접 실행하면 버전을 알 수 있습니다.
2. NAS 본체는 두고, Ubuntu 컨테이너를 개발 서버로 씁니다. 편집은 컨테이너, `docker` 명령은 NAS 호스트입니다.
3. 막히면 추측하지 말고 `docker ps -a`, `docker start`, `docker inspect`로 실제 상태를 봅니다. 이번에도 원인은 전부 에러 메시지와 상태 출력에 있었습니다.
4. 재생성하면 컨테이너 안의 비밀번호와 SSH 키가 사라지므로, 지속해야 하는 것은 볼륨으로 뺍니다.

이 글은 제가 나중에 다시 보려고 정리한 기록이기도 합니다. 같은 구성을 시도하는 분께 도움이 되면 좋겠습니다.
