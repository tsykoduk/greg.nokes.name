---
id: 16400
title: Blog Performance 2022 edition
date: 2022-09-25
author: Greg Nokes
layout: post
guid: https://greg.nokes.name/?p=16400
permalink: /2022/09/25/heroku-removing-free-teir/
categories:
  - Computers! and Code!
excerpt_separator:  <!--more-->
---
Well, if you have not seen it yet, [Heroku is removing it's free tier on November 22nd](https://blog.heroku.com/next-chapter). Beyond the migration (if you use the free tier, you need to decide if you want to upgrade or move. And don't forget to grab SQL dumps of your free Postgres), I have some thoughts.

<!-- more -->

In the heady early days of Heroku, we always gave each application a "free" Dyno. Coupled with entry level free Postgres, this allowed an entire generation of web developers to cut their teeth. More importantly, it enabled folks to use [12 factor](https://12factor.net) easily and inexpensively. For free actually. It also pushed folks with production apps to always have a second Dyno for HA purposes.

This was rampant with abuse. Folks would literally spin up 100 apps with 1 dyno, and then load balance across them. Coupled with the "dyno pinger" tools to make sure that their free dynos never went to sleep, and it became burdensome to support.

Heroku then moved to offering a "free tier" dyno. Only one in an app, and you had an hours budget that you could spend. Coupled with review apps, and you could build a modern CI/CD pipeline easily and almost for free. For example, this blog lived on Heroku (and parts of it still do) for years, with review apps and a pipeline.