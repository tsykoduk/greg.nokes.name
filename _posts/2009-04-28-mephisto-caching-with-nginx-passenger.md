---
id: 10512
title: Mephisto Caching with Nginx/Passenger
date: 2009-04-28T00:45:00+00:00
author: tsykoduk
layout: post
guid: 30/2009/04/28/mephisto-caching-with-nginx-passenger
permalink: /2009/04/28/mephisto-caching-with-nginx-passenger/
categories:
  - Computers! and Code!
tags:
  - linkedin
  - nginx
---
Now that I had this test bed for new hotness running the new hotness, I decided I should get the caching working again.

            <!--more-->

            Well, this is 2.0 of the code. This seems to work a lot better (like, works in general).


<pre>
server {

  listen  80;
  server_name  some_spiffy_name;
  root /wheremyappis/public;

  access_log /somelogfile.access.log main;
  error_log /someotherlog.error.log notice;
  client_max_body_size  50M;
  passenger_enabled on;

   location /assets/ {
        rewrite ^/assets/(.*)$ /assets/$http_host/$1 break;
   }

   location /cache/ {
        rewrite ^/cache/(.*)$ /cache/$http_host$1 break;
   }

}

</pre>

And, as an added bonus, it's much easier to read!


Thanks to mibb in <span class="caps">IRC</span>, we were able to hack the following out:


<pre>server {

  listen  80;
  server_name d;
  access_log ;
  error_log ;

  root ;
  passenger_enabled on;

location /assets/ {
  rewrite ^/assets/(.*)$ /assets/$http_host/$1 break;
}

# this appears to be broken
# / -&gt; index.html
#  if (-f $document_root/cache/$host$uri/index.html) {
#    rewrite (.*) /cache/$host$1/index.html break;
#  }

# /about -&gt; /about.html
  if (-f $document_root/cache/$host$uri.html) {
    rewrite (.*) /cache/$host$1.html break;
  }

# other files
  if (-f $document_root/cache/$host$uri) {
    rewrite (.*) /cache/$host$1 break;
  }

}</pre>