---
id: 620
title: PHP and Nginx on Debian
date: 2009-01-08T15:18:00+00:00
author: tsykoduk
layout: post
guid: https://greg.nokes.name/?p=620
permalink: /2009/01/08/php-and-nginx-on-debian/
categories:
  - Computers! and Code!
description: "Learn how to install and configure PHP5 with Nginx web server on Debian Linux, including fixing common FastCGI configuration issues for a smooth setup."
---
<p>I needed to drop <span class="caps">PHP5</span> on a home dev box (running Debian Stable) and since Nginx is all the rage, I wanted to see if I could use that instead of apache.</p>

<!--more-->

<p>I found a great <a href="http://jit.nuance9.com/2008/01/serving-php5-with-nginx-on-ubuntu-710.html">article</a> on how to get r done. There were a few gotcha's that I ran into, but honestly, it worked like a charm.</p>


<p>The largest issue was that the line:</p>


<code>fastcgi_param SCRIPT_FILENAME /var/www/nginx-default$fastcgi_script_name</code>

<p>was truncated to</p>


<code>fastcgi_param SCRIPT_FILENAME /var/www/nginx-default$fastcgi_script_</code>

<p>So I cleaned that up, and ended up with</p>


<code>fastcgi_param SCRIPT_FILENAME /var/www/$fastcgi_script_name</code>

<p>and Bam. Chili Fries.</p>