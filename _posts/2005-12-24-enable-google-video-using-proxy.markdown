---
layout: single
title: "구글 비디오, 한국에서 제대로 써보자"
date: 2005-12-23 17:52:49
categories: service
tags: google video
author: Samgu Lee
---

구글 비디오는 한국에서 서비스가 매우 제한적입니다. 구글 비디오를 제대로 서비스 받기 위해서는 어쩔 수 없이 IP를 숨기는 기술을 이용해야 하는데, 가장 쉬운 프록시서버를 사용해서 접속이 가능합니다.

구글 비디오에서 검색을 하던, 첫페이지에서 클릭을 해 세부페이지로 들어가던 한국에서 접속을 하면 아래와 같은 메세지가 나오게 됩니다.

> Thanks for your interest in Google Video.  
> Currently, the playback feature of Google Video isn't available in your country.  
> We hope to make this feature available more widely in the future, and we really appreciate your patience.

번역하자면 당신의 국가에선 구글 비디오를 플래이할 수 없다 이런 메세지인데, 이 문구 대신 플래이어가 뜨게 하려면 프록시 서버를 경우해서 접속하면 가능합니다. 다른 나라도 접속이 불가능할 것 같아서 이 글에선 미국에 있는 프록시 서버를 사용해 봅시다.

UPDATE.

구글비디오를 한국에서 보는 방법은 세가지가 있습니다.

1. 프록시서버를 사용
2. 구글 웹 엑셀러레이터를 사용
3. [구글비디오의 클립들을 블로그에 옮겨서 사용]({% post_url 2006-01-16-video-in-my-blog %})

```sh
209.86.122.224 80
```

위의 숫자들은 앞에 것은 IP, 뒤에 것은 포트입니다.(프록시 서버는 특히 무료일 경우 항상 된다는 보장이 없습니다.) 이 번호들을 브라우져에 세팅하면 끝나게 됩니다.

익스플로러에선 도구->인터넷 옵션->연결(탭)->LAN 설정으로 들어가서 위의 IP와 포트를 넣으세요.(그림 참조)

![프록시 서버 설정](/assets/proxy.jpg)

불여우에서는 도구->설정->연결설정->프록시 수동 설정에서 넣으면 됩니다.

브라우져를 재시동할 필요 없이 바로 구글 비디오에 접속을 하고 동영상을 클릭하면 플래시로 제작된 구글 비디오 플래이어가 작동을 하게 됩니다.

![구글 비디오 플래이어](/assets/google_video.jpg)

## 구글 비디오의 한국 서비스는 언제?

구글 비디오팀에게 한국은 언제 서비스 되냐고 묻는 질문에 다음과 같은 답변이 왔습니다.

> Hi,  
> Thanks for your interest in Google Video. As you have discovered, the playback feature of Google Video currently isn't available in South Korea.  
> However, we hope to make this feature available more widely in the future.
>
> We appreciate your patience.
>
> Sincerely,
>
> The Google Video Team

구글의 서비스 중 가장 비지니스적으로 힘들어 보이는 것이 다름아닌 구글 비디오입니다. 당장 플래이어 만들기도 매우 힘들텐데, 어떻게 서비스가 이루어질지 재밌게 지켜보도록 하죠.

**Update 1.**

구글 비디오를 직접 올리는데 참고가 되는 블로그를 소개합니다.

[이젠 말도 안나온다. 구글 비디오 업로드](http://ilmol.egloos.com/1197333)

**Update 2.**

2006년 1월 12일에 확인해본 바로는 한국에서 구글 비디오를 별다른 설정변경없이 볼 수 있음이 확인되었습니다. 이젠 프록시같은 세팅은 필요하지 않게 되었습니다. :-)

**Update 3.**

한국 전체 IP가 해재된 것은 아닌것 같습니다. 만약 구글비디오가 제대로 나오지 않는다면 위에서처럼 프록시를 세팅하는 것도 방법이고, 구글 웹 엑셀러레이터를 설치하는 것도 방법이 됩니다.
