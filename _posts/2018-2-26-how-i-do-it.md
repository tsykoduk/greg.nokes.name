---
id: 1200
title: How I post an article
date: 2018-2-26
author: tsykoduk
layout: post
guid: https://greg.nokes.name/?p=1200
permalink: /2018/02/26/how-i-do-it/
categories:
  - Computers! and Code!
excerpt_separator:  <!--more-->
---
I think that the workflow I have developed for this blog is pretty interesting, so I decided to write up how I currently approach it.
<!--more-->

The first step is to write an outline. I currently use [Textmate 2](http://macromates.com), but I am thinking about trying out [Visual Studio](https://code.visualstudio.com), as a few friends have been gushing about it. On my iPad I will use [Working Copy](https://workingcopyapp.com).

![Getting Started](/binaries/2018/02/textmate-getting-started.png)

The second step is to create a local branch for the article:

![Local Branch](/binaries/2018/02/local-branch.png)

The third step is to push the branch to Github and create a pull request:

![Push To Github](/binaries/2018/02/push-to-github.png)
![Open Pr](/binaries/2018/02/open-pr.png)

Since I have a [pipeline](https://devcenter.heroku.com/articles/pipelines) set up on Heroku with review apps enabled, once the PR is opened on Github you will notice that Heroku automatically creates an app tied to that PR.

![Pr Opened](/binaries/2018/02/pr-opened.png)
![Review App Created](/binaries/2018/02/review-app-created.png)

I can hand out review app to folks that I want to get feedback from. Also, as I revise the app and push those changes to my PR, those changes automatically appear in the review app.

![Merge PR](/binaries/2018/02/Merge-PR.png)

Once I am done with the article, I can push it into staging. I do this by simply merging the PR into my master branch. Once the PR is merged or deleted, the review app is disposed of.

If the PR is merged into the master branch, my staging app detects the new code, and automatically deploys it. If I had unit tests written, I could hook up Heroku CI to automagically run my tests previous to the deploy.

![Building Staging](/binaries/2018/02/Building-Staging.png)

Once I am happy with the article, I can promote it into production.

![Promote To Production](/binaries/2018/02/Promote-to-Production.png)

What is super nice about this workflow is when I want to do larger changes (for example, swapping out the theme) I can do that with out a fear of breaking the running app. When I used to host on Wordpress, I would often be making larger changes live on my site, with exciting results.

You can read about how to create a pipeline on [Heroku's Devcenter](https://devcenter.heroku.com/articles/pipelines).
