# palgle.com

[![pages-build-deployment](https://github.com/cable8mm/cable8mm.github.io/actions/workflows/pages/pages-build-deployment/badge.svg)](https://github.com/cable8mm/cable8mm.github.io/actions/workflows/pages/pages-build-deployment)
[![Deploy Jekyll site to Pages](https://github.com/cable8mm/cable8mm.github.io/actions/workflows/jekyll.yml/badge.svg)](https://github.com/cable8mm/cable8mm.github.io/actions/workflows/jekyll.yml)
![GitHub repo size](https://img.shields.io/github/repo-size/cable8mm/cable8mm.github.io)
![GitHub License](https://img.shields.io/github/license/cable8mm/cable8mm.github.io)

This repository is the storage for palgle.com contents. It has been made by jekyll, then published to github pages.

You can visit https://www.palgle.com

## Install

```sh
git clone https://github.com/cable8mm/cable8mm.github.io.git palgle
# Clone from repository

cd palgle

jekyll build
# Make static files

cd _site
# Go static files root folder

valet link palgle
# Connect with palgle.test

valet secure
# Set secure for https
```

And visit https://palgle.test

## Creating pages and posts

You should collectly make file name to fit rules. Kebab case is suggested.

    YYYY-MM-DD-[filename].markdown

If you need to lovereload when you write something, it can be help.

```sh
bundle exec jekyll serve --livereload
```

## Deployment

It will done automatically by github action. You wouldn't do anything.
