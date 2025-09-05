---
id: 1300
title: The Simplest Heroku Demo Ever
date: 2020-08-26
author: tsykoduk
layout: post
guid: https://greg.nokes.name/?p=1300
permalink: /2020/08/26/simplest-heroku-demo/
categories:
  - Computers! and Code!
---

One of the things that I have done literally thousands of times over the last 9 years is show folks the power of Heroku. Over the years I have come up with, dare I say it, the simplest Heroku demo script ever:

<!--more-->

```bash
mkdir directory
cd directory
git init . && git checkout -b main
touch index.php
echo "<h1>this is a heroku app</h1>" >> index.php
git add . && git commit -m "first commit, yay"
heroku create
git push heroku main
heroku open
```

There you go - a few lines to create a new app, build environment, load balancers and everything else you need to run a highly scaleable, secured web application. All thanks to the power of Heroku.
