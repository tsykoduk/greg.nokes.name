---
id: 640
title: iTunes Backups
date: 2009-01-12T06:10:00+00:00
author: tsykoduk
layout: post
guid: https://greg.nokes.name/?p=640
permalink: /2009/01/12/itunes-backups/
categories:
  - Computers! and Code!
description: "Learn how to create automated iTunes backups on Mac OS X Tiger using rsync and periodic scripts to safely backup your movie library to network storage."
---
Now that we are starting to buy / rent movies on our Apple TV, I wanted to have a seamless backup mechanism. The fact that we are running Tiger made it a little more challenging, along with my distain for <span class="caps">COTS</span> software. After all, all I really want to do is keep 2 copies of 1 (rather large) directory else where on the network...

<!--more-->

So, I have a 750gb disk on my AirPort Extreme as a backup target for the Leopard laptops in the house. TimeMachine loves to automagically attach and back up all the time. I do not have the luxury of Time Machine on my iTunes server, as it's hosted on an old powerbook running Tiger (lappy for long time readers). Knowing that Mac <span class="caps">OSX</span> has rsync by installed by default, I thought that it should be a trivial task to just rsync the data over to the AirPort.

<code>rsync -r --eahfs --showtogo * /Volumes/backup/itunes/</code> Seems to work like a charm! <code>--eahfs</code> tells rsync to maintain the extended <span class="caps">HFS</span> attributes, and <code>--showtogo</code> gives us a progress indicator. (by the way, for all you linux geeks out there, <code>--progress</code> shows progress on my Debian box). <em>Note: we assume that you have mounted the backup volume and created an itunes directory on it</em>.

Macs have this wonderful directory <code>/etc/periodic</code>. You can guess what it does. I dropped my daily script into the <code>/etc/periodic/daily</code> directory, and the weekly script into <code>/etc/periodic/weekly</code>. Could not be easier.
The two scripts simply backup to different directories on the backup volume (<code>itunes.wky</code> and <code>itunes.dly</code>). Presto, quick and dirty backups.

Next week, I add error checking and email reporting to the mix.

<strong>Daily code</strong>

```bash
#!/bin/bash

#backup of itunes directory to shared HDD on networky

#daily backup
rsync -r --eahfs /Volumes/monolith/iTunes/* /Volumes/backup/itunes.dly/
```

<strong>Weekly code</strong>

```bash 
#!/bin/bash

# backup of itunes directory to shared HDD on networky

# Weekly backup
rsync -r --eahfs /Volumes/monolith/iTunes/* /Volumes/backup/itunes.wky/
```