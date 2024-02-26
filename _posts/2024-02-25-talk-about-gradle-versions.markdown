---
layout: single
title: "Gradle의 버전"
date: 2024-02-25 16:54:00
categories: development
tags: gradle
author: Samgu Lee
header:
  og_image: /assets/images/dependency-management-configurations.png
---

자바 커뮤니티에서 패키지매니저는 구글이 안드로이드에서 `Gradle`의 손을 들어주면서 `Ant`와 `Maven` 보다 점유율을 높이고 있습니다. `Gradle`에서 버전과 그 밖의 것들을 이야기 해 보겠습니다.

![Gradle 의존성과 빌드]({{ page.header.og_image }})

편의상 패키지매니저라고 언급했으나, Gradle은 빌드 매니저입니다. 패키지 관리는 [Maven의 것](https://mvnrepository.com/)을 이용하고 있습니다. 하지만, 우리가 패키지를 사용할 때 Gradle을 통해서 선언하기 때문에 빌드로 Gradle을 사용한다면, 패키지 선언도 Gradle을 사용해야 하므로, 사용하는 입장에서 패키지 의존성을 Gradle이 해결하는 느낌을 받습니다.

반면 패키지 자체를 개발할 경우에는 Gradle의 [Maven Publish Plugin](https://docs.gradle.org/current/userguide/publishing_maven.html)을 이용해서 배포할 수 있습니다.

## Gradle 버전 표기법

먼저 아래의 선언(declaration)을 보시죠.

```gradle
dependencies {
    implementation("org.slf4j:slf4j-api:1.7.15")
}
```

`org.slf4j:slf4j-api`는 패키지 이름이고, `1.7.15`이 버전입니다. 정확히 1.7.15버전을 설치하라는 의미인데요, 보통은 이렇게 쓰지 않고 1.7.x 패키지 중 높은 버전으로 설치하라고 선언합니다.

```gradle
implementation("org.slf4j:slf4j-api:1.7.+") // 1.7.x 중 높은 버전
implementation("org.slf4j:slf4j-api:1.+") // 1.x.x 중 높은 버전
implementation("org.slf4j:slf4j-api:[1.1, 2.0)") // 1.1.x 중 높은 버전 혹은 2.x 중 2.0이 아니며 높은 버전
implementation("org.slf4j:slf4j-api:[1.1, [2.1") // 1.1.x 중 높은 버전 혹은 2.1.x 중 높은 버전
```

괄호를 이용한 버전 범위 선언은 Maven에서 사용하는 스타일인데요, 여전히 Gradle에서도 사용할 수 있습니다.

만약 버전에 관계없이 최신 버전을 선언할 경우 `latest.integration` 혹은 `latest.release` 을 사용할 수 있습니다.

## Gradle 버전 표기가 없는 경우

[Spring initializr](https://start.spring.io/)에서 스켈레톤을 만들 경우 `build.gradle` 파일을 보면 버전 표기가 되어 있지 않습니다.

```gradle
dependencies {
  implementation 'org.springframework.boot:spring-boot-starter'
  testImplementation 'org.springframework.boot:spring-boot-starter-test'
}
```

Gradle 에서는 매우 큰 프로젝트의 경우 버전을 표기하지 말고 `constraints` 즉 의존성을 이용하라고 권장합니다.

```gradle
dependencies {
    implementation("org.springframework:spring-web")
}

dependencies {
    constraints {
        implementation("org.springframework:spring-web:5.0.2.RELEASE")
    }
}
```

단순히 버전을 표기하지 않으면 저장소에서 가장 최신의 버전을 다운로드 합니다. 그리고, Spring Boot의 경우 버전에 관한 내용은 [spring-boot-starter-parent](https://repo1.maven.org/maven2/org/springframework/boot/spring-boot-starter-parent/2.5.2/spring-boot-starter-parent-2.5.2.pom) 의 [spring-boot-dependencies](https://repo1.maven.org/maven2/org/springframework/boot/spring-boot-dependencies/2.5.2/spring-boot-dependencies-2.5.2.pom)에 정의되어 있습니다.

## 버전 업데이트하기

Gradle에서 버전을 업데이트하는 명령어는 아래와 같습니다.

```sh
./gradlew refreshVersions
```

의존성이 해석된 다운로드 된 버전은 `Binary Reposity`라는 곳에 저장되며, 이 폴더는 보통 프로젝트가 아닌 컴퓨터에 저장되며, `~/.gradle/caches` 폴더에 저장됩니다.

![Gradle init](/assets/images/gradle-init.png)

gradle 프로젝트를 만들 경우 `gradle init` 명령어로 프로젝트에 필요한 폴더와 파일들을 만들 수 있습니다.

참고로 Gradle은 빌드매니저인 만큼 `tasks`라는 명령어도 관리를 해야 하는데요, 명령어의 집합을 plugins 라는 이름으로 관리합니다.

```gradle
plugins {
	java
	id("org.springframework.boot") version "3.2.3"
	id("io.spring.dependency-management") version "1.1.4"
}
```

스프링 부트를 설치하면 `build.gradle` 파일 가장 위에 `plugins`가 선언되어 있는데요, 각 패키지에서 만든 태스크(일종의 명령어)가 들어있습니다. 스프링 부트를 실행하는 `bootRun`도 여기에 정의되어 있기 때문에 `gradlew bootRun` 으로 스프링 부트를 구동할 수 있게 됩니다.

PHP의 composer나 Node의 npm, yarn 은 스크립트 언어이기 때문에 빌드를 할 필요가 없지만, 자바는 컴파일 언어이기 때문에 패키지 제작자가 빌드 시스템에 맞는 빌드 스크립트를 제작해 줄 필요가 있습니다.

쉽게 이야기하자면 하나의 프로그램으로 맥과 윈도우 양쪽에 배포한다면 코드는 그대로지만, 빌드와 아티펙트 배포 등의 빌드 스크립트는 두개를 작성해야 하는 것과 비슷합니다.

자바는 전세계 모든 디바이스에서 구동을 하기 위해 만들어 졌는데요, 그것을 구현하기 위해서 프로그래머는 프로그램을 제작하는 것 이상으로 수 많은 빌드 시스템에서 빌드가 제대로 되는 것을 보장해야 하기 때문에 자바 생태계는 Node나 PHP, Python 등의 스크립트 언어에 비해서 생태계가 빠르게 확장되지는 않으며, 커뮤니티 보다는 기업 위주의 생태계가 만들어 지는 이유이기도 합니다.

물론 이 것은 자바에만 있는 것이 아니라 C, C++, C# 등 빌드가 필요한 모든 언어들에 생기는 공통의 문제입니다. 이 문제를 해결한 golang은 빌드 문제를 배포시스템에서 완전히 해결하는 구조이기 때문에 컴파일 언어임에도 불구하고 매우 빠르게 생태계가 만들어 지고 있습니다.
