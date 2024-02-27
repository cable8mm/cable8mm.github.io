---
layout: single
title: "구글 어스(Google Earth) 2종 세트"
date: 2006-08-28 02:55:31
categories: service
tags: google earth
author: Samgu Lee
---

드디어 프로페셔널이라 할 수 있는 구글 어스와 관련된 내용 두가지를 소개해 드립니다.

[구글 어스(Google Earth)와 네이버맵의 좌표변환을 이용한 매쉬업]({% post_url 2006-08-08-google-naver-meshup %})을 소개한지 얼마되지 않은 것 같은데, 서비스의 업데이트 소식이 워낙 많습니다.

## 1. Naver map on Google earth

말 그대로 구글 어스위에 네이버 맵을 올린 것으로 구글 어스와 구글 맵에 한국 지역정보가 들어가 있지 않아서 네이버 맵의 자료를 레이어로 올려버렸습니다.

재미있는 사실은 네이버 맵의 API를 이용하지 않고 이미지의 각종 URL을 해킹해서 구현했다는 점입니다. 이 방법은 구글 맵스에서 API를 제공하기 전에도 매쉬업을 구현한 것과 비슷합니다.

![네이버 맵 온 구글 어스](https://advance.sarang.net/~aero/map/nog.jpg)

역시 이 변환 프로그램도 적절한 좌표변환 알고리즘을 사용해서 네이버맵의 좌표(카텍좌표계, 동경이 기준점이라 하여 동경좌표계라고도 함)를 구글 어스의 좌표로 변환한 것과 네이버 맵의 이미지를 이용해서 KML파일을 만들어 버립니다.

KML파일은 구글 어스와 맵스에 사용하는 지도 정보 파일이고, 현재 계속 업데이트되고 있습니다.

링크

- [Naver map on Google earth 설명](http://advance.sarang.net/%7Eaero/map/)
- [질문 게시판](http://kldp.org/node/73163)

## 2. 서울 전역의 3D 모델링 on Google Earth

제모지오 스페셜(Gemeaux Geo Spatial)이라는 회사는 항공 스캔이라는 기술을 한국에 적용해서 매우 빠른 속도로 한국 전역의 3D 지도 데이터를 전문으로 다루는 회사입니다.

이 회사는 올해 5월부터 자사의 데이터를 구글 어스의 KML파일로 변환하기 시작했으며, 그 공정도 프로그램에 의한 자동화를 완성했다고 합니다.

![서울 전역을 그린 KML 파일](/assets/seoulkmz.jpg)

쉽게 말하자면, 서울의 건물을 지도위에 표시한다고 할 때, 기존에 사람이 돌아다니거나 국토지리정보원의 데이터를 받아서 네이게이션이나 네이버 맵스를 제작하지 않고, 제모지오 스페셜은 비행기를 띄워서 서울 자체를 스캔해 버립니다. 스캔에서 얻은 좌표는 동시에 측정된 여러군데의 GPS 로 인해 좌표 보정이 되고 보정된 정확한 좌표가 구글 어스의 KML(혹은 KMZ) 파일로 만들어 집니다.

KML은 최근 무료화된 스케치업 5(SketchUp 5)를 이용했다고 하며, 건물 이외에 도로 정보와 심지어 가로수 정보까지도 표현할 수 있는 기술을 소유하고 있다고 하며, 지표면과 관계된 DEM(Digital Elevation Model : 순수한 땅바닥의 높이값-bare ground) 측량 데이터도 제작하고 있습니다.

링크

- [공식 웹사이트](http://www.gemeauxgs.com/)
- [피카사웹을 이용한 앨범](http://picasaweb.google.com/cable8mm/SeoulKMZ)
