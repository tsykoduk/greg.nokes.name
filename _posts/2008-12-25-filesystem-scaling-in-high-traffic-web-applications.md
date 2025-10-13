---
id: 600
title: Filesystem scaling in high traffic web applications
date: 2008-12-25T00:50:00+00:00
author: tsykoduk
layout: post
guid: https://greg.nokes.name/?p=600
permalink: /2008/12/25/filesystem-scaling-in-high-traffic-web-applications/
categories:
  - Computers! and Code!
tags:
  - cloud
  - Sharding
  - web application
description: "Learn how to scale filesystems in high-traffic web applications using sharding techniques, from basic directory splitting to full application-level filesystem independence for enterprise growth."
---
One of the more interesting problems that high traffic, high load web applications face is how to scale the filesystem. As load increases, vertical scaling (bigger servers) simply does not work. You have to add more application servers, and more layers to effectively serve the needs of the users. One of the issues that many such applications have to overcome is how to serve assets (pictures, podcasts, video) to all of the edge servers that a user might access the application from, and allow users to upload user generated content.

<!--more-->

<h3>What is Filesystem Sharding?</h3>

As disk IO based applications grow, they tend to run into limits of IO speed, file system size and stability. This trend is especially relevant in clustered web applications using a cluster aware filesystem such as <span class="caps">GFS</span>, NFS or Lustre FS. However it effects all applications which use disk to store assets at some point.
There are several low level tactics which can mitigate this issue in the short term, such as using high performance <span class="caps">RAID</span> arrays, and various tuning parameters in the Operating System hosting the application. Ultimately, these measures will fail to meet demand. At that point, filesystem sharding needs to be investigated.
This discussion is predicated upon the use of Linux as the host operating system. There are similar tools and concerns in the Windows environment, however they are different enough to warrant own treatment.

<h3>Tactics</h3>

There are two basic levels of filesystem sharding, basic file system sharding and application filesystem independence. Basic sharding will take an application to a certain point, and after that application level sharding needs to be implemented. Often, the authors have seen that basic sharding will allow an application to continue to grow while filesystem independence is implemented.
At a high level, basic sharding is accomplished by inserting an algorithm into the save and load modules, keying off of a unchangeable feature (such as username, file name, etc). You then share to different physical devices mounted under your main partition. Application level filesystem independence includes rewriting the save and load functions to abstract out the filesystem, allowing the application to use what ever file store it needs, where ever that filesystem resides. This is usually implemented as an agent. The application talks to an agent somewhere requesting assets. This allows you to abstract the file system to another machine or even another data center if needed.

<h3>Basic Sharding</h3>

Basic Sharding is accomplished by taking the shared file system, and adding several mount points inside of it. The only application change is a hashing algorithm to determine which file system is used. It can be as easy as inserting a snippet of code into the save and load methods.
As an aside, one of the limitations of many cluster file systems is performance degradation when there are to many files in one directory. In preparation for sharding the filesystem, it's often beneficial to use this hashing system to break up your filesystem before implementing complete filesystem sharding. One of the advantages is that this positions you for painless movement to the goal. Since Linux mounts filesystems as directories, it is a trivial task to move the existing directories, mount the new filesystems, and then move the data back. If you already have the hashing system in place and tested, this makes the move that much less stressful.
<pre><code>
if user.name is odd

	... use /data/shard_1

else
	... use /data/shard_2

end
</code></pre>


Logically the disk layout will be very simple,

<pre><code>/data

    /shard_1

    /shard_2</code></pre>

and the physical layout will be similar.


<pre><code>/dev/sda1 mounts to /

/dev/sdb1 mounts to /data

/dev/sdc1 mounts to /data/shard_1

/dev/sdd1 mounts to /data/shard_2</code></pre>


The advantages of this over a standard one file system approach are two fold. First, mount times and file system repair/check times are decreased, as the file systems are each smaller. Secondly, file system maintenance can be preformed on the live application with less undesirable side effects then simply taking the entire application off line. One can imagine a error rescue that displays a maintenance page when a users file share is not accessible, thereby allowing some users access to the application while other filesystems are being maintained.
From a physical layer, this also allows us to do some interesting things like splitting the filesystem to different <span class="caps">RAID</span> arrays. We can even split out the filesystems across different <span class="caps">RAID</span> controllers. We can also start to explore using expensive, fast <span class="caps">RAID</span> arrays only where you actually need them, and use slower, less expensive disk where warranted.
A more robust version of the sharding algorithm could look like

<pre><code>
case user.name first character

	when = "abcd"

        ... use shard_abcd

    when = "efgh"

    etc...
</code></pre>

It's logical disk layout would be

<pre><code>
	/data

    /shard_abcd

    /shard_efgh

    /shard_ijkl

    /shard_mnop

    /shard_qrst

    /shard_uvwx

    /shard_yz
</code></pre>

It's physical layout would be similar to the first example - each shard mount would be on it's own physical device.

<h3>Application level filesystem independence</h3>

Application level filesystem independence is an architectural choice, rather then a quick fix. When you reach the point where you are considering this as an option, you have probably already implemented basic sharding. A low level discussion of how to accomplish this is beyond this paper, however we can present some ideas that we have seen work in production sites.
The most basic implementation of this concept includes injecting logic into the save and load functions which call a module. This module then determines which file server it is going to talk to based on some algorithm. It then opens a socket to an application running on that server, and requests the filesystem operation via the remote application.
This level of abstraction allows us to do some interesting things. Advanced implementations could include ideas like geo-ip tagging, smart synchronization and advanced request forwarding.
For example, our file system agents can reside on different servers, in different data centers if we wish. We can build a peer to peer synchronization routine into the remote agents, allowing our application to spread load out amongst physical file servers and giving us easy failover and redundancy. In this case, each single asset could be written to several file servers
We would use geo-ip to redirect the request to a file server closest to the requester. Often we do not want to use this on the client machines, as their location might change. We see this keyed off of application server location.
Advanced request forwarding allows files not in the local store to be served up. The logic built into this idea should allow an agent to determine if it has a copy of the file in question. If it does not, it should check out a copy from the closest file server which does have a copy. This allows us to start trying and pre-cache items that the requester will need.
All of these are ideas which others have implemented with varying degrees of success.

<h3>Summary</h3>

Basic web frameworks can carry a website quite a ways as far as scaling goes. Using clustered filesystems can shoulder the load further. After exhausting the capabilities of vanilla deploys of each of these, you need to look into sharding to carry your application to the next level. Filesystem sharding is a good fit for high disk IO applications.