---
id: 15224
title: With Clouds, Come a Chance of Rain
date: 2010-02-19T09:54:44+00:00
author: tsykoduk
layout: post
guid: http://greg.nokes.name/?p=15224
permalink: /2010/02/19/with-clouds-come-a-chance-of-rain/
categories:
  - Computers! and Code!
  - Philosophy! and Politics!
tags:
  - cloud
  - scaling
  - web application
---
One of the interesting paradigms in the technology field now days is "cloud". I think that I have seen it bandied about more then "web 2.0" a few years ago. It's hit required buzz word compliance status in market-speak. I believe that is it over used, misunderstood and used to mislead. Let's cut through the hyperbole and see what is really going on.
<!--more-->
Let's dissect the meaning behind the word, and then look at some of the pros and cons.
<blockquote>"Cloud computing is a model for enabling convenient, on-demand network access to a shared pool of configurable computing resources (e.g., networks, servers, storage, applications, and services) that can be rapidly provisioned and released with minimal management effort or service provider interaction. This cloud model promotes availability and is composed of five essential characteristics, three service models, and four deployment models."</blockquote>
-- <a href="http://csrc.nist.gov/groups/SNS/cloud-computing/index.html">NIST</a>
<blockquote>"..convenient, on-demand network access to a shared pool of configurable computing resources"</blockquote>
This sounds like my old <a href="mail.yahoo.com">Yahoo Webmail</a> account. Or my really old <a href="http://en.wikipedia.org/wiki/Gopher_(protocol)">Gopher</a> account. Is this really anything new, or simply repackaging of existing concepts?
<blockquote>"..rapidly provisioned and released with minimal management effort or service provider interaction."</blockquote>
This  is honestly the nugget in the rough. However, as a consumer of services, you really don't care, do you? This is because of system administrators, programmers and other smart folks who got tired of racking physical hardware every time someone wanted a new server. Do you care if it takes Google a week, a day or an hour to create a new compute instance? Not as long as they provide you the service that you need.

As an IT manager or web developer you do care about this. It allows you to consume resources when they are needed. The thought is that by doing this, you streamline your costs. Sadly, generally it does not lower cost. It allows you to respond to needs with less planning and forethought. When you get hit by a traffic spike, you can provision new resources in a few hours rather then a few days. Nothing in this world is free, and the increased agility comes at a price in performance and or money.

So, with planning and work ahead of need, you can get more performance out of your spend, or by doing things last minute you can spend more for less.

The NIST goes on to explain that the five essential characteristics are "<strong><em>On-demand self-service</em></strong>, <strong><em>Broad network access</em></strong>, <strong><em>Resource pooling</em></strong>, <strong><em>Rapid elasticity</em></strong> and <strong><em>Measured Service</em></strong>."

<strong>On-demand self-service</strong>

Quite honestly, there is no such thing as the NIST's vision of "A consumer can unilaterally provision computing capabilities, such as server time and network storage, as needed automatically without requiring human interaction". It simply cannot happen with the current technology. When there is a run on compute power, and the Service Provider needs more to fulfill the requests, do you think that they add it "without requiring human interaction"? People order, build, assemble, configure, install and provision the hardware that the cloud runs on. People monitor the servers, replace them when they fail. People run the cloud. There is always human intervention.

<strong>Broad network access</strong>

Broad network access is nothing new or exciting. It's called the internet. However they explain this as "accessed through standard mechanisms that promote use by heterogeneous thin or thick client platforms". This has nothing to do with the platform in question, rather it deals with the programming of the application living on the platform. You can run a thick client application back end on Amazon's AWS or a dedicated server in a data center just as easily as you can run a web application.

<strong>Resource pooling</strong>

This is just a nice way of saying "multi-tenant". This means that other people very well might be stressing the system that you are on, leading to performance hits or at the very least, variable performance. For small scale applications, this can work well, as providers can oversubscribe resources that are not stressed, increase their bottom line, and hopefully return that to their customers in lower costs.

High performance or applications looking for a consistent performance profile do not fair as well. When they need the resources, they need them right then. If someone else is trashing the disk, eating RAM or slurping down CPU cycles, that could be a few hundred milliseconds added to your requests.

<strong>Rapid elasticity</strong>

In my mind, this is the one point that cloud should be defined by. The ability to add services as needed, quickly. Even extremely high performance applications have parts which need to be scaled upon high traffic events. The ability to make copies of a application server rapidly is powerful. However there are parts of an infrastructure that cannot be scaled in this matter. Learning which parts of your application fit into each use case is very important.

However, there is nothing revolutionary about this either. Elasticity  has been around for a long time - our definition of rapid has just changed. in a decade we will probably look back and laugh, thinking that Rapid Elasticity means new servers in 10 seconds. A decade ago rapid was a day.

<strong>Measured Service</strong>

Again, this is nothing new or exciting. Every well run service that you and I use is measured. Take Cell Phones. If the cell companies had no method of measuring your usage, they would quickly go out of business. To include this as a requirement seems silly. Honestly, how can you bill for something if you do not measure it's usage.

<strong>Where to go from here?</strong>

The rest of the paper goes on in the same vein, spinning existing technologies under new terms. Software as a Service has been around since early computers used time sharing to remote terminals. Unix itself was built with this concept in mind.

I think it's time to back away from the abyss, and start using the term in a manner that actually makes logical sense. Cloud is not everything, and not everything needs to be cloudy. Just because something has the word cloud in it's description, does not mean it is a good tool. Think back to firms like pets.com, flooz.com, GovWorks.com or Kozmo.com. Just because they were dot com's, did not mean they were good ideas, or worth investing in.

The Cloud is a method of deploying servers. Nothing sexy about that. It is evolving back end infrastructure. It is not generating mystical world peace or printing money, no matter what people are telling the investors. It is another step in a good, long term, evolutionary change in technology. Just because some application is touted as being in "the cloud" does not make it better or worse then any other application.

The point to take away is that the Cloud does not remove the need for careful planning and optimization. It can shorten the time line on deployments of parts of your infrastructure. However the big boys are still going to need beefy servers behind critical parts of their applications.

If you agree, disagree or don't care - post a comment! I think that only through some discourse on this topic will we put this myth to rest.