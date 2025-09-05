---
id: 610
title: Load Testing
date: 2008-12-27T06:37:00+00:00
author: tsykoduk
layout: post
guid: https://greg.nokes.name/?p=610
permalink: /2008/12/27/load-testing/
categories:
  - Computers! and Code!
description: "Learn how Mephisto blog performance scales under load testing with New Relic monitoring, including database bottlenecks, memory usage, and optimization insights."
---
<p>If you notice some slowness, I am playing around with the fantastic <a href="http://newrelic.com">New Relic</a> performance and code introspection tool.</p>

<!--more-->

<p>I have found that at about 15 - 20 requests per minute per app server, <a href="http://mephistoblog.com/">Mephisto</a> starts to bog down a little. We went from a wall clock of 1 second per page view to about 3. Not to bad.</p>


<p>With the <span class="caps">VPS I</span> am running on (a <a href="http://engineyard.com">Engine Yard</a> slice) the <span class="caps">CPU</span> was not taxed. I am running <a href="http://code.macournoyer.com/thin/">Thin</a> and each of them grew to a manageable 200 mb of <span class="caps">RAM</span> and hovered there.</p>


<p>The largest factor was Database hits. Every request touches the database, so putting a simple memcache server into the mix could be a huge win.</p>