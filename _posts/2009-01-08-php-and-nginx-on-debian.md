---
id: 8142
title: PHP and Nginx on Debian
date: 2009-01-08T15:18:00+00:00
author: tsykoduk
layout: post
guid: 30/2009/01/08/php-and-nginx-on-debian
permalink: /2009/01/08/php-and-nginx-on-debian/
categories:
  - Computers! and Code!
---
I needed to drop <span class="caps">PHP5</span> on a home dev box (running Debian Stable) and since Nginx is all the rage, I wanted to see if I could use that instead of apache.

            <!--more-->

            I found a great <a href="http://jit.nuance9.com/2008/01/serving-php5-with-nginx-on-ubuntu-710.html">article</a> on how to get r done. There were a few gotcha's that I ran into, but honestly, it worked like a charm.


The largest issue was that the line:


<code>fastcgi_param SCRIPT_FILENAME /var/www/nginx-default$fastcgi_script_name</code>

was truncated to


<code>fastcgi_param SCRIPT_FILENAME /var/www/nginx-default$fastcgi_script_</code>

So I cleaned that up, and ended up with


<code>fastcgi_param SCRIPT_FILENAME /var/www/$fastcgi_script_name</code>

and Bam. Chili Fries.