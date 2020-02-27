---
id: 15043
title: Scaling Wide
date: 2009-07-03T15:20:46+00:00
author: tsykoduk
layout: post
guid: http://greg.nokes.name/?p=15043
permalink: /2009/07/03/scaling-wide-a-primer-on-scaling-applications/
categories:
  - Computers! and Code!
tags:
  - introspection
  - linkedin
  - Sharding
---
One of the questions that I am asked often is "how do I scale my web application?" or "we're expecting 200 times the traffic tomorrow, what do I do?". The second question is usually too late.



The first however, when asked at an appropriate time, can be what saves you from asking the second. A good knowledge of best practices to start with, and then a rigorous testing and introspection process will do more to inform you "when" then any thing else.



<strong>Cache, cache, cache...</strong>



You need to cache everything you can. Memcache, disk cache, what ever you can cache should be.



<strong>Find your Hotspots!</strong>



The first step in any scaling action is finding out what part of your application needs to scale. If you are having issues with your database, and you build a spiffy disk sharding scheme, you just fixed a problem that does not exist. Doing the proper discovery will allow you to allocate your efforts for best effect.



Basically, I subscribe to the "least effort" camp. Do the least that you can, as long as you are 1) fixing the problem and 2) giving yourself breathing room to start on the next problem before it becomes a serious issue. This will allow you to still work on the other parts of the app, rolling out new features and creating new hotspots to find.



Finding your hotspots is very important in this process. Usually, hotspots are where the flames start. Knowing your points of pain allow you to triage correctly, and to know how to best spend your developers time.



One of the things to keep in mind is that this process is ongoing. You might be optimizing disk reads and writes one week, and be neck deep in SQL the next. When you clear out one hotspot generally another one will crop up to take it's place.



If you have a proper staging setup, you can build estimates against generated traffic. This can give you a (blurry) view into what the next hotspot might be. The best process that I have seen is to capture a hour or so worth of traffic on the live site, and replay it 2, three or more times faster against the staging environment. You want the traffic to be as real as possible.



Using introspection tools on your production environment is invaluable. You want these tools to be as real time as possible.



<strong>When to go deep, and when to go long..</strong>



After you have killed all of the hotspots you can, and added all the resources you can afford, it's time to look at the next level. Usually this is when when start to see people thinking about sharding of some manner. There are three major types of sharding at the moment - Filesystem, Database and Application. I will touch on each of these topics, starting with the highest level, and hardest.



<strong>Application Sharding?</strong>



Application sharding is the most extreme, provides the most benefit and is the hardest to accomplish. If you can split your users amongst several vertical groups, you can basically install copies of the application for each segment.



You can also look at abstracting any shared logic into a back end API driven application. The rule of thumb there is to have each back end application do one thing, and do one thing very very quickly.



For example, if you can segment your user base into three groups who do not really interact, you can simply provision 3 environments and install 3 separate copies of the application. An example of this might be a site hosting application. Each site hosted will not need much (if any) interaction with the other sites hosted. This is by far the easiest method of sharding your application.



You can also look at this from a business logic view. If you can cut your application into portions (say, photos, chat and games for a social site) you can create smaller applications to handle authentication, user information storage, photos, chat and games. You would have the photos, chat and games applications leverage the back end authentication and user information applications to read and write shared information.



This gives us several advantages. For the back end application remove all unneeded code (i.e., if you are not going to need to use views, then remove ActionView), plugins and gems. Keep the app as light as possible. Optimize the DB access and make use of memcached as much as possible. Host each of the application shards on dedicated resources (i.e., their own Database's and Compute).



One of the large advantages of this approach is that you can start to optimize your hardware spend. If your chat application is 1/2 as intensive as your photo and games applications, it's far easier to assign resources in a targeted fashion and maximize returns. In a monolithic application, if the photo application breaks, or needs more resources the entire stack is effected. With sharding, you get some buffering from some site wide issues, and the ability to assign hardware exactly where it's needed. The big drawback is that it's not easy.



<strong>Database Sharding...</strong>



Another step that can be looked at in certain circumstances. If the amount of data you need to process is so huge, or the number of transactions is really large, you can look into database sharding. Basically, you take your database and break the schema up amongst several DB's. There are tools in most major RDBMS's which will allow you to take care of this. Informing the application where the data is might be complex depending on which RDBMS you use.



Look for a in-depth treatment of this subject in a later article.



<strong>Filesystem Sharding</strong>



If your application is filesystem IOPS heavy, filesystem sharding might be the route that you want to look at. Basically you add more hardware disk arrays, and split the reads and writes between them. You need to inject some logic into the save and open functions in your application so that it knows which filesystem each file is to be saved to and opened from. Usually you create a hash of the filename, and key off the first couple of characters in the hash. You can read more on this technique <a href="http://greg.nokes.name/2008/12/25/filesystem-scaling-in-high-traffic-web-applications/">here</a>.

