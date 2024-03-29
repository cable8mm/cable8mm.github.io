---
layout: single
title: "구글 사이트맵, robots.txt 분석툴 제공"
date: 2006-02-08 02:49:14
categories: service
tags: google
author: Samgu Lee
header:
  og_image: /assets/google_sitemap_robots_txt.jpg
---

구글 애드센스팀의 뉴스그룹으로 구글 사이트맵의 업데이트 소식을 알려왔습니다.

[이 소식](http://groups.google.com/group/Inside-AdSense/browse_thread/thread/c0e86a570c091554/c0e1c13a5c0c6b75#c0e1c13a5c0c6b75)을 구글 애드센스팀에서 공지한 이유는 구글 크롤러 즉 웹사이트의 내용을 긁어가는 프로그램이 robots.txt으로 막혀있을 경우 내용을 알지 못해서 PSAs라 불리우는 공익광고나 잘못 타켓팅된 광고가 뜨기 때문입니다.

robots.txt 파일은 검색엔진이 페이지를 복제해도 되는지 아닌지를 나타내는 웹퍼블리셔가 만드는 파일입니다. 즉, 웹퍼블리셔는 이 파일을 이용하면 원하는 검색엔진에 원하는 페이지만 올리는 것이 가능해집니다.

구글 사이트맵의 이번 업데이트는 블로그에 나와있는 바와 같이 robots.txt파일의 간단한 분석툴이 삽입되었고, 통계 메뉴에 몇가지 자료들이 추가되었습니다.

## 캐시된 robots.txt 분석

이번 업데이트에 가장 큰 변화로는 robots.txt라는 탭의 추가입니다. 이 페이지에서는 현재 사이트에 존재하는 robots.txt파일의 상태를 보여주고, 임시로 robots.txt를 만들어 볼 수 있게 시뮬레이션도 해 볼 수 있습니다.

![구글 사이트맵 robots.txt 탭](/assets/google_sitemap_robots_txt.jpg)

위의 그림에서 나오는 상태 404라는 것은 파일이 존재하지 않는다는 뜻입니다.

상태 하단에는 robots.txt파일을 만들어보고 테스트 할 수 있는 툴을 제공하고 있습니다. 첫번째 박스에는 만들려는 robots.txt를 넣고, 두번째 박스에는 확인할 URL을 넣습니다. 쉽게 말하자면, 자신이 만드는 robots.txt가 어떤 웹페이지를 검색할 수 있게 하느냐 그렇지 않느냐 하는 것입니다.

테스트를 해 보겠습니다.

첫번째 칸과 두번째 칸에 다음과 같은 내용을 넣습니다.

```sh
User-agent: *
Disallow: /buzz/
Disallow: /gallery/
```

검사를 누르게 되면 Googlebot이 https://www.palgle.com/ 과 https://www.palgle.com/mandl/ 은 허용으로 나오지만 https://www.palgle.com/buzz/ 은 차단으로 나오는 것을 알 수 있습니다.

![구글 사이트맵 robots.txt 검사](/assets/google_sitemap_robots_txt_validate.jpg)

이 툴로 테스트를 해 본 후 원하는 결과가 나올 경우 robots.txt파일을 만들어서 웹서버에 올리면 됩니다.

## 그 밖에 추가된 통계

메뉴에서 *통계-크롤링*을 선택하면 최하단에 최고의 PageRank 페이지라는 통계가 추가되었습니다. 이 것은 자신의 사이트에서 최고로 높은 페이지랭크 페이지를 알려줍니다.

또 다른 추가 통계로 메뉴에서 *통계-페이지 분석*을 선택하면 사이트의 콘텐츠와 사이트에 대한 외부 앵커가 표시됩니다. 이 것으로 자신의 웹사이트의 검색쿼리의 이유를 유추해 보는데 도움이 됩니다.

구글 사이트맵은 전에 언급했던 것처럼 페이지 랭크가 어느정도 올라가지 않으면 별로 쓸모가 없습니다. 일단, 구글에서 웹서치를 이용해서 자신의 사이트 랭크를 확인해 본 후에 본격적으로 적용하는 것이 좋습니다. 물론 미리 적용해도 좋지만, 별로 소용없는 일이라서요.
