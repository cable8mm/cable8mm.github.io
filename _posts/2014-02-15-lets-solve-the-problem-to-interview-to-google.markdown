---
layout: single
title:  "재미로 보는 구글 Job Interview 문제 풀이"
date:   2014-02-14 16:39:51
categories: gassip
tags: google quiz
author: Samgu Lee
header:
    og_image: /assets/images/coding_interview.png
---
[좋아하는 블로그](https://comeddy.wordpress.com/2012/12/25/google-job-interview-q-1에서-1000사이중에-8은-몇번이-있을까/ "COM+EDDY'S BLOG")의 예전 글을 보다가 우연히 구글 인터뷰 문제 풀이를 보게 되었는데, 다소 재미있는 것 같아서 풀어 보도록 하자.

![코딩 인터뷰]({{ page.header.og_image }})

> 문제. 1에서 1000사이중에 8은 몇번이 있을까?

**풀이**

1을 0001로 본다면, 주어진 숫자의 자릿수는 4이다.

그 중 첫번째 자릿수는 0 혹은 1 뿐이고, 나머지 자릿수는 0부터 9까지 나올 수 있다.

일자리에 8이 나올 경우는 몇 번일까? 앞에 100이 있으니 100번.

십자리에 8이 나올 경우는 몇 번일까? 앞에 10이 있으니 10번에 뒤에 일자리가 버티고 있으니 10*10 해서 100번.

백자리에 8이 나올 경우는 몇 번일까? 뒤에 100이 있으니 100번.

따라서 답은 100+100+100 = 300번이다.

