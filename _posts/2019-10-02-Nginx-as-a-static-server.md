---
id: 15581
title: Nginx as a static site server on Heroku
date: 2019-10--02
author: Greg Nokes
layout: post
guid: http://greg.nokes.name/?p=15590
permalink: /2019/10/02/Nginx-as-a-static-server
categories:
  - Computers! and Code!
---

I was doing some preformance testing on this site, and while I was impressed, I felt like I could wring some more preformance out of it.  I decided to swtcih from heroku's [Static Buildpack](https://github.com/heroku/heroku-buildpack-static) to a simple Nginx webserver using Heroku's nice [Nginx Buildpack](https://github.com/heroku/heroku-buildpack-nginx). In theory this should be a little qucker and lighter.
<!--more-->

For example, a hotel chain that I used to frequent knew that my favorite snack was wasabi peas. About half of the time that I arrived in my room, there was some wasabi peas waiting for me. That personal touch insured years of loyalty from me.

It’s a simple idea, however the implementation is very hard. You have to construct some sort of customer record where you can store these preferences, and insure that they are pushed out to everyone who needs to know about them almost in real time.

Imagine a world where my favorite restaurant chain already knew about my dairy allergy. When I ordered, that would be automatically taken into account, and the meal would be prepared correctly for me.

More simply, checking into a hotel in a far away city, and finding your favorite snack waiting for you. As a business traveler these sorts of touch points make the experience for me. And given a choice between an experience like that, or checking into a hotel and getting handed a key and forgotten, guess which one we will choose.

However you do have to get these experiences right. For example I love when a hotel has a text system, and they text me to check if everything is ok, and allow me to do things like make reservations via text.

That being said, I was at a hotel which had rolled that service out, and I had the following conversation:

> "Welcome to _____, Greg! We are here for you, so please text us for suggestions on things to do, housekeeping requests, dinner reservation - really ANYTHING! Text back for special hotel guest offers. **Text & data rates may apply. Text 'STOP' to discontinue receiving messages from ___."

> "Hey I actually forgot my toothbrush and a hair brush. Any chance you could deliver one to my room before tomorrow morning?"

> "Unfortunately we do not have hairbrushes."

I ended up heading down to the hotel’s gift shop and buying a tooth brush and hair brush. 

They had a chance to make a memorable interaction with me. But they failed at their "really ANYTHING!" promise. Was I upset? Not really. But that interaction stuck with me. A little more initiative would have turned that from a memorable meh into an memorable wow moment.

The modern consumer is demanding more and more personalized experiences. And they are demanding it via more and more channels: Twitter, SMS, iMessage, FB messenger and WhatsApp to name a few. How can you mange these interactions on these disparate channels?

The technology to accomplish this is already here. Stitching it together, and learning about your customers is the hard part. But the folks that get this right will stand head and shoulders above the ones that just standardize on a common experience.
