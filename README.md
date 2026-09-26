# palgle.com

[![Deploy Jekyll site to Pages](https://github.com/cable8mm/cable8mm.github.io/actions/workflows/jekyll.yml/badge.svg)](https://github.com/cable8mm/cable8mm.github.io/actions/workflows/jekyll.yml)
![GitHub repo size](https://img.shields.io/github/repo-size/cable8mm/cable8mm.github.io)
![Jekyll 3.9.4](https://img.shields.io/badge/Jekyll-3.9.4-FFCC01?logo=jekyll)
![Markdown](https://img.shields.io/badge/Made_with-Markdown-000000?logo=markdown&logoColor=white)
![Hosting Github Page](https://img.shields.io/badge/Hosting-Github_Pages-222222?logo=github)
[![Licence-CC_BY-NC-ND 4.0](https://img.shields.io/badge/License-CC_BY--NC--ND_4.0_DEED-F5F5F5?logo=Creative%20Commons)](https://creativecommons.org/licenses/by-nc-nd/4.0/)
[![RSS](https://img.shields.io/badge/RSS-FFA500?logo=rss&logoColor=white)](https://www.palgle.com/feed.xml)
![Editor](https://img.shields.io/badge/Visual_Studio_Code-0078D4?logo=visual%20studio%20code&logoColor=white)
[![Blog](https://img.shields.io/badge/Blog-palgle.com-blue?logo=html5&labelColor=ddd)](https://www.palgle.com)

이 저장소는 palgle.com 콘텐츠를 보관하는 곳입니다. Jekyll로 제작되었으며, GitHub Pages를 통해 배포됩니다.

https://www.palgle.com 에서 방문하실 수 있습니다.

## 설치

```sh
git clone https://github.com/cable8mm/cable8mm.github.io.git palgle
# 저장소를 클론합니다

cd palgle

jekyll build
# 정적 파일을 생성합니다

cd _site
# 정적 파일 루트 폴더로 이동합니다

valet link palgle
# palgle.test와 연결합니다

valet secure
# https를 위한 보안 설정을 합니다
```

이후 https://palgle.test 로 방문하세요.

## 의존성

이 프로젝트는 Ruby와 [Jekyll](https://jekyllrb.com/)을 사용합니다. 의존성은 [Bundler](https://bundler.io/)를 통해 `Gemfile`로 관리되며, `Gemfile.lock`으로 버전이 고정됩니다.

### Ruby 버전

프로젝트는 **Ruby 3.3**을 타깃으로 합니다([.github/workflows/jekyll.yml](.github/workflows/jekyll.yml) 참조). `.ruby-version` 파일은 사용하지 않으며, 버전은 CI 워크플로우에서 고정됩니다.

### 의존성 설치

```sh
bundle install
```

`Gemfile`에 명시된 모든 gem을 설치합니다. 또한 제공되는 `Makefile` 타겟을 사용할 수도 있습니다:

```sh
make install
```

### 패키지 업데이트

모든 gem을 최신 버전으로 업데이트하려면:

```sh
bundle update --all
```

특정 gem만 업데이트하려면(예: `jekyll-feed`):

```sh
bundle update jekyll-feed
```

업데이트 후에는 수정된 `Gemfile.lock`을 커밋하여 CI 및 다른 기여자들이 동일한 gem 버전을 사용하도록 해야 합니다.

## 페이지 및 포스트 작성

파일명은 규칙에 맞게 정확히 지어야 합니다. 케밥 케이스를 권장합니다.

    YYYY-MM-DD-[filename].markdown

작성 중 실시간 반영이 필요하다면 다음 명령이 도움이 됩니다.

```sh
bundle exec jekyll serve --livereload
```

## 배포

GitHub Action을 통해 자동으로 처리됩니다. 별도로 할 일은 없습니다.

## 라이선스

<p xmlns:cc="http://creativecommons.org/ns#" xmlns:dct="http://purl.org/dc/terms/"><a property="dct:title" rel="cc:attributionURL" href="https://www.palgle.com">Content</a> by <a rel="cc:attributionURL dct:creator" property="cc:attributionName" href="https://www.linkedin.com/in/cable8mm/">Sam Gu Lee</a> is licensed under <a href="http://creativecommons.org/licenses/by-nc-nd/4.0/?ref=chooser-v1" target="_blank" rel="license noopener noreferrer" style="display:inline-block;">CC BY-NC-ND 4.0<img style="height:22px!important;margin-left:3px;vertical-align:text-bottom;" src="https://mirrors.creativecommons.org/presskit/icons/cc.svg?ref=chooser-v1"><img style="height:22px!important;margin-left:3px;vertical-align:text-bottom;" src="https://mirrors.creativecommons.org/presskit/icons/by.svg?ref=chooser-v1"><img style="height:22px!important;margin-left:3px;vertical-align:text-bottom;" src="https://mirrors.creativecommons.org/presskit/icons/nc.svg?ref=chooser-v1"><img style="height:22px!important;margin-left:3px;vertical-align:text-bottom;" src="https://mirrors.creativecommons.org/presskit/icons/nd.svg?ref=chooser-v1"></a></p>
