---
id: 827
title: Howl and Bonjour, Together Forever!
date: 2005-08-30T20:47:41+00:00
author: tsykoduk
layout: post
guid: 30/2008/12/27/howl-and-bonjour-together-forever
permalink: /2005/08/30/howl-and-bonjour-together-forever/
categories:
  - Computers! and Code!
---
<p>So - as my regular readers know, I have <a href="http://www.apple.com/switch/">switched</a> from Linux for my main OS at home. One of the reasons I jumped to Linux was due to my frustration with Windows 98's issues. Yeah - that kind of dates me. My journey with Linux was wonderful. I still love the OS. However after the second Ink jet that I got failed to work with parts of it, I gave up. I work on problematic computers at work (windows 2000 mainly) and I really Just Wanted Stuff to Work at home.</p>


<p>Enter Mac <span class="caps">OS X</span>. The hardware was sexy (even before this Switch, I wanted a PowerBook), and the promise of stuff just working was really enticing. So, I got a Mac Mini. Even before I had left the store, I had bumped the <span class="caps">RAM</span> to 1 gig (the most it could handle). Got it home, and was like a kid at christmas.</p>


<p>First step - use the included CD to upgrade to Tiger. No problem. Worked right out of the box. Well, after a month of using Tiger and the Mini, I had made up my mind. Next was the Powerbook. Sweet machine. really sweet.</p>


<p>Anyways, to bring this back onto topic, I was left with several linux boxes laying about the house. I sold one to a friend for use as a firewall (nudge, nudge?). One was left behind (future web-server for the house) and the 1.6 gig machine was sitting, all alone. Busted out a new 250g <span class="caps">HDD</span> for it, and slapped it in. (Gawd, I love linux. Had it installed, configured, formated and data copied in about 10 minutes).</p>


<p>Now, the hard part. How to make Linux speak Mac. After some research, I found that Mac uses <span class="caps">AFP</span> (still) as their native file sharing protocol. Bonjour is used to discover services on the fly. So, my linux box needed to speak those two languages.</p>


<p>(warning - geekspeak follows!)</p>

<!--more-->


<p>The Linux Box: Dell 1.6g <span class="caps">P4 768</span> megs <span class="caps">RAM</span>, 1 20g <span class="caps">HDD</span> (/, boot, home, usr, var, etc) 1 250g <span class="caps">HDD</span> (/share). 1 Netgear 10/100/1000 <span class="caps">NIC</span>. Ubuntu Linux - Hoary Hedgehog all security patches etc.</p>


<p>So, first things first, let's let appletalk running. Open Synaptic, and get netatalk. install it. presto.</p>


<p>Edit the /etc/default/netatalk file and turn off everything except afp</p>


<p>Next, we need to install Bonjour - called Howl under Linux. So, get howl-utils and mdnsresponder.</p>


<p>Edit the /etc/mdnsresponder/mDNSresponder.conf file and add a few lines to define your services</p>


<p>Add the services that you need - the one thing that took me a while to figure out is that afp is called afpovertcp and you need to put a .local after the servername</p>


<p>Restart both /etc/init.d/netatalk and mdnsresponder</p>


<p>That should do it for you.</p>


<p>There are some good howtos out there - I like this <a href="http://viebrock.ca/article/22/file-sharing-from-linux-to-os-x-a-quick-guide">one</a>  quite a bit. Google is your friend!</p>


<p>I've been giving the protocol stack a good workout - I had 3 copies going at once (a 13 gig, a 5 gig and a 500 meg) and the box just keeps slurping it up.</p>