---
id: 15436
title: 'Building a custom build pack on Heroku - the HARD WAY'
date: 2012-05-18T15:14:02+00:00
author: tsykoduk
layout: post
guid: http://greg.nokes.name/?p=15436
permalink: /2012/05/18/building-a-custom-build-pack-on-heroku-the-hard-way/
categories:
  - Computers! and Code!
---
So you want to build yourself a custom <a href="http://heroku.com">heroku</a> buildpack, and you want to do it the hard way? Look no further, for within lies insanity.

There are a few caveats that you'll need to understand. The first, is to use google and make sure that some one else has not already embarked on your particular path of insanity. The second is that there are easier ways then this path. You'll especially want to look at things like <a href="https://github.com/ddollar/vulcan">Vulcan</a>, which will make parts of this a lot easier.

One of my many failings is a need to understand how things work at their core. So I actually took the time to do this the hard way, and determine exactly what was going on at each step. Hopefully this helps you in some way, and you'll not have to follow me.

<strong>Step one. Google</strong>

Make sure that your buildpack was not already created. There are a bunch out there, so just do so. In my case, I needed a PHP buildpack with several minor changes, and there was not an alternative at the time.

<strong>Step two. Google</strong>

Find a build pack that is close to what you need. Fork it on github. Start out standing on the shoulders of giants, and you'll reach higher.

<strong>Step three. Compile</strong>

Create a temp app using the forked buildpack. Do <code>heroku run bash</code> and get a dev environment. Pull in the source for the binaries that you need. compile them all. Install them. Tar up the new directories, and push them off the dev environment.

This is the tricky step.

Following my mantra of doing things the hard way, I decided against using a tool like <a href="https://github.com/ddollar/vulcan">Vulcan</a>, and ended up using my old standby - <code>./configure &amp;&amp; make &amp;&amp; make install</code>. I then tarred up the apache directory and the php directory, and scp'd it down to my box. Don't do what I did. Use vulcan.

<strong>Step four. Hack</strong>

Now that I had the binaries in hand, I was able to stash them someplace accessible via a http request, and modify the buildpack to pull my modified binaries rather then the original ones. I was also able to change the builpack's http.conf file to add in the functionality that I had just added. Change this in the buildpack rather then in the compile stage. In my case, the buildpack overwrote the binaries config file. Just sayin, be sure you know where the changes are coming in.

<strong>Step five. Deploy</strong>

Now that you have that new buildpack you can either create yourself a new cedar stack app with it, or change an existing cedar stack app to use it. <em>Please</em> be smart and test this before you use it.

To create a new app:

<pre><code>heroku create -b git://github.com/myname/mykillernewbuildpack.git</code></pre>

To change the buildpack on an existing app:

<pre><code>heroku config:add BUILDPACK_URL=git://github.com/myname/mykillernewbuildpack.git</code></pre>

<strong>Step six. Beer</strong>

You thought it was going to be profit, right?