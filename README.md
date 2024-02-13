# palgle.com

This repository is the storage for palgle.com contents. It has been made by jekyll, then published to github pages.

You can visit https://cable8mm.github.io/

## Install

```sh
git clone https://github.com/cable8mm/cable8mm.github.io.git palgle

cd palgle

valet link palgle

valet secure
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
