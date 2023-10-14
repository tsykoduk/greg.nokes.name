---
id: 15690
title: Nginx Routing on Heroku
date: 2020-02-27
author: Greg Nokes
layout: post
guid: http://greg.nokes.name/?p=15690
permalink: /2020/02/27/nginx-routing-on-heroku/
categories:
  - Computers! and Code!
---

Sometimes, we want to be able to route requests based on URL paths easily, or have a front end app that serves data from private back end services.

<!-- more -->

For example, if you have several services in a Private Space that serve HTML, you might not want to expose them to the internet, and rather have a routing app in front which will handle this. Or you might want to route your asset delivery to S3, and completely offload that processing from the local app server. Nginx is a powerful, fast and lightweight web server which can also operate as a reverse proxy. It also runs well on Heroku.

For this example, we will set up 3 apps

- ggn-nginx-router-test
- ggn-nginx-test-target
- ggn-nginx-test-blog

ggn-nginx-router-test will be running Nginx, with configs set to route requests back to the target app.
ggn-nginx-test-target will simply deliver HTML with the requestors HTML headers.
ggn-nginx-test-blog will simply be a second HTML target.

**Setup nginx-test-target**

Install PHP and Composer Locally (`brew install php && brew install composer` on a Mac)

Set up your working directory in your code directory:

```bash
mkdir test-target
cd test-target
git init . && git checkout -b main
heroku create ggn-nginx-test-target
```

Set up a `.gitignore` file:

```
/vendor/
```

Create a `Procfile`:

```
web: vendor/bin/heroku-php-apache2
```

Create a `composer.json` :

```json
{
  "require": {},
  "require-dev": {
    "heroku/heroku-buildpack-php": "*"
  }
}
```

Run `composer update` and then create an `index.php`:

```php
<h1>This is not a Blog<br />
Requestor Headers:</h1>
<br />
<?php foreach (getallheaders() as $name => $value) {
  echo "$name: $value\n<br />";
}
?>
```

**Setup nginx-router-test**

Set up your working directory in your code directory:

```bash
mkdir router-target
cd router-target
git init . && git checkout -b main
heroku create ggn-nginx-router-test
```

Add the nginx buildpack:

```bash
heroku buildpacks:add https://github.com/heroku/heroku-buildpack-nginx

Buildpack added. Next release on ggn-nginx-router-test will use heroku-community/nginx.
Run git push heroku master to create a new release using this buildpack.
```

Add a `Procfile`:

```
web: bin/start-nginx-solo
```

Add a Nginx config file. We use an `.erb` file as the build pack will process it, and generate a finished config file out of it. It needs to go in `config/nginx.conf.erb`

```conf
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

  upstream upstream_production {
    server ggn-nginx-test-target.herokuapp.com;
  }

  server {
    listen <%= ENV["PORT"] %>;
    server_name _;

    location / {
      set $upstream upstream_production;
      proxy_pass http://$upstream;
      proxy_set_header x-forwarded-host $host;
      proxy_set_header Host ggn-nginx-test-target.herokuapp.com;
    }

  }
}
```

You should now be able to hit [ggn-nginx-router-test.herokuapp.com](https://ggn-nginx-router-test.herokuapp.com) and get the app living at [ggn-nginx-test-target.herokuapp.com](https://ggn-nginx-test-target.herokuapp.com) delivered to you.

Or you can simply deploy this repo.

**Setup nginx-test-blog**

Set up your working directory in your code directory:

```
mkdir test-blog
cd test-blog
git init . && git checkout -b main
heroku create ggn-nginx-test-blog
```

Create a `.gitignore` file:

```
/vendor/
```

Create a `Procfile`:

```
web: vendor/bin/heroku-php-apache2
```

Create a `composer.json`:

```json
{
  "require": {},
  "require-dev": {
    "heroku/heroku-buildpack-php": "*"
  }
}
```

Run `composer update`

Create an `index.php`:

```php
<h1>This is a Blog!<br />
Requestor Headers:</h1>
<br />
<?php foreach (getallheaders() as $name => $value) {
  echo "$name: $value\n<br />";
}
?>
```

Adding in additional routes is as simple as setting up new location blocks and their corresponding upstream blocks. For example you could add

```conf
  upstream upstream_blog {
    server ggn-nginx-test-blog.herokuapp.com;
  }
```

and

```conf
    location /blog/ {
      set $upstream upstream_blog;
      proxy_pass http://$upstream/;
      proxy_set_header x-forwarded-host $host;
      proxy_set_header Host ggn-nginx-test-blog.herokuapp.com;
    }
```

Now when you visit [ggn-nginx-router-test.herokuapp.com/blog/](https://ggn-nginx-router-test.herokuapp.com/blog/) you will get the contents of [ggn-nginx-router-blog.herokuapp.com/](https://ggn-nginx-router-blog.herokuapp.com/).

In the config directory of this [repo on github](https://github.com/tsykoduk/Heroku-Nginx-Reverse-Proxy) is a sample `nginx.conf.erb` which enables this example.

In closing, we created three applications on Heroku. One was a proxy and router, and the other two were backing services. The proxy examines the URL, and based on the path, renders one of the two backing services. This is a small example of the many uses of Nginx on Heroku. More use cases include delivering static content and reverse proxying into a Private Space.
