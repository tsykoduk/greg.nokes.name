---
id: 16500
title: Reflections on a Decade at Heroku
date: 2022-06-14
author: Greg Nokes
layout: post
guid: https://greg.nokes.name/?p=16500
permalink: /2022/06/14/a-decade-at-heroku/
categories:
 - Computers! and Code!
excerpt_separator: <!--more-->
---

<img src="/wp-content/uploads/2022/06/Doors.JPG" width="200" alt="glass doors with bonasi tree etched" style="float: left; padding: 0 10px 10px 0;"> At about 7:45am March 26th 2011, I walked up to the doors at Heroku for the first time. I was early because that's what you did where I came from.

The doors were locked. No one responded to the buzzer.

So I went and got some really bad coffee at the [DNA Lounge](https://www.dnalounge.com) next door, and waited. As I recall, I saw someone walk in at about 9, and followed them in. That's how the next chapter in my life started.

<!--more-->

<h3>Before Heroku</h3>

I got my start in technology far before it was "tech". While I had a [C64](https://en.wikipedia.org/wiki/Commodore_64) and [386](https://en.wikipedia.org/wiki/I386) and was in the [BBS scene](http://bbslist.textfiles.com/559/oldschool.html) when I was young, my first professional experience was working on a [NetWare 3](https://en.wikipedia.org/wiki/NetWare) network running [ARCNet](https://en.wikipedia.org/wiki/ARCNET). Look it up, I'll wait.

In the 90's as a consultant and sysadmin I got to work on NetWare 2, 3, and 4. Windows for Workgroups, Windows NT 3.5, 3.51, and 4. ARCNet, Token Ring, ThickNet and ThinNet, CAT3, CAT5 and Fibre. I built early internet proxies and ran WAN's that served thousands of users with internet, file and print services. I installed [Vampire Taps](https://en.wikipedia.org/wiki/Vampire_tap) and pulled cable. I was firmly grounded as a [BOFH](http://www.bofharchive.com). I even held certifications as a Certified NetWare Engineer and Microsoft Certified Systems Engineer.

One of the things that I have always wanted is to have greater impact. To make that happen and work on bigger things, I got a job as a contractor to help the US Department of Justice run their network in Washington State. I spent 8 great years there as well as at the US Department of Homeland Security building data centers, creating [network monitoring](https://github.com/tsykoduk/CondorNG) and [migration tools](https://github.com/tsykoduk/sync_script) as well as developing applications.

It was a great job, but it felt like my impact was still limited to keeping things running. I wanted more. This prompted me to explore roles outside of government service and get back to the “real world”. I knew there I could give up hands on keyboard tasks and work on even more impactful projects.

I subsequently spent time in roles at Engine Yard, Point Inside, and Bluebox Group. I worked on DevOps at Point Inside, as a Technical Account Management at Engine Yard and in Sales Engineering at Bluebox Group. All-in-all, this career phase was a pretty big change from sitting in data centers poking at servers! 

These companies were also early cloud based ones – some were service providers like Engine Yard and Bluebox Group and others consumer-centric ones like Point Inside. As I started to work with newer technologies such as AWS, I really started to value “the cloud” and the agility it brought me as someone with a sysadmin background. The ability to get a box provisioned in a few moments rather than a few weeks was a real game changer.

But building on AWS was challenging; Not quite as hard as building a datacenter, but still complicated. While it was a lot quicker, it still took time, focus and a team to run the 
infrastructure.

<h3>First Tour</h3>

The journey back into public sector and back out had led me to this moment, standing outside Heroku’s door on that early San Francisco morning, wondering if I had made the right choice. Little did I know how much I would learn over the next decade! 

My first assignment was to work with Heroku's largest customers at the time, building out what would become the CSA team. I provided guidance on things like Superbowl Ad landing pages, architecture, launch planning and support escalation. I also triaged customer concerns and feature requests with the Platform product teams. I got to help with some really cool projects, things like Zero Downtime Deploys, PHP language support, and enabling larger dynos.

The job was customer facing. I would be pulled into presales conversations, and act as a Solutions Engineer to help folks understand the platform and how to onboard and leverage it to the fullest. I would then take on those accounts for their entire lifecycle. We were the single thread for a customer. 

As the platform matured, we hired more engineers and that fledgling group became the well-respected and appreciated CSA team. Over the years, that team has grown tremendously and I am still very proud of the work we did; I was having an impact! 

These early years at Heroku was a special place. We were tackling some of the hardest problems at the time and everyone deeply cared about our customers. I always felt like I was surrounded by the smartest people I had ever met. Once, I even had the chance to meet [Matz](https://www.ruby-lang.org/en/about/)!
 
We were pushing the boundaries of scale, design and inventing new things each and every day it seemed.

<h3>The Height of Heroku's Power</h3>

After these early years with my nose to the grindstone, I took a short hiatus before returning as the first Solutions Architect. Heroku had grown too much to have the CSA team act as Solutions Engineers, so we founded the HEAT (Heroku Enterprise Architect Team). This was my home at Heroku for the next 6 years.

*Knowledge, Truth and Wisdom* were my internal mantra. Steering customers away from bad choices and insuring that they were set up to be successful on the platform was my primary goal. We worked closely with the CSA team, replicating that single thread. I enjoyed collaborating with my old team and seeing customers we had onboarded long ago grow and prosper. We found ourselves architectural purists... we would rather guide the customer to AWS than have them be an unhappy Heroku customer.

We structured the team differently than I had seen in the past. We were compensated on the performance of the entire business, not on individual deals that we worked on. This fostered a truly collaborative environment, an esprit d’corps, and one I treasured. 

Despite telling my boss during the first year I’d probably get bored in a couple years and explore new opportunities, I found myself 6 years later still happily training folks, talking to customers and creating public-facing educational content and demos.

I learned so much during this time and thought I’d pass a few of them along:

* My favorite game is "Stump the Chump". 
* "Why say with 12 words what you can say with 6". 
* Trust based sales. 
* Mentorship. 
* "Write down 5 things you want to accomplish this year". 
* "6 questions to ask before accepting a meeting". 
* What stages of an opportunity mean. 
* How to always keep learning about new things
* Powerpoint Powerpoint Powerpoint.
* The best demo is not having to do a demo.
* The best slides are not having to use slides.
* [Nokes Law](https://greg.nokes.name/2019/10/09/thoughts-on-data-lakes/): "One Person's Data Lake is another persons Excel Spreadsheet."

 I also had a ton of great experiences. I was able to give talks at AWS road shows, Dreamforce, TrailblazerDX and Salesforce World Tours. I was honored with awards by Salesforce and I even I got to go to a Sales Club... twice!

I spearheaded creation of the [Heroku Architect Exam](https://trailhead.salesforce.com/en/credentials/herokuarchitect) and some of the first trailheads for Heroku. I created and delivered onsite trainings for developers new to the platform. I built sales enablement tools, trained new AE's on how to sell Heroku and provided feedback to product. I went viral in videos highlighting [why people choose Heroku](https://greg.nokes.name/2020/09/16/condos-and-lumberjacks/) and even appeared in an episode of [AWS This is my Architecture](https://www.linkedin.com/feed/update/urn:li:activity:6272509374988718080/).

A friend has said that this was "the height of Heroku's power" and I'd have to agree. We delivered [private spaces](https://www.heroku.com/private-spaces) and [fully managed HIPAA and PCI lvl 1 hosting environments](https://www.heroku.com/shield). [Heroku Connect](https://www.heroku.com/connect) powers billions and billions of rows of sync between Core Salesforce and Heroku.

We were customer obsessed and evangelizing the tenants of [12 Factor](https://12factor.net) to anyone who’d listen. We were helping people build the next generation of apps and ideas. We truly believed that democratization of infrastructure was important. Giving everyone the power to develop something and host it safely and scalably lowered the infrastructure bar and ushered in an entirely new era in startups and companies. Customers that I talked to went on to build amazing things. I really felt like I had achieved my goal of impact, and then some.

<h3>Current Chapter</h3>

As the team evolved, the platform grew and members moved on to work in different products at Salesforce, I too decided it was time to pursue my next goal. I had been close to product leaders at Heroku for several years, and talked often about what it takes to be a good Product Manager. So I decided to made the leap and become one. I was honored to be assume the ownership of Heroku Data and Heroku Connect as Product Manager.

Over the past year and a half I have learned a lot about being a Product Manager. Coming from Sales into Product I had to slow down and learn how think much longer term. I was able to dust off some of my Agile skills. I even had to learn a bevy of new TLA's - things like PRD and OKR. I also have really enjoyed being able to set time aside to focus on writing.

I have been truly blessed to have been a working partner with the engineering, UX and documentation teams behind Heroku’s Data products. I can truly say they are some of smartest and most empathic humans I have ever worked with. Each day I watch them they work at a pace that boggles my mind. Despite the pressures and scale, they still keep the customer at the forefront of all they do. Together, I once again feel we’ve made an impact! 

<h3>I Want to live in a lost city of the elves</h3>

Heroku truly changed the world of development. Heroku is magical and it, along with it's family, have impacted just about every aspect of my life. I have made life long friends during my time at Heroku. I am still proud to call my self a Herokai.

I learned to love great coffee and pour overs rather then Espresso at Heroku. I learned how tasty a well made Sazerac can be. I’ve been able to focus on family and life transitions. I've felt compassion when I needed to step away. I learned how to be a better human, father and mentor. I helped folks create some fantastic apps and experiences - and got to lend a hand with humanitarian efforts that Heroku and Salesforce assisted with. 

I feel like my story has been one of wanting to help more people, wanting to make the world a little better then when I found it and wanting to be able to have accomplishments that I am proud to look back on. While I am still on this journey, I feel like I have hit the mark that I set for myself. I am excited to see what I can do moving forward. I look forward to seeing how I can apply yesterday's lessions to tomorrow's problems.

Someone told me once these were the “good old days”, and looking back now, they really were. I feel you can create more “good old days” and while I’m leaving Heroku, I know that there are new ones coming on the horizon. 
 
