---
id: 16400
title: Heroku Removing Its Free Tier
date: 2022-08-25
author: Greg Nokes
layout: post
guid: https://greg.nokes.name/?p=16400
permalink: /2022/08/25/heroku-removing-free-teir/
categories:
 - Computers! and Code!
excerpt_separator: <!--more-->
---

<div style="float: right; padding: 10px 10px 10px 10px;"><img src="/binaries/2022/08/buddha_bud.jpeg" width="150" alt="purple lit buddha with a black cowboy hat"><br />
<sub><i>Image by <a href="https://twitter.com/tsykoduk">tsykoduk</a></i></sub></div>

Well, if you have not seen it yet, [Heroku is removing its free tier on November 28nd, 2022](https://blog.heroku.com/next-chapter).

If you use the free tier, you need to decide if you want to upgrade or move. And don't forget to grab SQL dumps of your hobby Postgres!

I thought that I would take a moment to reflect on the journey of Free at Heroku, and exercise some other hosting platforms.

<!--more-->

With the removal of the free tier at Heroku, the industry has lost a [powerful learning tool](https://xeiaso.net/blog/rip-heroku). It's my hope that some newer technology can step it to continue to make Tech more diverse and equitable. For Postgres you have [Crunchy's Postgres Playground](https://www.crunchydata.com/developers/tutorials). What else is out there for folks to get experience with out barriers?

In the heady early days of Heroku, we gave each application a "free" Dyno. This allowed an entire generation of web developers to cut their teeth on real web development. Couple it with entry level free Postgres, and you had a platform that enabled folks to break into tech. It also enabled folks to use [12 factor](https://12factor.net) easily and inexpensively. For free actually. Also it pushed folks with production apps to always have a second Dyno for HA purposes.

This was rampant with abuse. Folks would spin up lots of apps with 1 Dyno, and then load balance across them. Folks also developed "Dyno pinger" tools to make sure that their free dynos never went to sleep. 

This meant that it became burdensome to support.

Heroku then moved to offering a "free tier" Dyno. You could only have one in an app, and you had an hours budget that you would burn down. Coupled with review apps and pipelines, and you could build a modern CI/CD pipeline easily and almost for free. For example, this blog has lived on Heroku for years, with [review apps and a pipeline](https://greg.nokes.name/2018/02/26/how-i-do-it/). Again, empowering customers and users to have rich, professional tools at their fingertips. And enabling easy adoption of the [12 Factor](https://12factor.net) methodology. 

Still rampant with abuse.

I'm personally going to pour one out for the death of Heroku 2.0, and the birth of Heroku 3.0. This does not mean that I *disagree* with the decision to turn off free. After all, I gave up any agency I had in the direction of Heroku when I [left](https://greg.nokes.name/2022/06/14/a-decade-at-heroku/). 

More importantly, I have a feeling that given the cold, hard facts this was the best option to move Heroku forward. They have taken the bold step of publishing their [roadmap publicly](https://github.com/heroku/roadmap). We can all watch along as they evolve the platform into it's next version. And I am cheering them on. Heroku is a magical place, and the humans that build it are amazing folks.

In a more close to home change, this new world has left me with some choices about the future of where this screed lives. I've removed the review apps and pipeline, and have a test site up with [Netlify](https://www.netlify.com). You are probably reading that version right now. If you use one of the other domain names to access this side like [gregorynokes.com](https://gregorynokes.com/) then you are hitting a Heroku Dyno.

I've not landed on [Netlify](https://www.netlify.com) as a permanent home. I am also looking at [Render](https://render.com), [Fly.io](https://fly.io) and [Railway](https://railway.app). I've been on Jekyll for a few years. Perhaps it's time to dust off my coding skills to create a home rolled blogging engine again. Quite honestly, writing this article with out a review app has been painful. I have some work cut out for me.

