---
id: 1521
title: The Condo Association Has Stopped Renovating
date: 2026-02-06
author: tsykoduk
layout: post
guid: https://greg.nokes.name/?p=1521
permalink: /2026/02/06/the-condo-association-has-stopped-renovating/
categories:
  - Technology
excerpt_separator: <!--more-->
description: "Reflections on Heroku's transition to sustaining engineering, what it means for the platform's future, and the humans who built something that changed how software gets made."
---

Today, Heroku announced it is transitioning to a "sustaining engineering model focused on stability, security, reliability, and support." Enterprise contracts will no longer be offered to new customers. The stated reason: Salesforce is redirecting engineering investment toward enterprise AI.

If you've followed my writing, you know I spent over a [decade at Heroku](https://greg.nokes.name/2022/06/14/a-decade-at-heroku/). I helped build the sales engineering function, created the Architect Exam, onboarded some of the platform's largest customers, and eventually became the Product Manager for Heroku Data. I left in 2022, and I've written several times about the platform's evolution since. Today's news is, in some ways, the chapter I hoped wouldn't come. But it's not the chapter I didn't expect.

<!--more-->

## What "Sustaining Engineering" Actually Means

Let's be clear-eyed about the language. "Sustaining engineering" is an industry term with a specific meaning: keep the lights on, patch security vulnerabilities, fix what breaks. No new features. No competitive investment. The announcement is notably brief — three paragraphs from the CPO — and that brevity says as much as the words.

For credit card customers, nothing changes immediately. Your apps run. Your databases respond. Your pipelines deploy. But the trajectory has changed. A platform that isn't investing in new capabilities is a platform that is slowly falling behind. Today's adequate becomes tomorrow's technical debt.

For enterprise customers, the picture is starker. Existing contracts will be honored, but no new enterprise deals. That's not a platform pivoting — that's a platform being wound down in an orderly fashion.

It's possible this is a case of marketing messaging missing the mark, and Heroku will emerge with a clearer direction. I hope so. But "plan for the worst, hope for the best" has always been sound engineering practice. And if more uncertainty is coming, the community's response — voting with their feet — may itself shape what comes next.

## The Condo Comes Full Circle

Back in 2020, I wrote a piece called "[Condos and Lumberjacks](https://greg.nokes.name/2020/09/16/condos-and-lumberjacks/#article)" explaining why PaaS matters. The core metaphor: AWS is a lumber yard where you buy wood and build your own house. Heroku is a condo — you buy it and your developers can get straight to picking tile colors and hanging art. The building, the plumbing, the landscaping, the maintenance — all handled.

Today, the condo association has announced they're done renovating. They'll keep the hallways lit and the elevators running, but there won't be new amenities, the fitness center won't be expanded, and they've stopped accepting applications for the HOA board. They're taking the maintenance budget and investing it in a different property — an AI-focused building across town.

The condo still stands. Your unit still works. But anyone looking at the building can see the trajectory, and the smart money is planning a move.

## The Humans Who Built Something Real

What I want to say most clearly today is this: the people who built Heroku built something that genuinely changed how software gets made.

Heroku gave us buildpacks. Heroku gave us `git push` deploys. Heroku's team wrote the Twelve-Factor App methodology that became the blueprint for cloud-native development. And those are just some of the advances. Heroku operated a PaaS at a scale that was almost unheard of. 2+ million databases, millions of apps, millions of containers. Before docker was a thing.

Before Heroku, deploying a web application meant weeks of infrastructure work. After Heroku, it meant minutes. That's not hyperbole — I watched it happen from the inside, hundreds of times, with customers who went from idea to production in an afternoon.

The engineers, the product managers, the support team, the solutions architects, the documentation writers — these people cared deeply about their craft and their customers. I watched them work at a pace that still impresses me. Many have moved on to other roles, carrying that ethos with them. Some are still there, maintaining the platform with professionalism even as the strategic winds shift around them.

This announcement is about corporate resource allocation. It is not a reflection on the quality of the humans who built and maintained Heroku. Those people deserve recognition.

## What This Means If You're Running on Heroku

If you have production workloads on Heroku right now, there's no immediate emergency. But you should be planning.

A sustaining engineering model means the platform will increasingly lag behind the broader ecosystem. Language runtime updates may slow. Buildpack innovation may stall. When the next significant shift in web development happens — and it will — Heroku more than likely won't be adapting to meet it. Some will point to things like http/2 adoption on Heroku and say "this is not new". I think it is, or will become different.

Here's what I'd suggest:

Start evaluating alternatives now, not when something breaks. The ecosystem has matured significantly since 2022 when I first started exploring options after the [free tier removal](https://greg.nokes.name/2022/08/25/heroku-removing-free-teir/). Render, Railway, Fly.io and others have built credible platforms that inherited Heroku's developer experience philosophy. Kamal, which ships with Rails 8, offers a self-hosted path with zero-downtime deploys for those comfortable with a bit more operational responsibility. For static sites, there are excellent free options.

Move your lowest-risk workload first. Get comfortable with the new platform before migrating anything critical. Keep Heroku running in parallel until you've validated the new setup end to end.

And take dumps of your databases. Today. This is always good practice, but it's especially important when a platform's investment trajectory may be changing.

## The Pattern Repeats

In December 2022, I wrote about the [gentrification of online spaces](https://greg.nokes.name/2022/12/21/gentrification-of-online-spaces/) — how communities get built by passionate people, attract corporate investment, and eventually get strip-mined when the economics shift. Heroku's story fits this pattern, though it's more nuanced than a simple villain narrative.

Salesforce acquired Heroku in 2010 for $212 million. For years, the investment continued. Private Spaces, Shield, Heroku Connect — these were real products that served real enterprise needs. But the strategic alignment between a developer PaaS and a CRM company was always tenuous, and as Salesforce's priorities shifted toward AI, Heroku's position became increasingly peripheral.

This isn't unique to Salesforce. It's what happens when a product's value is measured primarily through the lens of a parent company's strategic priorities rather than the needs of its own community. The business logic is defensible. The human cost is real.

## What Persists

Heroku changed what developers expected from infrastructure. That expectation doesn't go away because the original platform enters managed decline. Every PaaS that exists today — Render, Railway, Fly.io, even the developer experience layer on top of Kubernetes — owes a debt to what Heroku pioneered.

The Twelve-Factor methodology is infrastructure canon. Buildpacks are a CNCF project. `git push` to deploy is table stakes. The condo might be aging, but the architectural patterns it established are load-bearing walls in the buildings that came after.

I'm saddened by today's news. Heroku was a magical place, and the humans that built it are amazing folks. I said that in 2022 and it remains true. I hope the platform can weather this transition with the dignity it deserves, and I hope the people still working on it land well wherever they go next.

Someone told me once these were "the good old days." They were. And the ideas that made them good are still out there, being carried forward by people who learned what great developer experience looks like by using Heroku.
