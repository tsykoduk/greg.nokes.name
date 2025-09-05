---
id: 1000
title: Using environment variables for application configuration
date: 2012-04-09T20:24:16+00:00
author: tsykoduk
layout: post
guid: https://greg.nokes.name/?p=1000
permalink: /2012/04/09/using-environment-variables-for-application-configuration/
categories:
  - Computers! and Code!
tags:
  - Best Practices
  - Deployment
excerpt_separator:  <!--more-->
description: "Learn how to use environment variables for secure application configuration, eliminating passwords from version control and simplifying deployment across multiple environments."
---
<p>One of the cool things about what I do, is that I get exposed to some really interesting paradigms. One of the latest is the <a href="http://www.12factor.net/">12 factor app</a>. It's an evolution of some of what I have thought in the past, and a radical departure in others.

<!--more-->

<p>I'm going to talk about just one of the concepts right now. It was one of the ones that made the least amount of sense to me, until I started to use it. I'm also going to show a concrete example of how to use it in a production system.</p>
<p>Of course, I'm talking about the use of <a href="http://www.12factor.net/config">environment variables for application configuration</a>. At first, I though that it was a "nice to have" or perhaps even a little more work then was really needed. Now, I'm going to standardize on this no matter where I deploy, or what I deploy.</p>
<p>I think that there are several reasons to use this tactic, but the one that hit me over the head was simply "<em>No passwords in version control</em>". You know that you've done it. Committed to a repository with your database.yml or wp-config.php all full of DB passwords. It's almost a necessary evil, right?</p>
<p>So there I was playing around with WordPress, getting it deployed on <a href="http://heroku.com">Heroku</a> and I sat back after figuring this out:</p>
<script src="https://gist.github.com/2347227.js"> </script>
<p>Looking at that gist, one thing became evident to me. The password <strong>could not</strong> be committed to a repo. I would not have to use <a href="http://progit.org/book/ch6-4.html">arcane git commands</a> again! Well, not to purge passwords at least.</p> 
<p>There are a few other benefits as well, ones that have not caused me as much pain as the passwords thing. You can easily manage developer/staging/test/QA/production/live environments by simply calling out the correct config when you build the servers. Need to change a DB password? Just create the new user, spin up boxes using it, deploy your code, and then delete the old user.</p>
<p>Ops does not need to touch code to massage it into the correct environment, and developers do not need to care what the latest username and password for the DB they need is.</p>
<p>Seems like a pretty big win from my point of view..</p>