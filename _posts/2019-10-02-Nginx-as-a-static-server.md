---
id: 15590
title: Nginx as a static site server on Heroku
date: 2019-10-03
author: Greg Nokes
layout: post
guid: http://greg.nokes.name/?p=15590
permalink: /2019/10/03/nginx-as-a-static-server-on-heroku/
categories:
  - Computers! and Code!
---

I was doing some preformance testing on this site, and while I was impressed, I felt like I could wring some more preformance out of it.  I decided to swtcih from heroku's [Static Buildpack](https://github.com/heroku/heroku-buildpack-static) to a simple Nginx webserver using Heroku's nice [Nginx Buildpack](https://github.com/heroku/heroku-buildpack-nginx). In theory this should be a little qucker and lighter.

<!--more-->

The first step was to get Nginx set up on the Heroku App. I had the static buildpack already, so moving to the Nginx buildpack took a few steps.

First I create a `config` directory and put my `nginx.conf.erb` file in it. The Nginx buildpack will grab that file, process it, and then use it to run Nginx on the dyno. I found this config to work well:


	daemon off;
	# Heroku dynos have at least 4 cores
	worker_processes <%= ENV['NGINX_WORKERS'] || 4 %>;
	events {
	  use epoll;
	  accept_mutex on;
	  worker_connections <%= ENV['NGINX_WORKER_CONNECTIONS'] || 1024 %>;
	}
	
	http {
	  gzip on;
	  gzip_comp_level 2;
	  gzip_min_length 512;
	  
	  server_tokens off;
	   
	  log_format main '$time_iso8601 - $status $request - client IP: $http_x_forwarded_for - <%= ENV['DYNO'] %> to $upstream_addr - upstream status: $upstream_status, upstream_response_time $upstream_response_time, request_time $request_time';
	  access_log /dev/stdout main;
	  error_log /dev/stdout notice;
	  log_not_found on;
	  include mime.types;
	  
	  default_type application/octet-stream;
	  sendfile on;
	  
	  # Must read the body in 5 seconds.
	  client_body_timeout <%= ENV['NGINX_CLIENT_BODY_TIMEOUT'] || 5 %>;
	  
	  server {
	    listen <%= ENV["PORT"] %>;
	  
	    error_page 404 /404.html;
		error_page 403 /403.html;
	  
	    port_in_redirect off;
	  
	    location / {
		    root _site/;
	    }
	  }
	}

The important parts are the `port_in_redirect off;` and the `root _site/;` directives. The `port_in_redirect` tells Nginx to not embed it's port into any redirects, and `root` tells Nginx where the static files are.

Well, is it fast?

I ran `ab` on the site again, and there is a large improvment. Larger then I expected.

The old configuration had a perc99 under load of 1.7 seconds per request, and the new has a perc99 of 0.6 seconds. More then a second per request faster!

**Old Config**

	Concurrency Level:      100
	Time taken for tests:   7.284 seconds
	Complete requests:      1000
	Failed requests:        0
	Total transferred:      6922000 bytes
	HTML transferred:       6722000 bytes
	Requests per second:    137.28 [#/sec] (mean)
	Time per request:       728.426 [ms] (mean)
	Time per request:       7.284 [ms] (mean, across all concurrent requests)
	Transfer rate:          928.00 [Kbytes/sec] received
	
	Connection Times (ms)
	              min  mean[+/-sd] median   max
	Connect:      307  449 233.8    380    1612
	Processing:   103  204  84.1    212    1026
	Waiting:      103  201  83.5    211    1026
	Total:        424  653 247.2    591    1939
	
	Percentage of the requests served within a certain time (ms)
	  50%    591
	  66%    627
	  75%    658
	  80%    670
	  90%    822
	  95%   1084
	  98%   1738
	  99%   1769
	 100%   1939 (longest request)


**New Config**

	Concurrency Level:      100
	Time taken for tests:   26.680 seconds
	Complete requests:      5000
	Failed requests:        0
	Total transferred:      34870000 bytes
	HTML transferred:       33650000 bytes
	Requests per second:    187.41 [#/sec] (mean)
	Time per request:       533.592 [ms] (mean)
	Time per request:       5.336 [ms] (mean, across all concurrent requests)
	Transfer rate:          1276.36 [Kbytes/sec] received
	
	Connection Times (ms)
	              min  mean[+/-sd] median   max
	Connect:      297  385  42.1    378     620
	Processing:   102  136  33.6    122     641
	Waiting:      102  133  30.5    120     641
	Total:        424  520  51.2    506     986
	
	Percentage of the requests served within a certain time (ms)
	  50%    506
	  66%    524
	  75%    536
	  80%    544
	  90%    577
	  95%    643
	  98%    685
	  99%    696
	 100%    986 (longest request)


**But what about SSL?**

One of the things that I really liked about the Static Buildpack is that it is based on Rack, and I could use the `rack-ssl-enforcer` gem to make sure that all requests were directed to the encrypted version of the site. I did some investigation and found the following stanza would work with the Heroku router:

    STANZA HERE
	

A redirect would be preferable, however since we are behind the Heroku Router, a simple redirect seems to enter into an infinite redirect loop. This slows down processing considerably.
