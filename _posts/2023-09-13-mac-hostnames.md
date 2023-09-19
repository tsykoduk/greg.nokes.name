---
id: 16970
title: Mac Hostnames
date: 2023-09-13
author: Greg Nokes
layout: post
guid: http://greg.nokes.name/?p=16970
permalink: /2023/09/13/mac-hostnames/
categories:
  - Computers! and Code!
excerpt_separator: <!--more-->
---

<div style="float: left; padding: 10px 10px 10px 10px;"><img src="/binaries/2023/09/mac-hostnames.png" width="150" alt=" Balanced Rocks"><br />
<sub><i>Image by <a href="https://greg.nokes.name/">Me</a></i></sub></div>

One quirk that irks me about mDNS on Mac systems relates to the hostname behavior upon startup. Specifically, if the Mac believes another device is using its name, it appends a numerical suffix to the hostname.

<!--more-->

Now, if you're only running a single Mac, this might seem like a trivial concern. However, if you run a fleet, or have an older Mac Mini as a server this can become a problem. And let's just say I'm particular about my machine names. This likely stems from two decades of experience in system administration. These unexpected numerical suffixes wreak havoc on my TimeMachine backups and file shares, serving as a intermittent irritant.

Last night, I had to reboot several parts of my local network (courtesy of Comcast), which sent all my Macs into a naming frenzy. The fallout was immediate: failed TimeMachine backups and hostnames that suddenly included random numbers like "3873."

I've been aware that there's a command-line solution to reset the hostname, and last night's network chaos finally pushed me to script it.

```bash
#!/usr/bin/env bash

#Use to set all of the hostnames on a mac to the same thing.

# Set your HOSTNAME to what you want your hostname to be
HOSTNAME="NEW-COMPUTER-NAME"


#let's look
scutil --get HostName
scutil --get LocalHostName
scutil --get ComputerName

#let's change
sudo scutil --set HostName $HOSTNAME
sudo scutil --set LocalHostName $HOSTNAME
sudo scutil --set ComputerName $HOSTNAME
sudo dscacheutil -flushcache

#let's verify
scutil --get HostName
scutil --get LocalHostName
scutil --get ComputerName
```

I just drop this script on each machine, with the HOSTNAME variable set to the correct hostname. Every few months when something gets wonky, I run the script and presto - things are better.
