---
id: 8513
title: Cups vs Avahi vs Mac
date: 2009-02-24T19:00:00+00:00
author: tsykoduk
layout: post
guid: 30/2009/02/24/cups-vs-avahi-vs-mac
permalink: /2009/02/24/cups-vs-avahi-vs-mac/
categories:
  - Computers! and Code!
tags:
  - linkedin
---
<p>I have an old HP Laser Jet 6L as my primary printer at home. It's a trooper - I got it new years ago, and I have never had a problem with it. A few years ago, I got an <span class="caps">APC</span> Parallel Port to <span class="caps">USB</span> converter. That works great, until I tried to plug it unto my new Airport Express 802.11n. Woops. Lucky me I have a Linux box right next to the printer..</p>

            <!--more-->

            <p>So the box was running Debian Etch and a Half. I had Netatalk and Avahi running on it with a custom compiled netatalk including <span class="caps">SSL</span> support for <span class="caps">DHX</span> authentication.</p>


<p>I plugged the printer in, <span class="caps">CUPS</span> saw it, and presto. But when I went to add it to my mac, I could not browse for it. No problem, right? add it to Avahi. No sweat.</p>


<p>Not so much. Total <span class="caps">PITA</span>. However in my searching, I found this <a href="http://blog.venthur.de/2007/08/17/howto-setup-a-print-server-for-windows-and-others-using-cups-and-zeroconf/">article</a>.</p>


<blockquote><b>First you need to install <span class="caps">CUPS 1</span>.3 or higher</b> on your print server and setup the printer (the web interface makes this task dead easy) </blockquote>

<p>Ug, Etch is running at <span class="caps">CUPS 1</span>.2.x. With a little research, however I find that <a href="http://www.debian.org/releases/stable/">Debian Lenny</a> has <a href="http://packages.debian.org/lenny/cups"><span class="caps">CUPS 1</span>.3.x</a>. Lenny was also released as stable a few days ago, so it might be a good time to upgrade my server.</p>


<p>Did I mention how much I love debian?</p>


<p>So here are the steps to upgrade:</p>


<p>1) Edit <code>/etc/apt/sources.list</code>. Take all of the instanced of <code>etch</code> and replace with <code>lenny</code></p>


<p>2) Run <code>sudo apt-get install apt dpkg aptitude</code> to upgrade apt and aptitude.</p>


<p>3) Run <code>aptitude full-upgrade</code>. I ran it three times (until it did not pick up any new packages). You'll need to keep an eye on this, as it will ask you several questions, and some of them are quite important (do you want to revert <code>importantconfigfile.conf</code> to the maintainers version or keep your own?)</p>


<p>So after all of that, I restarted <span class="caps">CUPS</span> and presto - printer showed up in my Mac's printer browser.</p>