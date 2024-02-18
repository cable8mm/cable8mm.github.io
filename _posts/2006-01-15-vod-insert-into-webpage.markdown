---
layout: single
title:  "웹사이트에 동영상 삽입하기"
date:   2006-01-15 15:05:00 +09:00
categories: opinion
tags: video upload
author: Samgu Lee
---
웹사이트에 동영상을 올리는 방법은 매우 간단합니다. 문제가 되는 것은 동영상 파일이 인터넷에 연결된 어떤 서버에 업로드 되어 있어야 한다는 점입니다.

일반적으로 인터넷 공간을 이용하기 위해서는 돈을 지불해야 합니다. 무료로 공간을 제공하는 업체가 있지만, 동영상을 올릴 정도의 공간은 만들어 주지 않고, 설사 공간을 제공한다고 해도 자신의 웹사이트에 올리지 못하게 하는 경우도 많습니다.

미국의 경우는 동영상만을 전문으로 업로드하고 사용자 웹사이트에서 소개할 수 있는 서비스가 여럿 존재합니다. 그 서비스들은 대부분 무료이며, 전문적인 서비스를 할 때만 돈을 지불하게 됩니다.

## 구글비디오 이용하기

동영상을 서버에 올리고 손쉽게 이용할 수 있는 사이트가 바로 구글비디오입니다. 구글비디오는 파일을 구글서버에 올리기만 하면 개인 웹사이트나 블로그에서 그 동영상을 보여줄 수 있는 코드를 제공해 줍니다.

이 방법에 대해서 자세히 알고 싶으신 분은 "[구글비디오를 이용해서 블로그에 동영상 넣기]({% post_url 2006-01-16-video-in-my-blog %})"를 참조하세요.

## 개인 서버 이용하기

개인적으로 소유한 또는 빌린 서버를 이용할 수 있는 분은 그 곳에 동영상 파일을 올려 주소를 일정한 형식에 맞춰서 글에 첨부하기만 하면 됩니다.

아래의 코드는 [마이크로소프트에서 제공하는 파이어폭스와 익스플로러 동시에 지원되는 코드](http://msdn.microsoft.com/library/default.asp?url=/library/en-us/dnwmt/html/windows_media_player_advanced_scripting_for_cross_browser_functionality__jchc.asp)입니다. "주소"라고 쓰여진 곳을 동영상 주소로 바꾸어 넣어보세요.

```html
<OBJECT ID="MediaPlayer1" width=176 height=144
classid="CLSID:22D6F312-B0F6-11D0-94AB-0080C74C7E95"
CODEBASE="http://activex.microsoft.com/activex/controls/mplayer/en/nsmp2inf.cab#Version=6,4,5,715"
standby="Loading Microsoft® Windows® Media Player components..."
type="application/x-oleobject">
<PARAM NAME="AutoStart" VALUE="True">
<PARAM NAME="FileName" VALUE="주소">
<PARAM NAME="ShowControls" VALUE="False">
<PARAM NAME="ShowStatusBar" VALUE="False">
<EMBED type="application/x-mplayer2"
pluginspage="http://www.microsoft.com/Windows/MediaPlayer/"
src="주소" mce_src="주소"
name="MediaPlayer1"
width=176
height=144
autostart=1
showcontrols=0>
</EMBED>
</OBJECT>
```

```html
<a href="http://servername/path/your-file.asx" mce_href="http://servername/path/your-file.asx">Start the streaming media presentation in the stand-alone Player.</a>
```
