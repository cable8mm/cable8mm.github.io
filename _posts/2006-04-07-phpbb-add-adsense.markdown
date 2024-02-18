---
layout: single
title:  "PHPBB에 애드센스 코드를 넣어보자"
date:   2006-04-07 07:22:54 +09:00
categories: opinion
tags: google phpbb adsense
author: Samgu Lee
---
PHPBB는 한국에서는 많이 쓰이지는 않지만 영어권 웹사이트에서 가장 광범위하게 사용되는 무료 포럼(게시판)입니다. 이삼구글 포럼을 만들면서 애드센스를 넣는 코드를 작성해봤습니다.

일반적으로 블로그에서는 애드센스 코드를 템플릿이나 스킨에 삽입하는 것으로 간단하게 삽입할 수 있습니다. 하지만, 게시판 같은 포럼이 들어간 웹사이트의 경우 그렇게 할 경우 다음과 같은 [애드센스 약관](https://www.google.co.kr/adsense/localized-terms)을 위배하게 됩니다.(애드센스 약관은 수시로 바뀌기 때문에 별도의 확인이 필요하고, 다음에 나오는 약관은 글을 쓸 당시의 약관임을 알립니다.)

> (v) 오류 페이지 , 등록 페이지나 "감사" 페이지 ( 예 : 사용자가 해당 웹 사이트에 등록했을 때 감사를 표하는 페이지 ), 채팅 페이지 , 이메일 또는 포르노나 증오 , 폭력 , 불법 내용이 포함된 웹 페이지나 웹 사이트에 광고 , 링크 또는 추천 버튼을 게재하는 행위

블로그의 경우 모든 페이지가 컨텐츠 페이지이지만, 게시판 등의 포럼에서는 등록페이지나 수정페이지, 그것을 알리는 페이지 등 컨텐츠가 아닌 페이지가 동시에 존재합니다. 따라서, 운영자는 컨텐츠 페이지에만 애드센스 코드를 넣는 수정코드를 이용해야 합니다.

## 애드센스 약관에 맞게 코드를 수정하는 방법

물론 이 기능을 구현하기 위해서는 많은 방법이 존재하지만, 이삼구글에서는 가장 간단한 방법으로 URL을 이용했습니다. PHPBB에서 컨텐츠만 나오는 URL은 다음과 같습니다.

```sh
/
/index.php
/viewtopic.php
/viewforum.php
/search.php
```

확장자인 php는 설정에 따라서 html이 될 수도 있겠지만, 최종적인 코드는 그것과 상관없이 작동됩니다. 즉, URL이 위의 도메인을 포함한다면 애드센스 코드가 나온다는 계획입니다.

삽입하려는 애드센스 코드는 PHPBB의 상단과 하단으로 고정했습니다. 상단과 하단의 스킨파일은 overall_header.tpl 파일과 overall_footer.tpl 파일입니다.

## 삽입 코드(includes/page_header.php)

page_header.php 파일의 가장 마지막 코드는 $template->pparse(&#8216;overall_header'); 이것입니다. 이 줄 바로 전에 다음과 같은 코드를 추가합니다.

```php
if(preg_match('/\/(index|viewtopic|viewforum|search)/',$_SERVER['REQUEST_URI']) || $_SERVER['REQUEST_URI']=='/') {
$adsense =	array();
$adsense['728'] =	<<<EOD728
<script type="text/javascript"><!--
[[애드센스 코드 1]]
EOD728;
$adsense['15'] =	<<<EOD72815
[[애드센스 코드 2]]
EOD72815;
	$template->assign_vars(array(
'ADSENSE_728' => $adsense['728'],
'ADSENSE_72815' => $adsense['15'],
	));
} else {
	$template->assign_vars(array(
		'ADSENSE_728' => '',
		'ADSENSE_72815' => '',
	));
}
```

위 코드는 728x90과 728x15 두가지 사이즈를 넣은 것으로, 더 필요하다면 쉽게 추가할 수 있습니다. 위의 코드 추가로 템플릿(혹은 스킨)에서 다음과 같이 쓸 수 있게 되었습니다.

```
{ADSENSE_728}
{ADSENSE_72815}
```

팔글 포럼에 적용된 것을 예로 들면 overall_header.tpl 파일에 72815가 삽입되었고, overall_footer.tpl 파일에 728이 적용되었습니다.(위의 코드를 그대로 복사해서 붙였다는 의미)

이로서 구글 약관에 부합하는 포럼을 만들 수 있게 되었습니다. 이삼구글 포럼에서 확인해보면 알겠지만, 위의 주소 이외에 개인정보라던지, 글 수정 페이지에는 애드센스가 나오지 ㅇ낳습니다. :-)

만약 굉장한 방문자의 포럼이라면 더욱 최적화시켜서 애드센스 코드를 넣을 필요가 있습니다. 예전에도 포스팅했던 것 처럼 웹사이트 광고는 그 위치에 따라서 [꽤 많은 수익 차이][adsense-blogtimize]가 나고 그것은 [애드센스 사례연구](https://www.google.com/adsense/success) 페이지에도 잘 나와있습니다.

[adsense-blogtimize]: {% post_url 2006-01-31-adsense-blogtimize %}
