---
id: 15710
title: Setting up ISC's DHCPD on MacOS
date: 2020-03-28
author: Greg Nokes
layout: post
guid: http://greg.nokes.name/?p=15710
permalink: /2020/03/03/isc-dhcpd-6/
categories:
  - Mundane
---


One of the frustrations with my current WiFi setup is that the router is very inflexible. For example, it would not allow me to set the Domain Name servers that I wanted to use for my internal devices. It would only deliver the DNS servers that my internet provider delivered to it. And who wants that?

<!--more -->

Well, since I have set up many DHCP (Dynamic Host Control Protocol) servers in the past, I did not think this would be a problem. I have an older Mac that I could use, as it stays plugged into the network and is already operating as a Apple iCloud Cache.

I also wanted to be able to deliver IPv6 DNS servers to my machines as well.

Well, it was not quite as easy as I thought it was going to be. I had to learn how to use `launchctl` and `launchd`. I come from a background of using `init` and `systemd` so I *assumed* this would be fairly easy. Here are the steps that I found to work on a machine running 10.15. I set up IPv4 first, so the steps will walk you through that first.

**Step 1**

Install the DHCP server via brew.

``
~ ☯ brew install isc-dhcp
``

**Step 2**

Set up the IPv4 plist and config files.





hat tip to (Steven Diver)[https://stevendiver.com/2020/02/19/install-isc-dhcp-on-macos-catalina/] for the syntax for the `org-isc-dhcpd.plist` file

TODO - shout out to ^ when twitter posting article
