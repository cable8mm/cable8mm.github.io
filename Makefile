# 기본 실행 target 설정 (make만 입력했을 때 serve가 실행됨)
.DEFAULT_GOAL := serve

.PHONY: install serve build clean

# 1. 의존성 설치
install:
	bundle install

# 2. 로컬 서버 실행 (기본값)
serve:
	bundle exec jekyll serve

# 3. 초안(Drafts)을 포함하여 로컬 서버 실행
serve-drafts:
	bundle exec jekyll serve --drafts

# 4. 프로덕션 빌드 (정적 파일 생성)
build:
	JEKYLL_ENV=production bundle exec jekyll build

# 5. 빌드 결과물 및 캐시 삭제
clean:
	bundle exec jekyll clean
	rm -rf _site .jekyll-cache .jekyll-metadata
