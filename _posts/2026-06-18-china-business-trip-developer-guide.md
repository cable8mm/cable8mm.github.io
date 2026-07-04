---
layout: single
title: "개발자를 위한 중국 출장 가이드: 만리방화벽을 뚫는 필수 개발 환경 설정"
date: 2026-06-18 16:00:00 +0900
categories: development
tags: 중국출장, 개발환경, IDE, VPN, 개발자, 만리방화벽
author: Samgu Lee
header:
  og_image: /assets/images/china-business-trip-for-developer.png
---

개발자나 스타트업 관계자에게 중국 출장은 생각보다 거대한 도전입니다. 현지에 도착해 노트북을 켜는 순간, 구글, 슬랙(Slack) 등은 차단되며, GitHub, npm, Docker Hub는 느리거나 불안정해지는 경우가 많습니다.

![개발자를 위한 중국 출장 가이드](/assets/images/china-business-trip-for-developer.png)

중국 정부의 강력한 인터넷 차단 시스템인 **만리방화벽(Great Firewall, GFW)** 때문인데요. 현지에서도 평소처럼 막힘없이 키보드를 두드리기 위해 **출국 전 반드시 설정해야 할 필수 개발 환경과 네트워크 설정**을 정리했습니다.

## 0. 로밍 회선 하나는 반드시 준비하기

VPN이 모두 막히거나 설정이 꼬였을 때를 대비해, 한국 통신사의 데이터 로밍이나 중국 외 지역 경유형 eSIM을 준비해 두는 것이 좋습니다.

많은 경우 로밍 회선은 만리방화벽의 영향을 덜 받기 때문에 긴급 상황에서 GitHub, Slack, Google Workspace 등에 접속할 수 있는 최후의 백업 수단이 됩니다.

## 1. 네트워크의 핵심: 중국 대응 VPN 설정

중국에서 일반적인 OpenVPN, WireGuard 연결은 DPI에 의해 불안정하거나 차단될 수 있습니다. 따라서 일반 유료 VPN을 그냥 켜는 것만으로는 부족합니다.

- **출국 전 결제 및 설치 필수:** 중국에 도착하면 VPN 공식 홈페이지와 앱스토어 다운로드 주소 자체가 차단됩니다. 반드시 한국에서 메인과 백업용(최소 2개 추천) VPN을 설치하고 로그인까지 끝내두세요.
- **난독화(Obfuscation) 기능 활성화:** VPN 서비스가 제공하는 난독화 서버나 중국 전용 서버를 사용합니다. ExpressVPN, Astrill 등 일부 서비스는 자체 우회 기술을 제공하며 중국에서 상대적으로 안정적인 편입니다.
- **라우팅 분할(Split Tunneling) 활용:** 모든 트래픽을 VPN으로 보내면 속도가 느려집니다. GitHub나 개발 관련 툴만 VPN을 타게 하고, 중국 현지 인프라나 바이두 등은 바이패스하도록 설정하면 쾌적합니다.

## 2. 패키지 매니저 및 도커(Docker) 미러 서버 변경

VPN이 가끔 불안정하거나 끊길 때를 대비해, 패키지 다운로드 속도가 기어가지 않도록 환경 설정 파일(`rc` 파일 등)에 미리 글로벌/중국 로컬 미러 서버를 등록해 두는 것이 좋습니다.

### NPM / Yarn (Node.js)

중국 내에서 가장 빠른 타오바오(Taobao) 미러 서버로 임시 변경해 둡니다.

```bash
# NPM 미러 변경
npm config set registry https://registry.npmmirror.com

# Yarn 미러 변경(Yarn 버전에 따라 설정 방식이 다를 수 있음)
yarn config set registry https://registry.npmmirror.com
```

### Docker Hub

공용 Docker Hub 미러 대부분이 중단되었기 때문에, VPN/프록시를 통한 직접 접근이나 사설 레지스트리 사용을 준비하는 것이 더 현실적입니다.

## 3. IDE 및 깃(Git) 프록시(Proxy) 강제 지정

IDE(IntelliJ, VS Code 등) 내부에서 플러그인을 업데이트하거나, 터미널에서 `git clone`을 받을 때 VPN이 켜져 있어도 split tunnel 설정, TUN 모드 여부, 로컬 프록시 방식 등에 따라 달라집니다. 로컬 프록시 방식 VPN을 사용하는 경우에는 Git이나 IDE가 프록시를 사용하지 않아 우회가 되지 않을 수 있습니다.

### Git 글로벌 프록시 설정 (로컬 VPN 포트 기준)

유료 VPN들이 로컬에 열어두는 프록시 포트(보통 고유 설정에서 확인 가능, 예: 1080 또는 7890 등)를 Git에 강제로 지정합니다.

```bash
# HTTP/HTTPS 프록시 적용
git config --global http.proxy http://127.0.0.1:포트번호
git config --global https.proxy http://127.0.0.1:포트번호

# 출장 복귀 후 해제할 때
git config --global --unset http.proxy
git config --global --unset https.proxy
```

### IDE 내부 Proxy 설정

- **IntelliJ / WebStorm:** `Settings -> Appearance & Behavior -> System Settings -> HTTP Proxy` 이동 후 `Manual proxy configuration`에서 로컬 VPN 호스트와 포트를 입력해 둡니다.
- **VS Code:** 설정에서 `Http: Proxy` 항목에 로컬 프록시 주소(예: `http://127.0.0.1:7890`)를 지정하면 Copilot 등의 확장 프로그램이 보다 안정적으로 동작합니다.

## 4. 2차 인증(MFA) 수단 오프라인 백업

의외로 많은 개발자가 놓쳐서 멘붕이 오는 지점입니다. GitHub나 사내 시스템 로그인 시 2중 인증 등을 사용하실 텐데요.

- 중국에서 유심을 갈아끼우거나 로밍 처리를 하다가 기기 인증이 풀리는 경우가 있습니다.
- 만약 SMS 인증으로만 2차 인증을 해두었다면, 중국 현지에서 한국 문자가 제때 수신되지 않아 아예 계정이 잠길 수 있습니다.
- **대책:** 출국 전, GitHub, AWS, Google Workspace, 사내 SSO 등의 MFA 복구 코드를 미리 백업해 두세요.

## 🚀 출장 출발 전 최종 체크리스트

- [ ] 노트북 및 스마트폰에 유료 VPN 2개 이상 설치 완료 (난독화 서버 구동 확인)
- [ ] 해외 로밍 또는 중국 외 지역(홍콩·대만 등) 경유형 데이터 eSIM 준비 완료
- [ ] GitHub, AWS, 사내 인프라 계정의 '오프라인 복구 코드' 백업 완료
- [ ] 프로젝트 의존성 설치 및 초기 빌드가 정상 동작하는지 한국에서 미리 검증
- [ ] GitHub Copilot, Claude Code, Cursor 등의 AI 개발 도구가 VPN 환경에서 정상 동작하는지 사전 확인

만리방화벽은 생각보다 촘촘하지만, 사전 준비를 잘 해두면 대부분의 개발 업무를 큰 문제 없이 이어갈 수 있습니다. 미리 설정하셔서 현지에서 당황하는 일 없으시길 바랍니다!
