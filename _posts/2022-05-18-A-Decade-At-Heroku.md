---
id: 16500
title: Reflections on a Decade at Heroku
date: 2022-06-01
author: Greg Nokes
layout: post
guid: https://greg.nokes.name/?p=16500
permalink: /2022/06/18/a-decade-at-heroku/
categories:
  - Computers! and Code!
excerpt_separator:  <!--more-->
---

<img src="/wp-content/uploads/2022/06/Doors.JPG" width="200" alt="glass doors with bonasi tree etched" style="float: left; padding: 0 10px 10px 0;"> At about 7:45am March 26th 2011, I walked up to the doors at Heroku for the first time. I was early because that's what you did where I came from.

The doors were locked. No one responded to the buzzer.

So I went and got some really bad coffee at the [DNA Lounge](https://www.dnalounge.com) next door, and waited. As I recall, I saw someone walk in at about 9, and followed them in. And that's how the next chapter in my life started.

<!--more-->

<h3>Before Heroku</h3>

I got my start in technology far before it was "tech". My first experience was working on a NetWare 3 network running ARCNet. Look it up, I'll wait.

In the 90's I got to work on NetWare 2, 3, and 4. Windows for Workgroups, Windows NT 3.5, 3.51, and 4. ARCNet, Token Ring, ThickNet and ThinNet, CAT3, CAT5 and Fibre. I built early internet proxies and ran WAN's that served 1,000's of users with file and print services. I was firmly grounded as a BOFH. I even held certifications as a Certified NetWare Engineer and Microsoft Certified Systems Engineer.

One of the things that I have always wanted is to have greater impact. Looking to work on bigger things, I ended up getting hired as a contractor to help the US Department of Justice run their network in Washington State. I spent 8 great years there and and then the US Department of Homeland Security, building data centers and coding network monitoring tools, migration tools and applications.

After 8 years however, I started to doubt the mission, and did not feel like I was able to actually have any impact beyond keeping things running. So I started to look outside of government service, and back towards working in the "real world". I also wanted to get out of the hands on keyboard work, and start to see if I could increase my impact.

I ended up spending time at places like Engine Yard, Point Inside, and Bluebox Group. I did things like DevOps at Point Inside, TAM at EY and SE at BBG. A pretty big change from sitting in data centers poking at servers!

These were also early cloud based companies - either providers like EY and BBG or consumers like Point Inside. As I started to work with newer technologies like AWS I really started to value "the cloud", and the agility that it could bring me as someone with a sysadmin background. The ability to get a box provisioned in a few moments, rather then a few weeks to get one shipped to me was a real game changer.

But building on AWS was hard. Not quite as hard as building a datacenter, and a lot quicker however it still took time, focus and a team to run the infrastructure.

<h3>First Tour</h3>

All of that lead to me standing outside Heroku's door on that early SF morning, wondering if I had made the right choice. Little did I know how much I would learn over the next decade.

My first job was to work with Heroku's largest customers at the time. I helped them with things like superbowl ad landing pages, architecture advice, launch planning and support escalation. I also carried their concerns and desires for the platform to the team. I got to help with some really cool projects, things like Zero Downtime Deploys, PHP support, and larger dynos.

The job was customer facing. I would act as a Solutions Engineer, and help folks understand the platform and how to onboard. I would then take on those accounts for their entire lifecycle. We were the single thread for a customer. 

This was the team that turned into the CSA team. As we kept on going, we hired a few folks. Over the years, that team has grown so much. I am still very proud of the work we did, and I have watched that team grow into a force to be reckoned with.

Early Heroku was a special place. I always felt like I was surrounded by some of the smartest people that I had ever met. I even got to meet Matz! We were tackling some of the hardest problems at the time and everyone deeply cared about our customers.

We were pushing the boundaries of scale, design and inventing new things every day it seemed.

<h3>The Height of Heroku's Power</h3>

After a year and a half, I took a six month break, and came back as the first Solutions Architect. Heroku had grown to much to have the CSA team act as SE's, so we founded HEAT (Heroku Enterprise Architect Team). This was my home at Heroku for the next 6 years. Over the years, I matriculated from a Lead Solutions Architect to a Distinguished Technical Architect. 

We still worked closely with the CSA team, to replicate that single thread. I was happy to work closely with my old team, and get to see customers that we had onboarded grow and prosper.

*Knowledge, Truth and Wisdom* were my internal mantra. Steering customers away from bad choices, and insuring that they were set up to be successful on the platform was my primary goal. We would rather tell someone to go to AWS then have them buy Heroku and find out that it would not work with their use case.

We structured the team a little different then I have seen in the past. The team was compensated on how the entire business did, not on deals that the individual worked on. This fostered a truly collaborative environment. I treasured the esprit d'corps that this environment fostered. In the first year, I told my boss that I would probably get bored and start looking for something else in 2 years. Well, 6 years later I was still happily training folks, talking to customers and creating education and demos.

I learned so much during this time. Things like

* My favorite game is "Stump the Chump". 
* "Why say with 12 words what you can say with 6". 
* Trust based sales. 
* Mentorship. 
* "Write down 5 things you want to accomplish this year". 
* "6 questions to ask before accepting a meeting". 
* What stages of an opportunity mean. 
* How to use Salesforce, Marketing Cloud and Mulesoft in architectures.
* Powerpoint Powerpoint Powerpoint.
* The best demo is not having to do a demo.
* The best slides are not having to use slides.
* [Nokes Law](https://greg.nokes.name/2019/10/09/thoughts-on-data-lakes/) One Person's Data Lake is another persons Excel Spreadsheet.

I also had a ton of great experiences. I was able to give talks at AWS road shows, Dreamforce, TrailblazerDX and Salesforce World Tours. I got to go to a Sales Club. Twice. I was honored with awards by Salesforce. 

I was able to spearhead creation of the [Heroku Architect Exam](https://trailhead.salesforce.com/en/credentials/herokuarchitect). I helped create some of the first trailheads for Heroku, and I created and delivered onsite trainings for developers new to the platform. I built sales enablement tools, trained new AE's on how to sell Heroku and provided feedback to product. I got to record a video (that has been removed) to highlight [why people choose Heroku](https://greg.nokes.name/2020/09/16/condos-and-lumberjacks/).

A friend has said that this was "the Hight of Heroku's Power" and I agree. We delivered [private spaces](https://www.heroku.com/private-spaces) and [fully managed HIPAA and PCI lvl 1 hosting environments](https://www.heroku.com/shield). [Heroku Connect](https://www.heroku.com/connect) powers billions and billions of rows of sync between Core Salesforce and Heroku.

We were customer obsessed and preaching [12 Factor](https://12factor.net) everywhere. We were helping people build the next generation of apps and ideas. We truly believed that democratization of infrastructure was important. Giving everyone the power to develop something and host it safely and scalably lowered the bar and allowed a entire new crop of startups and companies.

<h3>I Want to live in a city of the elves</h3>

As the team was moving on to diffrent parts of Salesforce, I decided it was time to pursue my next goal. I had been talking to product folks at Heroku for several years about what makes a good Product Manager, so I decided to make the leap over. I was honored to be chosen to take over Heroku Data and Heroku Connect as Product Manager. 

Over the past year and a half I have learned a ton about being a Product Manager. Coming from Sales into Product I had to slow down and learn how think much longer term. I also had to dust off some of my Agile skills. I had to learn a bevy of new TLA's - things like PRD and OKR. I have really enjoyed being able to set time aside to focus on writing.

I have really liked working with the engineering teams behind these products, and I can say that they are some of smartest and most empathic humans I have ever worked with. Every day, they work at a scale that boggles the mind. Even with the pressures and scale, they still keep the customer at the forefront.

<!--TODO Decide on this: 

There has been a lot of hot takes, including my [favorite, error ridden article](https://www.infoworld.com/article/3614210/the-decline-of-heroku.html). I have enjoyed reading these looks from the outside in, and chuckling at what they get wrong and what they get right.

-->

<h3>What's next?</h3>

Heroku truly changed the world for development. Heroku was magical and it and the people there impacted just about every aspect of my life. I have made life long friends during my time at Heroku.

I learned to love great coffee and pour overs rather then Espresso at Heroku. I learned how good a well made Sazerac can be. I was able to focus on important family transitions when I needed to step away.

Someone told me that this was the "good old days", and looking back they really were. However I feel like you can have many "good old days". While I am taking another break from Heroku, I know that there are more good old days on the horizon.