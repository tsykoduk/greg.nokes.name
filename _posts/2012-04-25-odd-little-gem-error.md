---
id: 1010
title: Odd little gem error
date: 2012-04-25T17:00:37+00:00
author: tsykoduk
layout: post
guid: https://greg.nokes.name/?p=1010
permalink: /2012/04/25/odd-little-gem-error/
categories:
  - Computers! and Code!
excerpt_separator:  <!--more-->
---
<p>While hacking at my favorite <a href="http://www.afktavern.com/">tavern</a>, I noted that I needed to update a gem file. When I tried, gem said that it had succeeded, but there were some odd little errors:</p>

<!--more-->

<script src="https://gist.github.com/2494561.js"> </script>
<p>And the gem had not incremented it's version. Hmm.</p>
<p> I decided to fire up my hotspot and see if that changed anything, and yup. Bingo. Success. Gem updated! Best I can figure they are blocking something that gem needs. So, if I had found this article before that, I would have saved myself 20 minutes of troubleshooting.</p>