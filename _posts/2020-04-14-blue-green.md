---
id: 15810
title: Using Nginx for Blue Green deploys on Heroku
date: 2020-04-09
author: Greg Nokes
layout: post
guid: http://greg.nokes.name/?p=15810
permalink: /2020/04/09/blue-green/
categories:
  - Computers! and Code!
---

One of the questions that I get from time to time is "how do I do Blue/Green deploys on Heroku". While not a part of the platform, Heroku still makes setting up solutions like this very easy.

<!-- more -->

Nginx is a veritable swiss army knife, and you guessed it. We will be using an Nginx router as outlined in my article on [Nginx Routing](/2020/02/27/nginx-routing-on-heroku/). If you have not read that yet, it's a good primer as we will be building on the techniques outlined there.

