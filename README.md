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

## License

<p xmlns:cc="http://creativecommons.org/ns#" xmlns:dct="http://purl.org/dc/terms/"><a property="dct:title" rel="cc:attributionURL" href="https://www.palgle.com">Content</a> by <a rel="cc:attributionURL dct:creator" property="cc:attributionName" href="https://www.linkedin.com/in/cable8mm/">Sam Gu Lee</a> is licensed under <a href="http://creativecommons.org/licenses/by-nc-nd/4.0/?ref=chooser-v1" target="_blank" rel="license noopener noreferrer" style="display:inline-block;">CC BY-NC-ND 4.0<img style="height:22px!important;margin-left:3px;vertical-align:text-bottom;" src="https://mirrors.creativecommons.org/presskit/icons/cc.svg?ref=chooser-v1"><img style="height:22px!important;margin-left:3px;vertical-align:text-bottom;" src="https://mirrors.creativecommons.org/presskit/icons/by.svg?ref=chooser-v1"><img style="height:22px!important;margin-left:3px;vertical-align:text-bottom;" src="https://mirrors.creativecommons.org/presskit/icons/nc.svg?ref=chooser-v1"><img style="height:22px!important;margin-left:3px;vertical-align:text-bottom;" src="https://mirrors.creativecommons.org/presskit/icons/nd.svg?ref=chooser-v1"></a></p>
