---
id: 990
title: RVM, Lion and Commandline Tools
date: 2012-03-21T11:46:53+00:00
author: tsykoduk
layout: post
guid: https://greg.nokes.name/?p=990
permalink: /2012/03/21/rvm-lion-and-commandline-tools/
categories:
  - Computers! and Code!
excerpt_separator:  <!--more-->
description: "Fix RVM installation issues on macOS Lion with Apple's command line tools. Learn how to resolve gcc and autoreconf errors using homebrew and proper environment setup."
---
So, I was updating ruby etc on my Lion box, and I ran into a few issues.
<!--more-->

First off, I'm using <a href="http://kennethreitz.com/xcode-gcc-and-homebrew.html">Apple's commandline tools</a>. I found that I needed to <code>export CC=/usr/bin/gcc</code> before RVM would work.
Then it tossed an "<code>rvm requires autoreconf to install the selected ruby interpreter however autoreconf was not found in the PATH.</code>" error.
Well, <code>brew install automake</code> seem to fix that little kink. (Wait, you don't have <a href="http://mxcl.github.com/homebrew/">homebrew</a>? Well, go get it!)
So, now I'm fully updated on RVM and ruby.