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

	~ ☯ brew install isc-dhcp

**Step 2**

Set up the IPv4 plist and config files.

The config file was pretty simple: 


	# dhcpd.conf
	#

	default-lease-time 600;
	max-lease-time 7200;

	# Use this to enble / disable dynamic dns updates globally.
	#ddns-update-style none;

	# If this DHCP server is the official DHCP server for the local
	# network, the authoritative directive should be uncommented.
	authoritative;

	# Use this to send dhcp log messages to a different log file (you also
	# have to hack syslog.conf to complete the redirection).
	#log-facility local7;


	# My First Subnet
	subnet 192.168.1.0 netmask 255.255.255.0 {
	  range 192.168.1.10 192.168.1.200;
	  option domain-name-servers 1.1.1.1, 1.0.0.1;
	  option routers 192.168.1.1;
	  option broadcast-address 192.168.1.255;

	  # Let's let folks keep their IP's for a while
	  default-lease-time 6000;
	  max-lease-time 72000;
	}

Next up was getting it installed as a service. The `brew` stuff was unhelpful, and, honestly I wanted to play with the underlying plist files anyways.

After some gnashing of teeth and frantic googling, I came across a helpful article by (Steven Diver)[https://stevendiver.com/2020/02/19/install-isc-dhcp-on-macos-catalina/] that outlined the syntax of the `org-isc-dhcpd.plist` file.

Anyway, this is what I came up with:

	<?xml version=\"1.0\" encoding=\"UTF-8\"?>
	<!DOCTYPE plist PUBLIC \"-//Apple Computer//DTD PLIST 1.0//EN\" \"http://www.apple.com/DTDs/PropertyList-1.0.dtd\">
	<plist version=\"1.0\">
	<dict>
	     <key>Label</key>
	          <string>org.isc.dhcpd</string>
	     <key>OnDemand</key>
	          <false/>
	     <key>ProgramArguments</key>
	          <array>
	          <string>/usr/local/sbin/dhcpd</string>
	          <string>-q</string>
	          <string>-f</string>
	          </array>
	     <key>RunAtLoad</key>
	          <true/>
	     <key>ServiceDescription</key>
	          <string>ISC DHCP Server</string>
	</dict>
	</plist>

Next I figured out that I had to load the plist, and then it would hopeful start up.

	~ ☯ sudo launchctl load /Library/LaunchDaemons/org.isc.dhcpd.plist

I could then use `sudo launchctl list |grep dhcp` to see that the service was in fact started. I also rebooted the machine to insure that it would survive a reboot - no one wants their DHCP server vanishing, right?

**Step 3**

Next up was setting up IPv6.


TODO - shout out to ^ when twitter posting article
