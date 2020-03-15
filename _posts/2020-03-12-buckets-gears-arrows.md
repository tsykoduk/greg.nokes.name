---
id: 15710
title: Buckets, Gears and Arrows
date: 2020-03-12
author: Greg Nokes
layout: post
guid: http://greg.nokes.name/?p=15710
permalink: /2020/03/03/buckets-gears-arrows/
categories:
  - Mundane
  - Computers! and Code!
---

When I start to architect out a solution, I tend to start at a high level, and drill into complexity only were needed.

<!--more -->

I have three step process that I use to build out architectures:

**Step 1: Start Big**

I will start drawing out what the high level looks like. Here is where I use the buckets, gears and arrows. Buckets hold things, gears process things, and arrows move things. Pretty simple and very high level constructs. My deliverable is generally a whiteboard or drawing of the high level architecture. 

**Step 2: Assign Roles and Products**

During this step I think about what each bucket is going to hold, what each gear is going to do, and what kind of integration each arrow is going to be. With that information, I can start to make high level choices about what sort of data store each bucket is, about how to construct the business logic, and what sort of integration tools we should use for each arrow. I will take my drawing, and expand the complexity to include the specifics for each system.

**Step 3: Add complexity where needed**

Now that we have a detailed architecture, I can start to look at specifics. I can start to detail out what database tables look like, how relationships between tables are formed, exactly what data is flowing through the pipes, and what langages and frameworks would be most effecent for each portion of the cluster.




