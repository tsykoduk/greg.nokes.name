---
id: 15250
title: Borked Filesystems
date: 2010-03-29T20:47:52+00:00
author: tsykoduk
layout: post
guid: http://greg.nokes.name/?p=15250
permalink: /2010/03/29/15250/
categories:
  - Computers! and Code!
tags:
  - all your eggs in one basket
  - backups
  - disk partitioning
---
In a recent <a title="Removing Viruses from a PC That Won’t Boot —  Krebs on Security" href="http://www.krebsonsecurity.com/2010/03/removing-viruses-from-a-pc-that-wont-boot/">blog</a> post, <a title="About the Author —  Krebs on Security" href="http://www.krebsonsecurity.com/about/">Brian Krebs</a> mentions the following:
<blockquote>I also urge users to segment their systems so that important data files are on a separate chunk of hard drive space than the Windows operating system, which tends to make restoring backups a far simpler affair.</blockquote>

This is fantastic advice, and should be followed by every operating system rather then just Windows. I've espoused this method for years, and have actually gotten some grief about it.

I think this should into the "duh" category, but so many people opt for the easy and less safe monolithic partioning scheme (I'm looking at you, @mystic). If your OS implodes, and you have to re-install, it's much easier to just wipe and reinstall the O/S partition and not worry about the user data in the /home partition. This does not in any manner replace the needs for backups - your /home partition could just as easily implode.

The event that really pressed this home for me was watching an old DOS 5 machine unravel when it's FAT table got really confused. We ended up having to format from floppy, and reinstall everything. Total loss of all data.