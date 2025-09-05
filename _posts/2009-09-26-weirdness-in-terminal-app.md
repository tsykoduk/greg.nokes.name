---
id: 810
title: Weirdness in terminal.app
date: 2009-09-26T21:35:08+00:00
author: tsykoduk
layout: post
guid: https://greg.nokes.name/?p=810
permalink: /2009/09/26/weirdness-in-terminal-app/
categories:
  - Computers! and Code!
tags:
  - linux
  - OSX
  - rxvt
  - terminal
excerpt_separator:  <!--more-->
---
I have run into this three or four times now. Each time takes some googling, and that is counterproductive. So here you go. For all of the times you get a new mac, or install a new version of OSX, and you start seeing weirdness in terminal.app while SSH'd into a *nix box..

<!--more-->

Through trial-and-error, this seems to be the best way to unbreak the Backspace key on a Mac when using the native Terminal.app to SSH to a (Debian) Linux machine, and then running Emacs inside a Screen session.

Open Terminal - Preferences

Declare terminal type ($TERM) as: rxvt

Open Terminal - Window Settings

Choose Keyboard panel

Uncheck "Delete key sends backspace"

  (i.e., this setting is "off")

Click button "Use Settings as Defaults"

This way, you shouldn't have to mess with stty; you'll still get all the features of xterm-color (ANSI color text, screen save/restore, etc.); and the Backspace key will work normally, even in this situation:
Terminal.app - SSH (to Debian box) - Screen - Emacs

Under Snow Lepoard - you do not need to mess with the Uncheck Delete key stuff.

Thanks, <a href="http://chad.glendenin.com/macosx-backspace.html">Chad</a>!