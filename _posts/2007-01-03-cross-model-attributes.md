---
id: 310
title: Cross Model Attributes
date: 2007-01-03T16:21:00+00:00
author: tsykoduk
layout: post
guid: https://greg.nokes.name/?p=310
permalink: /2007/01/03/cross-model-attributes/
categories:
  - Computers! and Code!
description: "Learn how to implement cross-model attributes in database design using a flexible attribute system that allows different models to share and search common properties while maintaining unique characteristics."
---
<p>I am sure that all of the programmers out there will say "Well, Duh!" but I wanted to put this into writing for my own purposes. Basically so I do not forget it. If you happen to get some good ideas from it, well then score.</p>

<!--more-->

<p>So, I have several models which all need to have attributes. Not all of them need the same attributes, however we want a method of quickly searching and creating new types of attributes for models.</p>


<p>Hu?</p>


<p>Ok...</p>


<p>Suppose we have the following models:</p>


<ul>
 <li>Laptop </li>
 <li>Desktop </li>
 <li>Server </li>
 <li>Car </li>
 <li>Building </li>
</ul>

<p>All of these might have a attribute of color, but only the computers will have an IP Address. However, we want to be able to search all computers based on the IP address. Just to make it more difficult, Laptops, Servers and Desktops are all computers.</p>


<p>My solution at this time is to create another model, which I have called Attributes. This has the following layout:</p>


<pre><code>
class Attribute ActiveRecord::Base
	belongs_to :owner, :polymorphic :true
	# Attribute has the following fields:
	# owner_type as string
	# owner_id as integer
	# type as string
	# value as string
end</code></pre>


<p>Each of my models which will use these will include the has_many directive:</p>

<pre><code> 
	has_many :attribute, :as :owner
</code></pre>


<p>When a new instance of a model is created, I run an after_create function (which I cleverly call Templater) which figures out which type (or species) of model is being created, and pre-populates a default set of attributes.</p>


<p>For example, a Laptop might be created with the attributes: <span class="caps">CPU</span>, RAM, IP Address, and OS. In fact, all computers could be created with that same default set of attributes. Then, when we decide to build a query that gives us all computers with less them 1024 megs of <span class="caps">RAM</span>, we can simply search the attributes table for all records where type is <span class="caps">RAM</span> and value is less then 1024, and return their owner ID's.</p>