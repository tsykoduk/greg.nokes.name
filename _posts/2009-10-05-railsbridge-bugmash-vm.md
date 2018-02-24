---
id: 15171
title: Railsbridge BugMash VM
date: 2009-10-05T22:22:11+00:00
author: tsykoduk
layout: post
guid: http://greg.nokes.name/?p=15171
permalink: /2009/10/05/railsbridge-bugmash-vm/
categories:
  - Mundane
tags:
  - RailsBridge
  - RoR
  - ruby
  - ruby on rails
  - test system
  - turnkey
excerpt_separator:  <!--more-->
---
One of the things that came out of our <a href="http://wiki.railsbridge.org/projects/railsbridge/wiki/BugMash">rails bugmash</a> team and time at <a href="http://blueboxgrp.com">Blue Box Group</a> was that the real time killer was a lot of the prep work. Installing 3 databases, and all of the other tools and goodies can take hours which could be used mashing bugs and racking up points.

<!--more-->
Enter the BugMash VM - in VMWare flavor right now. It's an early beta - but right now it has everything that you could need to test Rails or a Rails application.

The next iteration might just run on <a href="http://www.archlinux.org/">Arch Linux</a> and be a <a href="http://www.virtualbox.org/">VirtualBox</a> image, or perhaps just be an install script.

Below is the start of the read me - and attached is the (HUGE) image file. Beware, this weighs in at about 1.2 GB. If you have some time to spare, grab a copy of the <del datetime="2010-04-16T04:31:13+00:00">Bugmash VM Image</del>, and send me feedback.

<strong>UPDATE</strong><em>: Check out the script article above. It does everything for you. It's being updated to include rails3 bundler etc.</em>

<strong>RUBY ON RAILS TESTING VM IMAGE</strong>

Welcome to the RoR BugMash Testing VM. This was created as a tactical tool to increase the productivity of bugmash teams by removing the need to set up a rails test system with all of the packages that entails.

<strong>BASICS</strong>

The VM image is a VMWare image. It has two users defined: Work and Root. Each has the ultrasecure password of "password".

Do we need to point out that this is <strong><em>NOT A SECURE SYSTEM</em></strong> and is <strong><em>NOT MEANT FOR PRODUCTION <span style="font-weight: normal;"><span style="font-style: normal;">and</span></span></em><em> NOT MEANT TO BE USED ON THE INTERNET</em><span style="font-weight: normal;">?</span></strong>

We have used and or created several tools to help with the tasks at hand. rvm for managing our rubies, cinabox for setting up the rails testing/CI server and several small bash scripts to automate routine tasks. Thanks to wayne (<a href="http://rvm.beginrescueend.com/">http://rvm.beginrescueend.com/</a> - he's the one crushing the red bull can on his head), chad (<a href="http://github.com/thewoolleyman/cinabox">http://github.com/thewoolleyman/cinabox</a>), and the turnkey linux team (<a href="http://www.turnkeylinux.org/">http://www.turnkeylinux.org/</a>). We are standing on the shoulders of giants!

<strong>USAGE</strong>

rvm is a superkiller tool for managing many ruby installs on 1 box. We use this in our testing scripts. If you would like to test vs the default system ruby, just cd ~/code/ruby then rake. If you'd like to test vs many rubies, run ~/test.rails. If you like quiet output use ~/json.test.rails.

cinabox is a CI server "in a box". We have the full CI server installed - not tested yet.

~/update.box runs all of the update scripts.