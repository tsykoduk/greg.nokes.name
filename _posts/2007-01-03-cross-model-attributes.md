---
id: 1990
title: Cross Model Attributes
date: 2007-01-03T16:21:00+00:00
author: tsykoduk
layout: post
guid: 30/2008/12/27/cross-model-attributes
permalink: /2007/01/03/cross-model-attributes/
categories:
  - Computers! and Code!
---
I am sure that all of the programmers out there will say "Well, Duh!" but I wanted to put this into writing for my own purposes. Basically so I do not forget it. If you happen to get some good ideas from it, well then score.


So, I have several models which all need to have attributes. Not all of them need the same attributes, however we want a method of quickly searching and creating new types of attributes for models.


Hu?


Ok...


Suppose we have the following models:


<ul>
 <li>Laptop </li>
 <li>Desktop </li>
 <li>Server </li>
 <li>Person </li>
 <li>Building </li>
</ul>

All of these might have a attribute of color, but only the computers will have an IP Address. However, we want to be able to search all computers based on the IP address. Just to make it more difficult, Laptops, Servers and Desktops are all computers.


My solution at this time is to create another model, which I have called Attributes. This has the following layout:


<table class="CodeRay"><tr>
  <td class="line_numbers" title="click to toggle" onclick="with (this.firstChild.style) { display = (display == '') ? 'none' : '' }"><pre>1<tt>
</tt>2<tt>
</tt>3<tt>
</tt>4<tt>
</tt><strong>5</strong><tt>
</tt>6<tt>
</tt>7<tt>
</tt>8<tt>
</tt>9<tt>
</tt><strong>10</strong><tt>
</tt></pre></td>
  <td class="code"><pre ondblclick="with (this.style) { overflow = (overflow == 'auto' || overflow == '') ? 'visible' : 'auto' }"><span class="r">class</span> <span class="cl">Attribute</span> &lt; <span class="co">ActiveRecord</span>::<span class="co">Base</span><tt>
</tt>  belongs_to <span class="sy">:owner</span>, <span class="sy">:polymorphic</span> =&gt; <span class="sy">:true</span><tt>
</tt>  <tt>
</tt> <span class="c"># Attribute has the following fields:</span><tt>
</tt> <span class="c"># owner_type as string</span><tt>
</tt> <span class="c"># owner_id as integer</span><tt>
</tt> <span class="c"># type as string</span><tt>
</tt> <span class="c"># value as string</span><tt>
</tt><tt>
</tt> <span class="r">end</span></pre></td>
</tr></table>


Each of my models which will use these will include the has_many directive:


<table class="CodeRay"><tr>
  <td class="line_numbers" title="click to toggle" onclick="with (this.firstChild.style) { display = (display == '') ? 'none' : '' }"><pre><tt>
</tt></pre></td>
  <td class="code"><pre ondblclick="with (this.style) { overflow = (overflow == 'auto' || overflow == '') ? 'visible' : 'auto' }"> has_many <span class="sy">:attribute</span>, <span class="sy">:as</span> =&gt; <span class="sy">:owner</span></pre></td>
</tr></table>


When a new instance of a model is created, I run an after_create function (which I cleverly call Templater) which figures out which type (or species) of model is being created, and pre-populates a default set of attributes.


For example, a Laptop might be created with the attributes: <span class="caps">CPU</span>, RAM, IP Address, and OS. In fact, all computers could be created with that same default set of attributes. Then, when we decide to build a query that gives us all computers with less them 1024 megs of <span class="caps">RAM</span>, we can simply search the attributes table for all records where type is <span class="caps">RAM</span> and value is less then 1024, and return their owner ID's.