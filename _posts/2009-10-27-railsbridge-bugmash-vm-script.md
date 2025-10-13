---
id: 820
title: RailsBridge Bugmash VM Script
date: 2009-10-27T12:16:59+00:00
author: tsykoduk
layout: post
guid: https://greg.nokes.name/?p=820
permalink: /2009/10/27/railsbridge-bugmash-vm-script/
categories:
  - Computers! and Code!
tags:
  - Bugmash
  - Debian
  - RailsBridge
  - ruby
excerpt_separator:  <!--more-->
description: "Looking at the blog post content, I can see this is about a script for setting up a Rails development environment for the RailsBridge Bugmash event. Here's an SEO-optimized meta description:"
---
<img class="alignleft size-thumbnail wp-image-15186" title="corot7b_eso_big" src="https://greg.nokes.name/binaries/2009/10/corot7b_eso_big-150x150.jpg" alt="corot7b_eso_big" width="150" height="150" />
After fooling around with creating a VM for the RailsBridge Bugmash insta-server, I decided that it was just too unwieldy. There are simply too many moving parts to make a small VM. That got me thinking...
<!--more-->

Enter the script!
I have hacked together a basic Debian script which will take a bare bones system, install all of the requirements and use <a href="https://rvm.beginrescueend.com/">rvm</a> to download, install, configure and gem up several flavors of ruby.
It's over on <a href="https://github.com/tsykoduk/Rails-Bugmasher">github</a> - so please feel free to fork, improve, and send pull requests.



<script src="https://gist.github.com/219880.js"></script>