---
layout: single
title: "구글비디오를 이용해서 블로그에 동영상 넣기"
date: 2006-01-16 02:41:36
categories: service
tags: google video
author: Samgu Lee
header:
  og_image: /assets/my_google_video.jpg
---

동영상을 제작하는 것은 지금은 어렵지 않습니다. 물론 세세히 들어가면 만만한 작업은 아니지만, 개인적인 비디오의 제작은 클릭 몇번으로도 만들 수 있게 되었습니다.

다만, 비디오를 자신의 블로그나 미니홈피, 아니면 개인 홈피에 넣는 것은 몇가지 면에서 번거로움이 있지만, [구글비디오를 이용하면 자신의 블로그에 비디오를 삽입할 수 있고, 다른 이들에게 소개도 할 수 있습니다][all-about-google-video].

구글비디오는 개인 또는 회사의 비디오파일을 상업적 또는 비상업적으로 자유롭게 사용할 수 있게 하는 일종의 비지니스 플랫폼이라고 할 수 있습니다. 대비가 되는 애플 아이포드 스토어가 음반사와의 계약을 통해 음악이나 혹은 동영상들을 아이포드라는 재생기기만을 위한 서비스라면, 구글비디오는 역시 구글답게 사업적으로 할 수 있는 최대한의 자유도를 보장하고 있는 서비스입니다.

## 구글비디오는 사용자의 편의를 최대한 보장해준다.

몇번의 글에서 언급했듯이 구글비디오는 구글에서 추진중인 서비스 중 가장 복잡합니다. 저작권 문제도 상당히 까다롭습니다. 하지만, 구글답게 과감하게 추진하고 있고, 업데이트도 다른 서비스와 비교해 본다면 매우 빠르게 진행되고 있습니다.

구글 비디오를 이용하면 사용자는 다음의 일들을 할 수 있습니다.

1. 비디오를 구글서버에 업로드하고, 구글 비디오 검색에서 소개할 수 있다.
2. 구글서버에 업로드된 동영상은 설정에 따라 다르지만, 무료일 경우 누구나 홈페이지에서 소개할 수 있다.
3. 간단히 시청자에게 요금을 부과할 수 있다.
4. PSP나 IPod용 파일을 생성하고 다운로드할 수 있다.

이 글에서 소개해 드리고 싶은 것이 바로 2번입니다. 2번 서비스는 무료동영상으로 설정했을 때만 가능하다는 사실을 잊지 마세요.

## 누구나 여러분들의 동영상을 소개할 수 있는 열린 광장

구글 비디오는 비디오 검색 서비스에서 소개할 수도 있지만, 비디오를 업로드한 사용자 혹은 비디오가 마음에 들어서 자신의 웹사이트 혹은 블로그에서 소개를 하고 싶은 사람 등 모든 사람들이 자유롭게 이용할 수 있는 기능이 있습니다.

구글 서버에 올린 사용자만이 이 기능을 사용할 수는 없습니다. 말하자면 All or None입니다. 즉, 자신이 서버에 올리면 나와 같은 권한을 다른 사용자도 갖는다는 의미이고, 그것을 일부제한할 수도 없습니다.

그럼 실제로 동영상을 자신의 블로그에 올려보도록 하겠습니다.

## 블로그 혹은 게시판에서 지원해야 할 것

저와 같은 설치형 블로그 혹은 개인이 HTML코드를 관리하는 웹사이트 관리자, 게시판 설정을 바꿀 수 있는 관리자일 경우는 이 부분은 넘어가 주세요. 설치형은 거의 된다고 보시면 됩니다.

다음이나 네이버에서 제공하는 서비스형 블로그를 사용하는 분들은 OBJECT와 EMBED라는 태그가 블로그에서 지원되는지 확인해 보셔야 합니다. 구글에서 제공하는 블로거닷컴(blogger.com)의 경우는 지원됩니다만, 다른 블로그의 경우는 확인을 해 보셔야 합니다.

## 동영상 플래이어 HTML 코드 얻기

구글서버에 올라간 동영상을 올리는 것은 간단합니다. 구글 비디오 검색에서 동영상을 보고, 우측에 있는 HTML코드를 복사해서 자신의 웹사이트나 블로그에 붙이기만 하면 됩니다.

아래의 그림은 코드가 나와있는 구글비디오 페이지입니다.

실제로 넣어본 블로그 : 여성 3인 호러 섹시 댄스

![구글비디오에서 HTML코드 얻기](/assets/my_google_video.jpg)

## 워드프레스에서 동영상 넣는 방법

제가 워드프레스를 사용하는 관계로 [워드프레스에서 구글 동영상을 넣는 플러그인](http://helmetcameracentral.com/2006/01/11/videobloggerplugin/)을 소개해 드리겠습니다.

워드프레스가 얼마전에 2.0이 나왔는데요, 2.0용으로 구글비디오 등 3가지 동영상 서비스에서 제공하는 영상을 자유롭게 넣을 수 있는 플러그인입니다.

![비디오 블로거 플러그인 옵션 화면 갈무리](/assets/vblogger.jpg)

사용법은 설정에서 Activation시키고, 구글비디오의 ID값을 다음과 같은 코드로 넣어주기만 하면 됩니다. ID값은 주소창에서 확인할 수 있습니다.

    제목 = “!vb:gv,5133441566760049494!”
    본문 = “!vb:gv,5133441566760049494,4!”

실제로 넣어본 블로그 : 테크노와 복고댄스가 섞인 퓨전 분위기의 매트릭스 복고

## 왜 구글비디오를 사용해야 하는가

1. 우선 무료이고 용량에 제한이 없습니다.
2. 툼네일(작은 그림)을 만들어주고, PSP나 IPod용 파일도 자동으로 만들어 줍니다.
3. 내 홈페이지나 블로그에서 다른 이들에게 보여줄 수 있습니다.
4. 호스팅비용을 걱정할 필요가 없습니다. 무료입니다.
5. 플래이어가 플래시로 제작되었기 때문에 익스플로러만이 아니라 파이어폭스 같은 다른 브라우져에서도 볼 수 있습니다.
6. 구글비디오 외에 대안이 없습니다.

사실 무료로 서버에 올려서 자신의 웹사이트 혹은 블로그에서 서비스할 수 있는 방법이 없습니다. 지인이 무료로 일정량의 인터넷 공간을 빌려주면 사용이 가능하겠지만, 무료로 호스팅해주고, 동영상을 이리저리 사용할 수 있게 하는 서비스는 아직까지 본 적이 없습니다.

구글비디오는 무척이나 많은 사용자들에게 욕(?)을 먹고 있습니다. 특히 돈주고 동영상들을 구입한 미국 사용자들은 NBA 농구 동영상 파일이 재생이 안된다는 둥, PSP로 재생이 안된다는 둥의 많은 댓글을 구글 그룹스에 올리고 있습니다.

하지만, 구글의 다른 서비스처럼 빠른 속도로 개선이 될 것이며, 개인적으로는 지금으로서도 무료로 무제한의 인터넷 공간을 제공해 준 구글에 감사하고 있습니다.

[all-about-google-video]: {% post_url 2006-01-12-all-about-google-video %}
