---
id: 15290
title: Binary Searching and other tools of the trade
date: 2010-04-16T10:29:30+00:00
author: tsykoduk
layout: post
guid: https://greg.nokes.name/?p=15290
permalink: /2010/04/16/binary-searching/
categories:
  - Mundane
tags:
  - Duh
  - I Learned This In Third Grade
  - Tools
excerpt_separator:  <!--more-->
---
<a href="https://greg.nokes.name/binaries/2010/04/binary_search.png"><img class="alignright size-medium wp-image-15294" title="binary_search" src="https://greg.nokes.name/binaries/2010/04/binary_search-300x208.png" alt="" width="300" height="208" /></a>

One of the tools that I use on an almost daily basis is the Binary Search. I think that this tool is one of the ways that a good troubleshooter seems so much more efficient then a mediocre troubleshooter.

<!--more-->

It's a pretty simple tool, as the diagram show. Split the problem's area into two, and determine which side of the split the issue lies on. As you continue to split the set of problems down, you'll either reach a level where you only have one issue, or only have one logical direction to proceed.

For example, if you are presented with a host that will not talk to the internet, you might start by trying to ping the gateway IP address. If you can ping that address, then you know the problem lies on the other side of the gateway.

This is a text book example of how a binary search can save you time over a large set of cases. Yes, if the problem is the NIC drivers, and the first thing you do is reinstall them, you took care of the issue in a lot less time. However every other case where they are not the problem, you just caused yourself extra work and frustration.

This tool has obvious uses in web application scaling as well. For example, most high traffic web applications are broken up into <a href="http://en.wikipedia.org/wiki/Multitier_architecture">N-Tier </a> layouts. If you can quickly determine which of the tiers is the bottleneck, you can save yourself tons of time.

This is one of the core reasons that I recommend people break their applications up into tiers as soon as they can. Luckily, the current technologies employed by web applications fit snugly into this.

The first layer generally becomes the cache or <a href="http://en.wikipedia.org/wiki/Content_delivery_network">CDN</a>. A CDN provides obvious benefits over  a local cache server, however at certain levels of scale, one or the other become mandatory.

The second layer generally is the application servers. Web servers fronting <a href="http://en.wikipedia.org/wiki/Mongrel_(web_server)">mongrels</a>, <a href="http://www.modrails.com/">passenger </a>clusters, <a href="http://unicorn.bogomips.org/">unicorns</a> or what ever flavor you use.

Next we generally see the database layer. We have <a href="http://en.wikipedia.org/wiki/SQL">SQL based database</a> clusters, <a href="http://memcached.org/">Memcached</a> clusters or <a href="http://en.wikipedia.org/wiki/NoSQL">NoSQL</a> clusters.

By keeping these layers separate, we can easily determine where the issue is, and test different configurations in the layer that is the bottleneck. It also allows us to gain easier insights into which layer is causing the problem. For example, high IO wait on the DB will effect the DB, but if the app servers are on the DB server, it will also effect their performance, and you might get several symptoms caused by one issue (the DB thrashing the disk).