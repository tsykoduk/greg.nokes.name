---
id: 10778
title: Firefox vs Safari
date: 2009-04-24T05:06:00+00:00
author: tsykoduk
layout: post
guid: 30/2009/04/24/firefox-vs-safari
permalink: /2009/04/24/firefox-vs-safari/
categories:
  - Computers! and Code!
tags:
  - linkedin
---
People chide me on my choice of Safari over Firefox on my macs, but here is a reason why….

<!--more-->

So, when I was hacking together the layout for this blog, I noticed something weird. I had a tweet with a really really long “hashtag” in it. Like this:

<img src="http://greg.nokes.name/assets/2009/4/24/Picture_3.png" alt="" />

Obviously, the text ran out side of the sidebar, and looked ugly. <a href="http://lmgtfy.com/?q=css+force+text+width">Google</a> to the rescue. I found some cool <span class="caps">CSS</span> v3 stuff that would fix it.
<pre><code>
        text-wrap: unrestricted;
        word-wrap: break-word;
</code></pre>
Worked like a Charm under Safari. Just like the <span class="caps">CSS</span> v3 docs said it should.

<img src="http://greg.nokes.name/assets/2009/4/24/Picture_4.png" alt="" />

but not so much under Firefox. I was forced to add
<pre>overflow: hidden;</pre>
and get this…

<img src="http://greg.nokes.name/assets/2009/4/24/Picture_1.png" alt="" />

Sigh.