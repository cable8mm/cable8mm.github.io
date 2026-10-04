# 기본 실행 target 설정 (make만 입력했을 때 serve가 실행됨)
.DEFAULT_GOAL := serve

.PHONY: install serve serve-drafts build clean post return

POST_DIR := _posts

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

# 6. 새 포스트 빈 파일 생성: make post my-post-slug
ifeq ($(firstword $(MAKECMDGOALS)),post)
POST_SLUG := $(word 2,$(MAKECMDGOALS))
# 두 번째 인자를 target으로 해석하지 않도록 무시 처리
$(eval $(POST_SLUG):;@:)
endif

post:
	@if [ -z "$(POST_SLUG)" ]; then \
		echo "사용법: make post <slug>"; exit 1; \
	fi
	@mkdir -p $(POST_DIR)
	@file="$(POST_DIR)/$$(date +%F)-$(POST_SLUG).md"; \
	if [ -e "$$file" ]; then \
		echo "이미 존재함: $$file"; exit 1; \
	fi; \
	touch "$$file"; \
	echo "생성됨: $$file"

return:
	git checkout main
	git pull