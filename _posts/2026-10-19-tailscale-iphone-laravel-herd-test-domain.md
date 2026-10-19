---
title: "Tailscale로 iPhone에서 로컬 개발 서버의 .test 도메인 접속하기"
date: 2026-10-19 20:30:00 +0900
excerpt: "Mac에서 Laravel Herd, Valet, Docker 등으로 띄운 .test 도메인을 Tailscale로 iPhone에서도 엽니다. dnsmasq와 Split DNS, tailscale serve를 설정하고, exit node 사용 시 '서버를 찾을 수 없음'이 뜨는 문제를 Use with exit node 옵션으로 해결합니다."
categories: development
tags: tailscale, laravel-herd, dnsmasq, split-dNS, iphone, macos
author: Samgu Lee
header:
  og_image: /assets/images/wifinote-dot-test.png
---

Mac에서 개발하다 보면 `http://localhost:5000`으로 개발을 하기도 하지만, 인증 권한 문제로 `https://wifinote.test` 같은 로컬 도메인으로 사이트를 띄우게 됩니다.

![wifinote.test](/assets/images/wifinote-dot-test.png)

그리고 E2E 테스트에서는 ngrok 와 같은 프로그램을 써서 공용 접속 도메인을 생성해서 모바일 폰에서 띄우기도 하죠. 스테이지 서버에 띄워서 테스트 하기도 합니다.

AI로 개발을 하면 테스트에 대한 이슈가 상대적으로 커지고 이 부분이 너무 번거로웠습니다. 그래서, Tailscale을 세팅해서 제 폰과 집의 컴퓨터 NAS 등이 private network로 묶여 있는 상황이라, 내 폰에서 `https://wifinote.test`로 접속하면 폰에서 내 개발머신으로 접속하면 참 편하겠다 싶겠다는 생각을 했습니다.

이미 전 Tailscale을 집과 모바일 그리고 개발 서버까지 연동시켰기 때문에 폰의 DNS만 설치해서 Tailscale 과 연동시키면 될 줄 알았습니다.

하지만, 세상에 쉬운 일은 없더군요.

Claude 그 다음에 Claude Code 그 다음에 ChatGPT 그 다음에 Codex 까지 토론과 작업, 토론과 작업을 거의 10시간을 했지만 성공하지 못했습니다. 이유는 바로 Tailscale 에서 저의 개발머신에 만든 dns 서버와 연동이 되지 않아서 입니다. 이 상황에서 제가 사랑하는 모든 AI는 오답을 냈습니다.

결국 성공했고, 이 글은 여러분들이 저와 같은 그 과정을 겪지 않아도 되는 한가지 방법입일 것입니다.

한 번만 설정해 두면 iPhone에서 `wifinote.test`를 입력했을 때 Mac에서 돌아가는 화면이 그대로 열립니다. 어떤 도메인도 `.test` 도메인이라면 가능합니다.

![repl.net.test on mobile](/assets/images/repl-dot-net-dot-test-on-mobile.jpeg)

![wifinote.test on mobile](/assets/images/wifinote-dot-test-on-mobile.jpeg)
개발머신에서 개발중인 웹사이트를 아이폰 사파리에서 띄운 모습

이 글은 [Laravel Herd](https://www.palgle.com/2024/03/01/fix-error-to-install-xdebug-for-herd/)를 쓰는 Mac을 기준으로 설명하지만, 방법 자체는 특정 도구에 묶여 있지 않습니다. Valet, Docker, Caddy, nginx처럼 `.test` 도메인으로 로컬 서버를 띄우는 환경이라면 같은 구조로 동작합니다. Herd에 한정된 부분은 본문에서 따로 표시해 두었습니다.

> **이런 증상이라면 이 글이 도움이 됩니다.**
> Split DNS까지 설정했는데 iPhone Safari에서 "서버를 찾을 수 없음"이 뜬다면, 특히 iPhone이 exit node를 사용 중이라면 [8장의 Use with exit node](#8-가장-중요한-설정-use-with-exit-node)를 확인하세요. 이번 구성에서 DNS 문제를 실제로 해결한 설정입니다.

핵심은 네 가지입니다.

- **dnsmasq:** `.test` 도메인을 Mac의 Tailscale IP로 연결합니다.
- **tailscale serve:** 로컬 서버가 `127.0.0.1`에서만 연결을 받는 경우, Tailscale IP로 들어온 요청을 localhost로 넘겨 줍니다.
- **Tailscale Split DNS:** `.test` 도메인의 DNS 질의만 위 dnsmasq로 보냅니다.
- **Use with exit node:** exit node를 쓰더라도 이 DNS 서버를 계속 사용하게 합니다.

## 1. 전체 구성 이해하기

이번 구성에서 Mac은 개발 서버이자 DNS 서버 역할을 합니다.

| 구성 요소                                 | 역할                                                          |
| ----------------------------------------- | ------------------------------------------------------------- |
| 로컬 개발 서버 (이 글에서는 Laravel Herd) | `.test` 도메인으로 프로젝트를 실행합니다.                     |
| Tailscale                                 | iPhone과 Mac을 사설 네트워크로 연결합니다.                    |
| dnsmasq                                   | `.test` 도메인을 Mac의 Tailscale IP로 변환합니다.             |
| tailscale serve                           | Tailscale IP의 80, 443번 포트를 Mac의 localhost로 전달합니다. |
| Split DNS                                 | `.test` 질의만 dnsmasq로 전달합니다.                          |
| Use with exit node                        | exit node 사용 중에도 해당 DNS 서버를 사용합니다.             |

Mac의 Tailscale IP가 `100.118.192.120`이라면 요청은 이렇게 흘러갑니다.

```text
iPhone: wifinote.test 조회
  → (Tailscale Split DNS) Mac의 dnsmasq
  → 100.118.192.120 응답
iPhone: 100.118.192.120:443 접속
  → (tailscale serve) Mac의 127.0.0.1:443
  → 개발 서버가 Host 헤더(wifinote.test)를 보고 해당 프로젝트 응답
```

모든 `.test` 도메인이 같은 IP로 연결되고, 어느 프로젝트를 보여줄지는 개발 서버가 요청의 도메인 이름으로 결정합니다.

> **TLD 선택에 대한 참고**
> 이 방식은 DNS 응답을 직접 정하는 것이라 이론적으로 어떤 도메인에도 쓸 수 있습니다. 다만 `.local`은 mDNS와 충돌할 수 있고, `.dev`는 브라우저가 https를 강제합니다. 로컬 개발용으로 예약된 `.test`를 쓰는 것이 가장 무난합니다.

## 2. Mac의 Tailscale IP 확인하기

Mac 터미널에서 실행합니다.

```bash
tailscale ip -4
```

출력된 주소를 기록해 둡니다. 이 글에서는 `100.118.192.120`을 사용하며, 이후 설정의 IP와 도메인은 자신의 값으로 바꿔야 합니다. iPhone에도 Tailscale을 설치하고 같은 tailnet에 연결해 두세요.

> `tailscale` 명령을 찾을 수 없다고 나오면 앱 번들 안의 실행 파일을 직접 쓸 수 있습니다.
> `/Applications/Tailscale.app/Contents/MacOS/Tailscale ip -4`

## 3. dnsmasq 설치하기

Homebrew로 설치합니다.

```bash
brew install dnsmasq
```

이미 `.test`를 처리하는 DNS 서버가 돌고 있을 수 있습니다. 먼저 53번 포트를 누가 쓰고 있는지 확인합니다.

```bash
sudo lsof -nP -iTCP:53 -iUDP:53
```

제 환경(Laravel Herd)에서는 Herd의 dnsmasq가 `127.0.0.1:53`에만 붙어 있었습니다.

```text
dnsmasq-a 50804 nobody  ... UDP 127.0.0.1:53
dnsmasq-a 50804 nobody  ... TCP 127.0.0.1:53 (LISTEN)
```

이렇게 `127.0.0.1`에만 붙어 있다면, 우리가 따로 띄울 dnsmasq를 Tailscale IP에만 바인딩해서 충돌 없이 함께 쓸 수 있습니다. 반대로 `*:53`처럼 모든 인터페이스를 잡고 있다면 두 번째 인스턴스가 "address already in use"로 뜨지 않으니, 기존 쪽 설정에 `listen-address=127.0.0.1`과 `bind-interfaces`를 추가해야 합니다.

어느 쪽이든 기존 DNS 설정은 건드리지 않고, 별도 설정 파일로 실행하는 쪽이 안전합니다.

## 4. Tailscale 전용 DNS 설정 만들기

설정 파일을 만듭니다. Intel Mac이라면 경로가 `/usr/local/etc/`이고, Apple Silicon Mac이면 `/opt/homebrew/etc/` 입니다.

```bash
nano /opt/homebrew/etc/dnsmasq-tailscale.conf
```

```ini
listen-address=100.118.192.120
bind-interfaces
no-resolv
no-hosts
address=/test/100.118.192.120
```

- `listen-address`: 지정한 Tailscale IP에서만 DNS 요청을 받습니다.
- `bind-interfaces`: 해당 인터페이스에만 바인딩해서 기존 dnsmasq와 충돌하지 않게 합니다.
- `no-resolv`: macOS의 DNS 서버 목록을 읽지 않습니다. `.test`만 처리하는 서버이므로 필요 없습니다.
- `no-hosts`: 시스템 hosts 파일을 읽지 않습니다.
- `address=/test/...`: `.test`로 끝나는 모든 도메인에 같은 IP를 응답합니다.

> 기존 환경이 `*.test`를 `127.0.0.1`로 응답하는 설정이라면, 그 응답을 iPhone이 받는 순간 iPhone은 자기 자신에게 접속해 버립니다. iPhone에게는 반드시 Mac의 Tailscale IP를 응답해야 합니다.

## 5. DNS 설정 검증하기

서비스를 띄우기 전에 설정 문법을 확인합니다.

```bash
/opt/homebrew/sbin/dnsmasq --test --conf-file=/opt/homebrew/etc/dnsmasq-tailscale.conf
```

정상이라면 `dnsmasq: syntax check OK.`가 출력됩니다.

그다음 포그라운드로 먼저 실행해 봅니다. 53번 포트라 `sudo`가 필요합니다.

```bash
sudo /opt/homebrew/sbin/dnsmasq --conf-file=/opt/homebrew/etc/dnsmasq-tailscale.conf --keep-in-foreground
```

다른 터미널에서 질의해 봅니다.

```bash
dig @100.118.192.120 wifinote.test A +short
```

```text
100.118.192.120
```

이 결과가 나오지 않는다면 Tailscale 관리 콘솔을 만지기 전에 dnsmasq와 설정 파일부터 확인해야 합니다. 확인이 끝났으면 `Ctrl+C`로 종료하고 다음 단계로 넘어갑니다.

## 6. dnsmasq를 macOS 서비스로 실행하기

재부팅 후에도 실행되도록 LaunchDaemon으로 등록합니다. 다음 경로에 파일을 만듭니다.

```text
/Library/LaunchDaemons/dev.tailscale-dnsmasq.plist
```

```xml
<?xml version="1.0" encoding="UTF-8"?>
<!DOCTYPE plist PUBLIC "-//Apple//DTD PLIST 1.0//EN"
  "http://www.apple.com/DTDs/PropertyList-1.0.dtd">
<plist version="1.0">
<dict>
    <key>Label</key>
    <string>dev.tailscale-dnsmasq</string>

    <key>ProgramArguments</key>
    <array>
        <string>/opt/homebrew/sbin/dnsmasq</string>
        <string>--keep-in-foreground</string>
        <string>--conf-file=/opt/homebrew/etc/dnsmasq-tailscale.conf</string>
    </array>

    <key>RunAtLoad</key>
    <true/>

    <key>KeepAlive</key>
    <true/>

    <key>StandardOutPath</key>
    <string>/tmp/tsdns.log</string>

    <key>StandardErrorPath</key>
    <string>/tmp/tsdns.log</string>
</dict>
</plist>
```

권한을 설정하고 등록합니다.

```bash
sudo chown root:wheel /Library/LaunchDaemons/dev.tailscale-dnsmasq.plist
sudo chmod 644 /Library/LaunchDaemons/dev.tailscale-dnsmasq.plist
sudo launchctl bootstrap system /Library/LaunchDaemons/dev.tailscale-dnsmasq.plist
```

이미 등록되어 있다면 재시작합니다.

```bash
sudo launchctl kickstart -k system/dev.tailscale-dnsmasq
```

부팅 직후 Tailscale이 아직 올라오지 않아 IP 바인딩에 실패할 수 있지만, `KeepAlive` 덕분에 재시도하다가 결국 실행됩니다.

## 7. 로컬 서버가 Tailscale IP에서 요청을 받게 하기

DNS가 맞아도 여기서 막히는 경우가 많습니다. 로컬 개발 서버가 `127.0.0.1`에서만 연결을 받고 있으면, Tailscale IP로 들어온 요청을 받아 줄 곳이 없습니다.

먼저 서버가 어디에 바인딩되어 있는지 확인합니다.

```bash
sudo lsof -nP -iTCP:80 -sTCP:LISTEN
```

필자의 환경(Laravel Herd)에서는 이렇게 보였습니다.

```text
nginx-arm 50805 root  ... TCP 127.0.0.1:80 (LISTEN)
```

- **`127.0.0.1:80`처럼 localhost에만 붙어 있다면** 아래의 `tailscale serve`가 필요합니다.
- **`*:80`처럼 모든 인터페이스에 열려 있다면** `serve` 없이도 될 수 있습니다. 먼저 `serve` 없이 아래 `curl`로 확인해 보세요. 이 경우의 동작은 환경마다 달라서 필자가 따로 검증하지는 않았습니다.

`tailscale serve`로 Tailscale IP의 80, 443번 포트를 localhost로 넘겨 줍니다.

```bash
tailscale serve --bg --tcp 80 tcp://127.0.0.1:80
tailscale serve --bg --tcp 443 tcp://127.0.0.1:443
tailscale serve status
```

```text
|-- tcp://100.118.192.120:443
|--> tcp://127.0.0.1:443
|-- tcp://100.118.192.120:80
|--> tcp://127.0.0.1:80
```

- TCP를 그대로 전달하기 때문에 Host 헤더(`wifinote.test`)가 유지되어, 개발 서버가 어느 사이트인지 알아봅니다.
- 설정은 Tailscale이 저장해서 재부팅 후에도 유지됩니다.
- 접근 범위는 tailnet 안으로 한정됩니다(`tailnet only`).
- 해제는 `tailscale serve reset`입니다. 다른 용도의 serve 설정도 함께 지워지니 주의하세요.

### 80, 443이 아닌 포트를 쓰는 경우

`php artisan serve`(8000)나 Vite(5173)처럼 도메인이 아니라 포트로 접근하는 서버라면, 같은 방식으로 해당 포트를 넘기면 됩니다.

```bash
tailscale serve --bg --tcp 8000 tcp://127.0.0.1:8000
```

이 경우 DNS 없이 `http://100.118.192.120:8000`으로 바로 열 수도 있습니다.

### 동작 확인

Mac에서 확인합니다. 서버가 http 요청을 https로 리다이렉트하는 설정이라면 301 응답이 오는데, 그 응답이 왔다면 정상입니다.

```bash
curl -I -H "Host: wifinote.test" http://100.118.192.120
```

## 8. 가장 중요한 설정: Use with exit node

여기까지 하고 Tailscale 관리 콘솔에서 Split DNS를 등록했는데도 iPhone에서 `.test`를 찾지 못한다면, 특히 iPhone이 exit node를 사용 중이라면 이 설정을 확인하세요.

Tailscale은 기본적으로 exit node를 사용하는 기기의 DNS 질의를 exit node 쪽으로 보냅니다. 이때 직접 추가한 커스텀 네임서버는 기본 동작에서 빠질 수 있고, 그러면 `.test` 질의가 dnsmasq에 닿지 않아 Safari에서 "서버를 찾을 수 없음"이 뜹니다.

Tailscale은 이를 위해 네임서버별로 **Use with exit node** 옵션을 제공합니다.

1. [Tailscale DNS 관리 화면](https://login.tailscale.com/admin/dns)을 엽니다.
2. **Nameservers**에서 `100.118.192.120` 항목을 찾습니다.
3. 해당 항목의 설정(편집 또는 점 세 개 메뉴)에서 **Use with exit node**를 켭니다.
4. 저장합니다.

콘솔 화면은 바뀔 수 있어서 메뉴 위치가 다르게 보일 수 있습니다. 옵션 이름으로 찾으면 됩니다.

이번 구성에서 접속 문제를 실제로 해결한 설정이 바로 이 옵션이었습니다.

## 9. Tailscale 관리 콘솔에서 Split DNS 설정하기

이제 dnsmasq를 Tailscale의 DNS 설정에 연결합니다. [Tailscale DNS 관리 화면](https://login.tailscale.com/admin/dns)에서 다음을 설정합니다.

1. **Nameservers**에서 **Add nameserver → Custom**을 선택합니다.
2. 주소에 Mac의 Tailscale IP `100.118.192.120`을 입력합니다.
3. **Restrict to domain**을 켜고 도메인에 `test`를 입력합니다. 앞에 점이나 `*`을 붙이지 않습니다.
4. 8장의 **Use with exit node**를 켭니다.
5. 저장합니다.

![Tailscale의 DNS 세팅화면](/assets/images/tailscale-setting-for-dns.png)

이것이 Tailscale에서 말하는 **Split DNS**입니다. 모든 인터넷 도메인을 Mac의 dnsmasq로 보내는 것이 아니라, `.test` 질의만 보냅니다. Split DNS 서버는 포트를 지정할 수 없어서 dnsmasq가 반드시 53번 포트에서 실행되어야 합니다.

마지막으로 iPhone의 Tailscale 앱에서 **Use Tailscale DNS settings**가 켜져 있는지 확인합니다.

## 10. iPhone에서 접속 확인하기

iPhone의 Tailscale 연결 스위치가 켜져 있는지 확인한 뒤 Safari에서 엽니다.

```text
https://wifinote.test
```

같은 Mac의 다른 프로젝트도 같은 방식으로 열립니다.

```text
https://project-a.test
https://project-b.test
```

### HTTPS 인증서 경고

개발 도구가 로컬 인증서(Herd, Valet, mkcert 등)로 https를 제공하는 경우, iPhone은 그 인증서를 만든 로컬 CA를 신뢰하지 않기 때문에 처음 접속하면 Safari에 인증서 경고가 나옵니다. Herd에서 secure로 설정한 사이트는 `http://`로 접속해도 `https://`로 리다이렉트되어 이 경고를 만나게 됩니다.

이 글에서는 인증서를 설치하지 않고, 경고 화면에서 **"이 웹 사이트 방문"**을 눌러 넘어갔습니다. 개발 중에 화면을 확인하는 용도로는 충분했습니다.

다만 한계가 있습니다.

- 시간이 지나거나 Safari를 다시 열면 경고가 다시 나올 수 있습니다.
- 경고를 넘긴 상태에서는 서비스 워커처럼 안전한 연결이 필요한 기능이 제한될 수 있습니다.
- 앱 안의 웹뷰처럼 경고를 넘길 수 없는 환경에서는 접속이 안 될 수 있습니다.

이런 제한이 거슬린다면 개발 도구의 루트 CA 인증서를 iPhone에 설치하고, **설정 → 일반 → 정보 → 인증서 신뢰 설정**에서 해당 인증서를 켜면 경고 없이 접속할 수 있습니다. 경고 없이 http로만 확인하고 싶다면 해당 사이트의 secure 설정을 해제하는 방법도 있습니다.

![아이폰으로 인증서 설치하기](/assets/images/ca-transfer-from-mac-to-phone.jpeg)

DNS가 정상인 것과 HTTPS 인증서가 신뢰되는 것은 별개의 문제라는 점만 기억하면 됩니다.

## 11. 문제가 발생했을 때 확인할 항목

| 증상                                                               | 확인할 항목                                                                                                                                                                                                          |
| ------------------------------------------------------------------ | -------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------- |
| Mac에서도 도메인이 해석되지 않습니다.                              | 기존 DNS 설정(Herd, Valet 등)과 dnsmasq 설정을 확인합니다.                                                                                                                                                           |
| `dig @IP wifinote.test`의 결과가 예상 IP와 다릅니다.               | `listen-address`, `address=/test/...` 설정과 서비스 상태(`/tmp/tsdns.log`)를 확인합니다.                                                                                                                             |
| iPhone에서 "서버를 찾을 수 없음"이 뜹니다.                         | 콘솔의 Split DNS 등록(`test`, 앞에 점 없음), iPhone의 "Use Tailscale DNS settings", exit node 사용 시 **Use with exit node**를 확인합니다. iCloud 비공개 릴레이도 꺼 두고 테스트하면 변수를 줄일 수 있습니다.        |
| `http://100.118.192.120`(IP 직접)은 열리는데 도메인만 안 열립니다. | 연결은 정상이고 DNS 문제입니다. Split DNS와 Use with exit node를 확인합니다.                                                                                                                                         |
| 도메인은 찾는데 접속이 타임아웃 됩니다.                            | 서버가 localhost에만 붙어 있는지 `lsof`로 확인하고, `tailscale serve status`에 해당 포트 설정이 있는지 봅니다. 7장이 빠졌을 가능성이 높습니다.                                                                       |
| 한동안 잘 되다가 갑자기 안 됩니다.                                 | Mac이 잠자기 상태면 DNS와 웹 서버가 함께 멈춥니다. 개발 중에는 `caffeinate -d`로 막을 수 있습니다.                                                                                                                   |
| 도메인은 열리지만 HTTPS 경고가 나옵니다.                           | DNS 문제가 아니라 인증서 신뢰 문제입니다. 10장의 HTTPS 인증서 경고를 참고합니다.                                                                                                                                     |
| Linux 서버(NAS 등)에서 `curl http://100.x.x.x`가 타임아웃 됩니다.  | 그 기기의 Tailscale이 userspace networking 모드면 일반 `curl`이 Tailscale을 타지 않습니다. `(printf 'HEAD / HTTP/1.0\r\nHost: wifinote.test\r\n\r\n'; sleep 2) \| tailscale nc 100.118.192.120 80`으로 테스트합니다. |

마지막 행은 필자가 실제로 겪은 함정입니다. Mac에서 NAS로는 연결되는데 NAS에서 Mac으로는 안 되는 것처럼 보여서 ACL과 방화벽을 한참 의심했지만, 테스트 방법이 잘못된 것이었습니다. 문제를 좁힐 때는 폰처럼 실제 VPN 인터페이스를 쓰는 기기에서 확인하는 것이 확실합니다.

## 부록: 명령어 하나로 자동화하기 (tsdns)

위 과정을 매번 기억하기 어려워서 한 번에 처리하는 스크립트를 만들었습니다. `~/bin/tsdns`로 저장하고 실행 권한을 줍니다.

```bash
mkdir -p ~/bin
chmod +x ~/bin/tsdns
```

`~/bin`이 PATH에 없다면 `.zshrc`에 `export PATH="$HOME/bin:$PATH"`를 추가합니다.

명령은 다섯 개입니다.

- `tsdns setup`: dnsmasq 설치, 설정 파일, LaunchDaemon, `tailscale serve`까지 한 번에 처리합니다.
- `tsdns test [도메인]`: DNS와 웹 서버가 응답하는지 확인합니다.
- `tsdns status`: 설정과 53번 포트, serve 상태를 보여 줍니다.
- `tsdns restart`: dnsmasq를 재시작합니다.
- `tsdns remove`: 모두 제거합니다.

환경변수로 동작을 바꿀 수 있습니다.

- `TSDNS_TLD`: 처리할 TLD입니다. 기본값은 `test`입니다.
- `TSDNS_PORTS`: serve로 넘길 포트 목록입니다. 기본값은 `"80 443"`이고, 예를 들어 `TSDNS_PORTS="8000" tsdns setup`처럼 바꿀 수 있습니다.

```bash
#!/usr/bin/env bash
# tsdns — 폰에서 로컬 개발 서버의 .test 도메인을 Tailscale로 열기 위한 DNS 헬퍼
# 사용법: tsdns setup | status | test [도메인] | restart | remove
# 환경변수: TSDNS_TLD (기본 test), TSDNS_PORTS (기본 "80 443")
set -euo pipefail

TLD="${TSDNS_TLD:-test}"
PORTS="${TSDNS_PORTS:-80 443}"
PREFIX="$(brew --prefix 2>/dev/null || echo /opt/homebrew)"
CONF="$PREFIX/etc/dnsmasq-tailscale.conf"
DNSMASQ="$PREFIX/sbin/dnsmasq"
LABEL="dev.tailscale-dnsmasq"
PLIST="/Library/LaunchDaemons/$LABEL.plist"
LOG="/tmp/tsdns.log"

ts() {
  if command -v tailscale >/dev/null 2>&1; then
    tailscale "$@"
  else
    /Applications/Tailscale.app/Contents/MacOS/Tailscale "$@"
  fi
}

get_ip() {
  local ip
  ip="$(ts ip -4 2>/dev/null | head -n1 || true)"
  if [[ -z "$ip" ]]; then
    echo "Tailscale IP를 못 가져왔어. Tailscale이 켜져 있는지 확인해." >&2
    exit 1
  fi
  echo "$ip"
}

cmd_setup() {
  local ip port
  ip="$(get_ip)"
  echo "→ Tailscale IP: $ip"

  if [[ ! -x "$DNSMASQ" ]]; then
    echo "→ dnsmasq 설치 중..."
    brew install dnsmasq
  fi

  echo "→ 설정 파일 작성: $CONF"
  cat > "$CONF" <<EOF
listen-address=$ip
bind-interfaces
no-resolv
no-hosts
address=/$TLD/$ip
EOF

  echo "→ LaunchDaemon 등록 (sudo 필요)"
  sudo tee "$PLIST" >/dev/null <<EOF
<?xml version="1.0" encoding="UTF-8"?>
<!DOCTYPE plist PUBLIC "-//Apple//DTD PLIST 1.0//EN" "http://www.apple.com/DTDs/PropertyList-1.0.dtd">
<plist version="1.0">
<dict>
  <key>Label</key><string>$LABEL</string>
  <key>ProgramArguments</key>
  <array>
    <string>$DNSMASQ</string>
    <string>--keep-in-foreground</string>
    <string>--conf-file=$CONF</string>
  </array>
  <key>RunAtLoad</key><true/>
  <key>KeepAlive</key><true/>
  <key>StandardErrorPath</key><string>$LOG</string>
  <key>StandardOutPath</key><string>$LOG</string>
</dict>
</plist>
EOF
  sudo chown root:wheel "$PLIST"
  sudo chmod 644 "$PLIST"
  sudo launchctl bootout system "$PLIST" 2>/dev/null || true
  sudo launchctl bootstrap system "$PLIST"

  for port in $PORTS; do
    echo "→ Tailscale serve: $port번을 localhost로 전달"
    ts serve --bg --tcp "$port" "tcp://127.0.0.1:$port"
  done

  sleep 1
  cmd_test "check.$TLD" || true

  cat <<EOF

남은 수동 작업 (처음 한 번만):
  Tailscale 관리 콘솔 → DNS → Nameservers → Add nameserver → Custom
  → $ip 입력 → "Restrict to domain" 켜고 "$TLD" 입력
  → exit node를 쓰는 기기가 있다면 "Use with exit node"도 켜기

그다음 폰에서 https://내사이트.$TLD 로 접속해 봐.
EOF
}

cmd_status() {
  local ip
  ip="$(get_ip)"
  echo "Tailscale IP : $ip"
  echo "설정 파일    : $([[ -f "$CONF" ]] && echo "있음 ($CONF)" || echo "없음")"
  echo "LaunchDaemon : $([[ -f "$PLIST" ]] && echo "있음" || echo "없음")"
  echo "--- 53번 포트 ---"
  sudo lsof -nP -iUDP:53 -iTCP:53 || true
  echo "--- tailscale serve ---"
  ts serve status || true
  if [[ -f "$CONF" ]] && ! grep -q "$ip" "$CONF"; then
    echo
    echo "⚠ Tailscale IP가 설정 파일과 달라졌어. 'tsdns setup'을 다시 실행해."
  fi
}

cmd_test() {
  local domain="${1:-check.$TLD}" ip result first_port
  read -r first_port _ <<< "$PORTS"
  ip="$(get_ip)"
  result="$(dig @"$ip" "$domain" +short +time=2 +tries=1 || true)"
  if [[ "$result" == "$ip" ]]; then
    echo "✓ DNS OK: $domain → $result"
  else
    echo "✗ DNS 응답 이상: '${result:-없음}' (기대값 $ip). 로그: $LOG"
    return 1
  fi
  # 어떤 HTTP 응답(301, 404 포함)이든 연결 자체가 되면 성공으로 본다
  if curl -s -o /dev/null -m 3 -H "Host: $domain" "http://$ip:$first_port"; then
    echo "✓ 웹서버 연결 OK: http://$ip:$first_port (Host: $domain)"
  else
    echo "✗ $ip:$first_port 에서 응답 없음. 서버가 켜져 있는지, 'tailscale serve status'에 해당 포트가 있는지 확인해."
  fi
}

cmd_restart() {
  sudo launchctl kickstart -k "system/$LABEL"
  echo "재시작 완료"
}

cmd_remove() {
  sudo launchctl bootout system "$PLIST" 2>/dev/null || true
  sudo rm -f "$PLIST"
  rm -f "$CONF"
  ts serve reset || true
  echo "제거 완료. Tailscale 콘솔의 Split DNS 항목은 직접 지워줘."
}

case "${1:-}" in
  setup)   cmd_setup ;;
  status)  cmd_status ;;
  test)    shift; cmd_test "$@" ;;
  restart) cmd_restart ;;
  remove)  cmd_remove ;;
  *)
    echo "사용법: tsdns {setup|status|test [도메인]|restart|remove}"
    exit 1
    ;;
esac
```

Tailscale 콘솔의 Split DNS 등록은 웹에서 해야 해서 스크립트로 할 수 없습니다. 이 한 번의 수동 작업만 남습니다. `tsdns remove`는 `tailscale serve reset`을 실행하므로, 다른 용도로 serve를 쓰고 있다면 해당 줄을 빼고 사용하세요.

## Laravel Herd로 Node 기반 프로젝트를 domain.test로 띄우기

전 Astro나 Next.JS, React 기반의 프로젝트도 `domain.test`로 띄워놓고 개발하는데요, 그 방법을 간단히 설명합니다.

이런 식으로 개발 서버를 띄웁니다.

```sh
❯ npm run dev -- --host 0.0.0.0
npm notice run replworks@0.0.1 dev
npm notice run astro dev --host 0.0.0.0
20:52:45 [vite] connected.
20:52:45 [types] Generated 0ms
20:52:46 [vite] connected.
20:52:46 [content] Syncing content
20:52:46 [content] Astro config changed
20:52:46 [content] Clearing content store
20:52:46 [content] Synced content
 astro  v7.3.5 ready in 512 ms
┃ Local    http://localhost:4321/
┃ Network  http://192.168.45.28:4321/
           http://100.118.192.120:4321/
20:52:46 watching for file changes...
20:54:10 Configuration file updated. Restarting...
20:54:10 [vite] connected.
20:54:10 [vite] connected.
20:54:10 [vite] server restarted.
```

그 후에 다른 터미널에서 프록시를 만듭니다.

```sh
❯ herd proxy repl.net.test http://127.0.0.1:4321
Herd will now proxy [http://repl.net.test] traffic to [http://127.0.0.1:4321].
Restarting Nginx...
```

https 로 개발을 한다면,

```sh
❯ herd proxy --secure repl.net.test http://127.0.0.1:4321
Herd will now proxy [https://repl.net.test] traffic to [http://127.0.0.1:4321].
Restarting Nginx...
```

이렇게 https 환경에서 localhost나 127.0.0.1 도메인을 쓰지 않고 개발을 할 수 있습니다. 어떤 언어 어떤 프레임워크에서도 가능합니다.

Vite에서 권한 에러가 생길 경우가 있는데요, 그 때는

```sh
    server: {
      host: '0.0.0.0',
      allowedHosts: ['repl.net.test'],
    },
```

이런 식으로 allowedHosts 에 도메인을 추가하시면 됩니다.

## 마무리

AI가 대부분의 일은 잘 처리하지만, 이렇게 일반적이지 않은 세팅은 사람과 마찬가지로 잘 헤매게 됩니다. 되는건 확실한데 어떻게 하는지는 모르겠다 혹은 중간에 뭐하나가 빠진 것 같다 할 때, AI만으로는 해결이 안되더군요.

이 글을 AI에게 보여 주면 알아서 잘 세팅해 줄 수 있을 것 같네요.
