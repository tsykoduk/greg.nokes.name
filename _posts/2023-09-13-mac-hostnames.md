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

One quirk that consistently bothers me with mDNS on Mac is how it handles hostnames. If the Mac system thinks another device is already using its designated name, it automatically attaches a numerical suffix to the hostname.

<!--more-->

Now, for those running just a single Mac, this might sound like a minor inconvenience. But when you manage multiple Macs or Mac-based servers, this issue can escalate quickly. Especially if your Macs are multi-homed. For example, my Mac Mini's have an Ethernet and Wifi connection. The servers may also have access to several VLAN's via their Ethernet connection.

I operate an older Mac Mini as a server, and I'm fairly meticulous about my machine names. This is a trait honed over two decades in system administration. These auto-appended numerical suffixes are more than just an annoyance; they interfere with my TimeMachine backups and sometimes disrupt my file sharing setup.

Just last night, I had to reboot various components of my local network, thanks Comcast, and it sent my Mac devices into a hostname-induced tailspin. The repercussions were immediate: my TimeMachine backups failed, and my hostnames got saddled with bizarre numerical appendages like "3873."

I'd known for a while that there's a command-line fix for this issue, and the chaos of last night finally nudged me to write a script to automate fixing it.

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
