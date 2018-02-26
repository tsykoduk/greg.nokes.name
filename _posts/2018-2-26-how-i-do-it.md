---
id: 15572
title: How I post an article
date: 2018-2-26
author: Greg Nokes
layout: post
guid: http://greg.nokes.name/?p=15572
permalink: /2018/02/26/how-i-do-it/
categories:
  - Computers! and Code!
excerpt_separator:  <!--more-->
---
I think that the workflow I have developed for this blog is pretty interesting, so I decided to write up how I currently make the sausage.
<!--more-->

The first step is to write an outline. I currently use Textmate, but I am thinking about trying out Visual Studio, as a few freinds have been gushing about it. On my iPad I will use working copy.

![Textmate Getting Started](../wp-content/uploads/2018/02/textmate-getting-started.png)

The second step is to create a local branch for the article:

![Local Branch](../wp-content/uploads/2018/02/local-branch.png)

The third step is to create a pull request on Github for this request:

![Push To Github](../wp-content/uploads/2018/02/push-to-github.png)
![Open Pr](../wp-content/uploads/2018/02/open-pr.png)

Since I have a pipeline set up on Heroku with review apps enabled, once the PR is opened on Github you will notice that Heroku automatically creates an app tied to that PR.

![Pr Opned](../wp-content/uploads/2018/02/pr-opned.png)
![Review App Created](../wp-content/uploads/2018/02/review-app-created.png)

I can hand out review app to folks that I want to get feedback from. Aslo, as I revise the app and push those changes to my PR, those changes automatically appear in the review app.
