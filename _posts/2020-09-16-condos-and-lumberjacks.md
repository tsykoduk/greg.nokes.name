---
id: 16000
title: Condos and Lumberjacks, or Why PaaS?
date: 2020-09-16
author: Greg Nokes
layout: post
guid: http://greg.nokes.name/?p=15600
permalink: /2020/09/16/condos-and-lumberjacks/
categories:
 - Computers! and Code!
---
I have been involved in and with various infrastructure as a service and platform as a service providers for well over 12 years now. Often I am asked to explain "why use a IaaS provider?" or "why use a PaaS?" or "Why use [Heroku](https://www.heroku.com)?".

I wrote this out to try and explain these concepts in concrete terms. 

Lucky for me, a few co-workers decided to help me with art and video production help, and we were able to remove the "*with bad drawings*" subtitle. Also we made a cool animation explaining this. You can see the [video here](https://youtu.be/_N8Zf_nPZkQ).

Thanks to the awesome [Nicole Johnson](https://www.linkedin.com/in/nicolecjohnson/), Jennifer Hooper and the entire [Heroku marketing team](https://www.heroku.com/podcasts) for taking my idea and making it shine.

Icebergs and Lumberjacks
====================

**With bad drawings**

AWS loves to say “*AWS is for builders*” and I cannot agree more. AWS is for builders, but Heroku is for developers. 

Why? 

And what does that even mean? 

And what is the difference?

![Iceberg above water](/wp-content/uploads/2020/09/IMG_0100.jpeg)

Professional Development is hard. It is a skill that can take years to hone. The tools that developers use can be foreign to other folks. Things like “the CLI” or “IDE’s” or “git”. Like any other specialization developers speak their own language, and over the decades have developed tools that are aimed at their use case.

Also the craft of development is hard. If you think about it, we are writing step by step instructions for computers to execute. We are pretty darn close to running at the bottom of the stack, right?

Wrong.

![Iceberg under water ](/wp-content/uploads/2020/09/IMG_0101.jpeg)

They say that 90% of the iceberg is underwater, and not visible. The same can be said about development. Writing code in Java, Ruby, Python or what have you is the *easy* part. It’s the details that you do not see that cause you the most trouble.

The 90% of the tasks that are invisible are what gets you. What sort of things are these?

![Whole Iceberg](/wp-content/uploads/2020/09/IMG_0102.jpeg)

This is where the builders come in. They have to build the parts of the app that no one ever sees. They build the plumbing that the app runs on. Before you write a line of code, you have to acquire or build and configure a lot of things.

Say, you want to have an application that simply serves HTML traffic and has part of it’s data connected to Salesforce. What would you need to *build* to accomplish this?

Well, at it’s most basic this is what you would have to build, before your developers even starting writing code! 

![Architecture Diagram](/wp-content/uploads/2020/09/img_0107.png)

This does not include things like autoscaling, auto-healing, multi-AZ failover, build environments, developer tooling, CI/CD pipelines and a host of other things that you will need. 

Oh you want to use Kuberntes (K8s)? That’s just as hard.

Functions as a Service is getting closer to “Heroku easy” for certain use cases and certain architectures. For example, if your code can handle intermittent “cold start” delays, then FaaS might be for you. However it is not a silver bullet, and it does not solve every problem.

If we think of it like needing a house, AWS is going to the lumber yard, and buying wood so that you can build a house. Even with K8s, EKS, Lambda, Docker, you still have to assemble, configure and maintain all of those things, and the interconnections between them.

And, K8s, FaaS, Docker? They were born out of looking at how Heroku was and is doing things. 

* [12factor](12factor.net)? Heroku wrote it. 
* [Buildpacks](https://buildpacks.io)? Heroku invented them.
* `git push heroku master`? You guessed it. Invented at Heroku.

When I started in the industry, we did not even have lumber yards. We had to cut down trees and get our lumber that way! We had to call Dell or HP or Gateway and have them send us servers. We then had to assemble those servers, and put them into racks. Next we had to install the operating system and any software packages that we needed. 

That’s on premises for you. The most control, and the most manual labor and time.

AWS has elevated the game. AWS gives us a lumber store. And it is really awesome. You can go in, and find a vast array of different types and sizes of lumber, lots of connectors, electrical stuff and plumbing. You can pick and choose from a huge menu of services on AWS. However you have to choose the correct menu items, and then you have to configure them correctly, integrate them, and manage those services and integration.

Oh and by the way, after you are done with all of that lumber and your house is built, who’s going to fix your house when something goes wrong with it? 

You. 

You will.

When we say Heroku is easier to use then AWS this is exactly what we mean. Instead of buying lumber, you are buying a Condo with landscaping and maintenance included.

![Simple Architecture Diagram](/wp-content/uploads/2020/09/IMG_0108.jpg)

You buy the Condo and your interior decorators (developers) can get started on choosing the color of the tile, ordering couches and hanging the art.

Heroku allows developers to skip the building, and get straight to development. It also manages those built parts for our customers. These two things allow Heroku customers to be able to focus on the development of the apps they want to build, and not focus time on building infrastructure to host their developers and code.

