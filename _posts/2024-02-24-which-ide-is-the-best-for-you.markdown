---
layout: single
title: "스프링 부트를 위한 최고의 IDE 선택하기"
date: 2024-02-24 14:25:00
categories: development
tags: spring ide
author: Samgu Lee
header:
  og_image: /assets/images/best_ide_for_spring_boot_for_you.jpg
---

스프링 부트의 공식 IDE는 다섯가지를 소개하고 있고, 주력으로 네가지를 제안합니다. 그 중 어떤 도구가 나에게 최고의 IDE일까요? 알아봅시다.

![스프링 부트 개발에서 사용할 수 있는 IDE 다섯가지]({{ page.header.og_image }})

스프링의 공식 홈페이지에서는 특정 IDE를 다루지는 않지만, 주로 소개하는 IDE는 아래 네가지 입니다.

- IntelliJ IDEA from JetBrains
- Visual Studio Code with Spring Boot Extension Pack from Microsoft
- Spring Tools 4 for Eclipse
- Spring Tools 4 for Theia

이 중 [Theia](https://theia-ide.org/) 는 점유율이 낮고, 공식문서에서도 제외되는 경우가 많기 때문에 앞의 세가지 IDE만을 다루겠습니다.

## IntelliJ IDEA from JetBrains

Java 관련 개발의 최고의 도구라고 할 수 있습니다. 기업용 도구인 [넷빈스(NetBeans)](https://netbeans.apache.org/front/main/index.html)가 있었지만, 넷빈스를 보유했던 썬 마이크로시스템즈(Sun microsystems)가 오라클에게 인수된 후 넷빈스는 2016년에 아파치에 기부되었고, 아파치 인큐베이터에서 관리되고 있습니다. 아파치는 최고의 백엔드 시스템을 론칭한 이력이 있으나, 컨슈머용이나 개발자용 UI 도구를 운영하기에는 다소 보수적인 면이 있습니다.

![IntelliJ 홈페이지 스크린샷](/assets/images/screenshot_intellij_ide.png)

반면 IntelliJ를 만들고 판매하는 JetBrains는 과거 [델파이가 누렸던 영광](https://www.embarcadero.com/products/delphi)을 재현하는데 성공하는 것으로 보이며, Apple에는 XCode, Microsoft에는 Visual Studio가 있었지만, 다른 나머지 기업들이 사용했던 Eclipse의 불편함을 각 개발 플랫폼 별로 제품으로 만들어 판매하고 있다는 점입니다.

지금까지 자바 개발 IDE에 있어서 최고의 툴은 단연 IntelliJ 라고 할 수 있습니다. 한가지 단점은 [개인이 사용하기에는 라이센스 비용이 있습니다](https://www.jetbrains.com/idea/buy/?section=personal&billing=yearly).

| IDE                                                                               | 1년 구독 금액(개인)    | 1년 구독 금액(기업) |
| --------------------------------------------------------------------------------- | ---------------------- | ------------------- |
| [IntelliJ](https://www.jetbrains.com/idea/buy/?section=commercial&billing=yearly) | US $169.00             | US $599.00          |
| [Visual Studio](https://visualstudio.microsoft.com/vs/pricing/?tab=business)      | Free(Community vesion) | US $250.00          |

개인에 한해서라면 _Unity_, _Android Studio_, _XCode_, _Visual Studio Code_ 등 대부분의 IDE가 무료라는 것을 생각한다면 _IntelliJ_ 의 유료 정책은 다소 아쉽지만, 자바 개발에 있어서 압도적인 효율과 새로운 기술을 가장 빠르게 적용해 준다는 것을 고려한다면 충분한 가치가 있습니다.

자바나 스프링을 주력 개발 언어와 플랫폼으로 사용한다면 최고의 선택입니다.

## Visual Studio Code with Spring Boot Extension Pack from Microsoft

스프링 공식 홈페이지에서는 예전에는 Eclipse나 STS(Spring Tool Shite)를 우선했습니다. 예를 들어, 가이드가 도큐먼트에서 IDE를 설명할 때 Eclipse나 STS가 첫번째로 묘사가 되었는데요, 이 부분이 미묘하게 바뀌고 있습니다.

![VSCode screenshot](/assets/images/home-screenshot-mac-lg-2x.png)

이미 STS라는 Eclipse를 기반으로 한 단독 IDE는 소개하고 있지 않습니다. 그리고, 도큐먼트에서도 이 자리를 Visual Studio Code(VSCode)가 대치하고 있습니다.

따라서, 현재 VSCode를 이용해서 스프링 부트 개발환경을 만드는데는 심각한 문제는 없습니다. 오히려 Eclipse 기반의 툴이 UI에서 모든 기능을 구현하기 때문에 IDE에서 지원하지 않는 기능은 사용할 수 없지만, VSCode는 일반적으로 Extension과 커맨드를 동시에 사용하기 때문에 이득이 있는 경우도 있습니다.

만약 여러분의 개발 스택이 자바에 국한되지 않고, IntelliJ에 매월 혹은 매년 지불할 가치가 적거나 없다고 생각한다면, VSCode가 최고의 선택입니다.

## Spring Tools 4 for Eclipse

IntelliJ와 마찬가지로 Spring Tools 4는 Eclipse 기반으로 만들어 졌지만, 느립니다. 그런데 더 큰 문제가 있습니다.

![Spring Tools 4 for Eclipse 스크린샷](/assets/images/eclipse-shot.jpg)

이클립스라는 도구는 자바로 만드는 모든 개발을 할 수 있도록 설계되었고, 그 부분은 아직까지 유지되고 있는데, 문제가 되는 부분이 바로 **workspace**라는 개념입니다.

VSCode의 경우 사실 [workspace](https://code.visualstudio.com/docs/editor/workspaces), project라는 개념이 없습니다. 편의성을 위해서 폴더를 project라고 부르고 있으며, project로써 하는 모든 것은 확장에서 처리합니다.

> A Visual Studio Code "workspace" is the collection of one or more folders that are opened in a VS Code window (instance).

반면 이클립스의 workspace가 하는 일은 의외로 많은데요, 이클립스 자체가 필요한 모든 정보를 workspace의 `.metadata` 폴더에 넣고, 이클립스를 실행할 때 마다 어떤 **workspace**를 사용할지에 대한 선택을 강요합니다. 그리고, 동일한 **workspace** 내의 projects는 서로 Linking이 되죠.

이 부분이 문제가 되는 이유는 최근의 CICD 환경에서는 소스에서 프로그램을 만들기 위한 **build(빌드))**라는 절차가 자동화가 되고, 빌드에 필요한 모든 정보가 project 내에 설정파일로 넣는데, **workspace**라는 존재가 이를 방해합니다.

IntelliJ는 이런 문제 때문에 더이상 **workspace**를 개발자에게 강요하지 않습니다. 다른 대부분의 IDE도 강제하고 있지 않습니다. 반면 Spring Tools 4 는 **workspace**를 git에 넣을 방법이 모든 프로젝트를 단일 레포지토리에 넣는 것이므로 소스 저장소 관리가 매우 복잡해 집니다.

이런 이유로 학습으로서의 목적이 아니면 Spring Tools 4 for Eclipse는 추천하지 않습니다. VSCode라는 대체제도 있으니까요.

## 세줄 요약

- 구독이 가능하면 [IntelliJ](https://www.jetbrains.com/idea/)
- 구독이 힘들면 [VSCode](https://code.visualstudio.com/)
- [Spring Tools 4 for Eclipse](https://spring.io/tools)는 쓰지 마세요.

만약 기존의 프로젝트가 Eclipse과 강력히 결합되어 있다면, 빌드를 자동화하기 위해서 별도의 담당자를 배정해야 합니다. 그 만큼 Eclipse의 workspace는 협업과 소스코드 관리 및 배포에 있어서 위험할 수 있습니다.
