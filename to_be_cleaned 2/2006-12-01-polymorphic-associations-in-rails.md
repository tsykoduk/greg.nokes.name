---
id: 1618
title: Polymorphic associations in Rails
date: 2006-12-01T17:53:00+00:00
author: tsykoduk
layout: post
guid: 30/2008/12/27/polymorphic-associations-in-rails
permalink: /2006/12/01/polymorphic-associations-in-rails/
categories:
  - Computers! and Code!
---
<p>In a project that I am working on, I finally needed to dig into polymorphic associations in Rails Models.</p>


<p>If you just thought to yourself '<em>Hu? <span class="caps">WTH</span> is this freak talking about?</em>' let me give you a little background.</p>


<p>Rails is built around a '<a href="http://en.wikipedia.org/wiki/Model-view-controller"><span class="caps">MVC</span></a>' model of programming. So, each program is logically broken up into three parts - The Model (the data), The View (the part the user interacts with) and the Controller, (the part that interacts between the data and the the user).</p>


<p>Delving into the model - chunks of data can have some sort of relationship. For example, an address could be associated with a person. People could have many addresses (home, work, favorite bar). In railspeak, that is called a has_many relationship. People has_many addresses, and addresses belongs_to people. However, we can get into problems - dogs have addresses to. They tend to live in a house with people, and you can send them mail. So - let's see what this looks like:</p>


<table class="CodeRay"><tr>
  <td class="line_numbers" title="click to toggle" onclick="with (this.firstChild.style) { display = (display == '') ? 'none' : '' }"><pre>1<tt>
</tt>2<tt>
</tt>3<tt>
</tt>4<tt>
</tt></pre></td>
  <td class="code"><pre ondblclick="with (this.style) { overflow = (overflow == 'auto' || overflow == '') ? 'visible' : 'auto' }"><span class="r">class</span> <span class="cl">Address</span> &lt; <span class="co">ActiveRecord</span>::<span class="co">Base</span><tt>
</tt>  belongs_to <span class="sy">:person</span><tt>
</tt>  belongs_to <span class="sy">:dog</span><tt>
</tt><span class="r">end</span></pre></td>
</tr></table>


<p>But the problem with that is that an address belongs to <strong>both</strong> a person and a dog. What about those happy homes who have no dogs? Or that have a cat, instead? we need a belongs_to 'or' statement.</p>


<p>Enter the polymorph.</p>


<table class="CodeRay"><tr>
  <td class="line_numbers" title="click to toggle" onclick="with (this.firstChild.style) { display = (display == '') ? 'none' : '' }"><pre>1<tt>
</tt>2<tt>
</tt>3<tt>
</tt></pre></td>
  <td class="code"><pre ondblclick="with (this.style) { overflow = (overflow == 'auto' || overflow == '') ? 'visible' : 'auto' }"><span class="r">class</span> <span class="cl">Address</span> &lt; <span class="co">ActiveRecord</span>::<span class="co">Base</span><tt>
</tt>  belongs_to <span class="sy">:owner</span>, <span class="sy">:polymorphic</span> =&gt; <span class="pc">true</span><tt>
</tt><span class="r">end</span></pre></td>
</tr></table>


<p>This says an address belongs to a class of thing called <em>owner</em>. It will look for two columns in the database : owner_type (to record what model owns that record) and owner_id (to record the id of the model that owns it).</p>


<p>So, now we have the address all set up! But, what about the other side? How do we tell the people, dogs and cats that they can have an address?</p>


<table class="CodeRay"><tr>
  <td class="line_numbers" title="click to toggle" onclick="with (this.firstChild.style) { display = (display == '') ? 'none' : '' }"><pre>1<tt>
</tt>2<tt>
</tt>3<tt>
</tt></pre></td>
  <td class="code"><pre ondblclick="with (this.style) { overflow = (overflow == 'auto' || overflow == '') ? 'visible' : 'auto' }"><span class="r">class</span> <span class="cl">Person</span> &lt; <span class="co">ActiveRecord</span>::<span class="co">Base</span><tt>
</tt>  has_many <span class="sy">:address</span> <tt>
</tt><span class="r">end</span></pre></td>
</tr></table>


<p>This is how we tell rails that a person could <em>have many</em> addresses, Rails would expect to find a column called person_id in the addresses table. However, there is not a column called person_id, as the address model does not belong to an person. Addresses belong to owners. How do we tell Rails that it should find all of the addresses for owner type 'person' where the id is what ever the id number is?</p>


<p>Well, Rails has a way. Imagine that.</p>


<table class="CodeRay"><tr>
  <td class="line_numbers" title="click to toggle" onclick="with (this.firstChild.style) { display = (display == '') ? 'none' : '' }"><pre>1<tt>
</tt>2<tt>
</tt>3<tt>
</tt></pre></td>
  <td class="code"><pre ondblclick="with (this.style) { overflow = (overflow == 'auto' || overflow == '') ? 'visible' : 'auto' }"><span class="r">class</span> <span class="cl">Person</span> &lt; <span class="co">ActiveRecord</span>::<span class="co">Base</span><tt>
</tt>has_many <span class="sy">:address</span> <span class="sy">:as</span> =&gt; <span class="sy">:owner</span><tt>
</tt><span class="r">end</span></pre></td>
</tr></table>


<p>So now, we in people_controller we can say things like:</p>


<table class="CodeRay"><tr>
  <td class="line_numbers" title="click to toggle" onclick="with (this.firstChild.style) { display = (display == '') ? 'none' : '' }"><pre>1<tt>
</tt>2<tt>
</tt>3<tt>
</tt>4<tt>
</tt></pre></td>
  <td class="code"><pre ondblclick="with (this.style) { overflow = (overflow == 'auto' || overflow == '') ? 'visible' : 'auto' }"><span class="r">def</span> <span class="fu">find_addy</span> ()<tt>
</tt>  <span class="iv">@dog</span> = <span class="co">Site</span>.find_by_id(params[<span class="sy">:id</span>])<tt>
</tt>  <span class="iv">@address</span> = <span class="iv">@dog</span>.address<tt>
</tt><span class="r">end</span></pre></td>
</tr></table>


<p>The @dog.address will automagically return us the address associated with the site contained in @dog. We can also say other cool things like @dog.address.create, which will create a new address associated with the site in @dog.</p>


And, if we later decide to add cats to the mix, we simply add
<table class="CodeRay"><tr>
  <td class="line_numbers" title="click to toggle" onclick="with (this.firstChild.style) { display = (display == '') ? 'none' : '' }"><pre><tt>
</tt></pre></td>
  <td class="code"><pre ondblclick="with (this.style) { overflow = (overflow == 'auto' || overflow == '') ? 'visible' : 'auto' }">has_many <span class="sy">:address</span>, <span class="sy">:as</span> =&gt; <span class="sy">:owner</span></pre></td>
</tr></table>


<p>to the Cat model, and Bam! Chili fries!</p>