---
layout: single
title:  "구글 분석(Google Analytics) 신규계정 생성제한"
date:   2005-11-24 06:03:40
categories: service
tags: Google GoogleAnalytics
author: Samgu Lee
---
구글분석(Google Analytics)은 한국시간으로 2005년 11월 22일부터 신규계정의 생성을 중단한다고 공식사이트에 공지했습니다.

다음은 공식사이트에 공지된 글의 번역본과 원문입니다.

지난주부터, Google Analytics 서비스에 이상하리만치 많은 요청이 있었습니다. 그래서 우리의 고객들에게 가능한 최고의 경험을 선사하기 위해서 새로운 가입을 받을 수 없었습니다. 우리는 몇몇 유져가 데이터를 보는데 매우 느리게 보이는 것을 알고 있습니다. 그리고 가능한 빠르게 리포트를 만들기 위해서 열심히 작업하고 있습니다.

> (Over the last week, we’ve experienced extraordinarily high demand for Google Analytics, so much that we’ve had to disable new signups to ensure the best possible user experience for our customers. We are aware that some of our users have experienced a slow-down in seeing their reporting data due to the huge demand, and we’re working hard to make report data as fresh and current as possible.)

우리는 가능한 빨리 재오픈 하기위해서 정말 열심히 용량을 늘리고 있습니다. 만약 여러분이 가입이 다시 활성화될 때 공지를 받고 싶어 한다면 가입페이지에 이메일주소를 입력해 주세요. 당신과 모든 온라인 커뮤니티가 Google Analytics에 관심을 가져주셔서 매우 고마와하고 있답니다.

> We are also diligently adding more capacity so that we can re-open signups as soon as possible. If you want to be notified about when signups will re-open, please enter your e-mail address on our signup page. We are grateful for the interest that you and the entire online community has in Google Analytics.
> - The Google Analytics Team


이 글은 기존의 회원들에게 공지로 일괄 이메일 전송되었습니다.

이메일로 전송된 서비스 변경 내용의 원문은 아래와 같습니다.

> 1. The ‘Check Status’ button is being reworked to check for properly installed tracking code. This should be fixed by the end of November.
> 2. The ‘+Add Profile’ link has been temporarily removed until we increase capacity. We’ll alert all current users when the feature is restored.
> 3. While we increase capacity, you may see longer than normal delays in data showing up in your reports. All data continues to be collected and no data has been lost.

번역을 하자면 이렇습니다.

> 1. &#8216;상태 체크'버튼은 설치된 트랙킹코드를 올바르게 체크할 수 있도록 다시 작업하고 있습니다. 이것은 11월 말까지 고쳐질 것입니다.
> 2. &#8216;프로필 추가' 링크는 용량이 늘어날 때 까지 임시로 삭제되었습니다. 우리는 모든 유저에게 복구되는데로 알려드릴 것입니다.
> 3. 우리가 용량을 늘리는 동안 당신은 데이터에서 리포트에서 볼 수 있는 데이터의 지연시간이 더 늘어날 수 있을지도 모릅니다.

기존의 회원들은 모든 서비스를 이용하는데 지장은 없는것으로 파악되지만, 도메인을 추가하는 링크가 사라졌습니다.

분석결과 태그만을 삭제한 것으로 삭제태그를 복제하면 도메인 추가가 가능한 것으로 파악되었습니다. 메인페이지에서 소스보기를 하면 다음과 같은 코드를 찾을 수 있습니다.

```html
<td class="list_control_cell" align="right"><span class="plus">+</span>&nbsp;<a href="admin?vid=1151&scid=179509" class="normal">웹사이트 프로필 추가</a>
```
만약 이렇게 나온다면 a 태그 안의 주소를 주소창에 이어서 붙여보세요. 도메인 추가가 됩니다. 하지만, 이렇게 하더라도 상태확인이라고만 뜨고 데이터는 나오지 않습니다.

아무튼, 엄청난 트래픽을 감당할 수 있는 정도의 서버라면 아마도 검색엔진의 용량 이상이 될 가능성도 배재할 수 없습니다. 무료서비스로 공표한 이상 어느정도의 안정성을 확보할 수 있을지 사뭇 기대가 됩니다.
