---
id: 730
title: SaaS vs The Cloud
date: 2009-06-05T15:56:00+00:00
author: tsykoduk
layout: post
guid: https://greg.nokes.name/?p=730
permalink: /2009/06/05/saas-vs-the-cloud/
categories:
  - Computers! and Code!
tags:
  - cloud
  - hype
  - linkedin
  - saas
  - web application
---
In an article today ("<a href="http://www.schneier.com/blog/archives/2009/06/cloud_computing.html">Cloud Computing</a>") Bruce Schneier makes some great points about SaaS and Cloud Computing.

<!--more-->
<blockquote>But, hype aside, cloud computing is nothing new . It's the modern version of the timesharing model from the 1960s, which was eventually killed by the rise of the personal computer. It's what Hotmail and Gmail have been doing all these years, and it's social networking sites, remote backup companies, and remote email filtering companies such as MessageLabs. Any IT outsourcing -- network infrastructure, security monitoring, remote hosting -- is a form of cloud computing.</blockquote>
It also breaks the 80/20 rule that I learned back in the old days of BNC connectors. 80 percent of the processing should be local, and 20 percent remote. For some things (the 20 percent) it certainly belongs "in the cloud". However, some things do not belong out there.

I think, however,  that the Bruce misses the point of "the Cloud". From my perspective, it's not about SaaS - it's lower level then that. It's about being able to provision servers in moments in "the Cloud". It brings location independence to bare metal servers. It allows me to create a cluster with a deployed web application, several application servers and a database server in minutes, instead of hours or days. That's the "cloud" that I think of - things like <a href="http://aws.amazon.com/">AWS</a>, <a href="http://www.vmware.com/solutions/cloud-computing/vcloud.html">vCloud</a>, <a href="http://heroku.com/">Heroku</a>and <a href="http://www.engineyard.com">Engine Yard</a>. SaaS can certainly be built on top of this infrastructure.

That is the compelling paradigm behind the Cloud. Being able to elastically provision resources, on demand, almost instantly. Being able to write an application, push a button and having it out there for the world to use. This new paradigm lowers the entry level to becoming a "web business" dramatically.

SaaS and the Cloud are interdependent - the Cloud came to be because of the needs of SaaS and I agree (totally) that SaaS has issues. For example,  I have witnessed an entire office taken off line because the login server was remote. However, to lump SaaS's issues into this new way of looking at servers and capacity is just not getting the big picture.
<blockquote>Trust is a concept as old as humanity, and the solutions are the same as they have always been. Be careful who you trust, be careful what you trust them with, and be careful how much you trust them. Outsourcing is the future of computing. Eventually we'll get this right, but you don't want to be a casualty along the way.</blockquote>
Also trust them with how much information you give them, and make sure you keep a backup.