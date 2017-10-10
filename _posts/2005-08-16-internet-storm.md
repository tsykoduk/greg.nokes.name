---
id: 757
title: Internet Storm!
date: 2005-08-16T20:24:01+00:00
author: tsykoduk
layout: post
guid: 30/2008/12/27/internet-storm
permalink: /2005/08/16/internet-storm/
categories:
  - Computers! and Code!
---
<blockquote><span class="caps">CNN</span> reported a worm outbreak this afternoon involving their network, ABCNews, NYTimes, as well as Capitol Hill.

		<p>Information is still flowing on this situation, but here's what we have so far:</p>


		<p>Symantec just released info on the <span class="caps">W32</span>.Zotob.E worm here.</p>


		<p>Trend Micro also released information under <span class="caps">WORM</span>_RBOT.CBQ.</p>


		<p>McAfee released information as well: <span class="caps">W32</span>/IRCbot.worm</p>


		<p>This is an <span class="caps">IRC</span> bot worm, and will scan for <span class="caps">TCP</span> port 445, and for file shares. McAfee reports in it's bulletin that systems not patched for <span class="caps">MS05</span>-039 will continually reboot.</p>


		<p>It exploits known vulnerabilities, and the patch is available from microsoft here: Microsoft Security Bulletin <span class="caps">MS05</span>-039</p>


		<p>More updates coming as we analyze and gather more information!</blockquote></p>


		<p>From the <a href="http://isc.sans.org/index.php?on=port"><span class="caps">SANS</span> Internet Storm Center</a></p>


		<p>Hope ya'll patched your Windows boxes. If not, get to work! I have already noticed some slowness on the internet - possibly because the cable modem segment that I am on is filled with unprotected Windows boxes.</p>


		<p>Let me check my home network...</p>


		<p>2 Macs - Check
	1 Linux - Check</p>


		<p>All done!</p>


		<p>What is totally silly about this is that the worm exploits the windows Plug and Play system via port 445. A big <span class="caps">WTF</span> goes out to the guys in Redmond:  why does Plug and Play need to access <em>any</em> IP ports? Unless ya'll are using PnP to mount network drives - but come on. No one would be...</p>


		<p>Well, perhaps they are?</p>