---
id: 1765
title: Windows Vista Content Protection specification
date: 2006-12-23T03:37:00+00:00
author: tsykoduk
layout: post
guid: 30/2008/12/27/windows-vista-content-protection-specification
permalink: /2006/12/23/windows-vista-content-protection-specification/
categories:
  - Computers! and Code!
  - Science!
---
<a href = "http://www.cs.auckland.ac.nz/~pgut001/" >Peter Gutmann</a> wrote an <a href = "http://www.cs.auckland.ac.nz/~pgut001/pubs/vista_cost.txt" >interesting article</a> about Windows Vista's content protection protocols that really deserves a good read...

<blockquote>Windows Vista includes an extensive reworking of core OS elements in order to provide content protection for so-called "premium content", typically HD data from Blu-Ray and HD-DVD sources.  Providing this protection incurs considerable costs in terms of system performance, system stability, technical support overhead, and hardware and software cost.  These issues affect not only users of Vista but the entire PC industry, since the effects of the protection measures extend to cover all hardware and software that will ever come into contact with Vista, even if it's not used directly with Vista (for example hardware in a Macintosh computer or on a Linux server).  This document analyses the cost involved in Vista's content protection, and the collateral damage that this incurs throughout the computer industry.</blockquote>

Some of the details in the article are down right scary, for example

<blockquote>Once a weakness is found in a particular driver or device, that driver will have its signature revoked by Microsoft, which means that it will cease to function (details on this are a bit vague here, presumably some minimum functionality like generic 640x480 VGA support will still be available in order for the system to boot).  This means that a report of a compromise of a particular driver or device will cause all support for that device worldwide to be turned off until a fix can be found.</blockquote>

Read that last sentence again. This cannot be true, can it?

Yes, it is. According to Microsoft's White Paper, <a href="http://www.google.com/url?sa=t&amp;ct=res&amp;cd=1&amp;url=http%3A%2F%2Fdownload.microsoft.com%2Fdownload%2Fa%2Ff%2F7%2Faf7777e5-7dcd-4800-8a0a-b18336565f5b%2Fpnp-driver.doc&amp;ei=3kyMRZzaLqiUgAOY9tigDw&amp;usg=__eFShNs4H156r9HezjkpUnMRAuiQ=&amp;sig2=slDaITf7O8Z3UCecdzcW7g">Driver Package Integrity during Plug and Play Device Installations in Windows Vista</a>

<blockquote>If users want to play next-generation premium content on Windows Vista, such as HD DVD and other formats that are licensed under the Advanced Access Content System (AACS) specification, all kernel-mode components on their system must be signed. That means that, if an administrative user chooses to install an unsigned or altered driver, the system is not allowed to play premium content</blockquote>

Wow.

Choose anything but Vista. Run as fast as you can from it. Microsoft of Borg is coming, and they think they own your hardware.

Oh yeah, and Merry Christmas!

<i>Update</i>

I was thinking more about this. I wanted to take a second and explain it more directly.

1) I buy a high end sound card, who's manufacturer has not payed the Microsoft tax, so their driver is not signed by Microsoft.

2) I buy some Microsoft designated 'premium content' - say Jose and the Pussycats on Blue-ray.

3) I play my new Blue-ray disc on my computer with the OS that I bought.

No sound. 

Microsoft has not blessed the folks who built my sound card with a certificate, so Microsoft decides that I cannot play the movie that I bought on the computer that I bought, using the OS that I payed good money for.

Uh. No. Sorry - I will not play <b>that</b> game. If I buy a freaking movie, I want to watch it on the hardware that I choose.