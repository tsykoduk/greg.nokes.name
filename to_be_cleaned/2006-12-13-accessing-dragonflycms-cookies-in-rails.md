---
id: 1656
title: Accessing DragonflyCMS cookies in Rails
date: 2006-12-13T17:19:00+00:00
author: tsykoduk
layout: post
guid: 30/2008/12/27/accessing-dragonflycms-cookies-in-rails
permalink: /2006/12/13/accessing-dragonflycms-cookies-in-rails/
categories:
  - Computers! and Code!
---
<p>At work, we run two <a href="">DragonflyCMS</a> sites (soon to become <a href="">Nexos</a>). As I do not do much in php except hack, when I was tasked with writing an application which used the authentication token generated by the DragonflyCMS site, I decided to do it in Ruby/Ruby on Rails. This posed a bit of a question. How do I check authentication and get the username out of a <span class="caps">PHP</span> based application?</p>


<p>The Rails Wiki had a good article on checking authentication vs a phpBB site, and that gave me the springboard that I needed.</p>


<p>I created a user, group, user_group and session model as follows:</p>


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
</tt>11<tt>
</tt>12<tt>
</tt>13<tt>
</tt>14<tt>
</tt><strong>15</strong><tt>
</tt></pre></td>
  <td class="code"><pre ondblclick="with (this.style) { overflow = (overflow == 'auto' || overflow == '') ? 'visible' : 'auto' }"><span class="r">class</span> <span class="cl">User</span> &lt; <span class="co">ActiveRecord</span>::<span class="co">Base</span><tt>
</tt><tt>
</tt>  establish_connection(<tt>
</tt>  <span class="sy">:adapter</span> =&gt; <span class="s"><span class="dl">&quot;</span><span class="k">mysql</span><span class="dl">&quot;</span></span>,<tt>
</tt>  <span class="sy">:host</span> =&gt; <span class="s"><span class="dl">&quot;</span><span class="k">localhost</span><span class="dl">&quot;</span></span>,<tt>
</tt>  <span class="sy">:database</span> =&gt; <span class="s"><span class="dl">&quot;</span><span class="k">dbname</span><span class="dl">&quot;</span></span>,<tt>
</tt>  <span class="sy">:username</span> =&gt; <span class="s"><span class="dl">&quot;</span><span class="k">username</span><span class="dl">&quot;</span></span>,<tt>
</tt>  <span class="sy">:password</span> =&gt; <span class="s"><span class="dl">&quot;</span><span class="k">somepassword</span><span class="dl">&quot;</span></span>)<tt>
</tt>  <tt>
</tt>  has_many                  <span class="sy">:session</span><tt>
</tt>  has_many                  <span class="sy">:group</span><tt>
</tt>  set_table_name            <span class="sy">:cms_users</span> <tt>
</tt>  set_primary_key           <span class="sy">:user_id</span><tt>
</tt><tt>
</tt><span class="r">end</span></pre></td>
</tr></table>


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
</tt>11<tt>
</tt>12<tt>
</tt>13<tt>
</tt>14<tt>
</tt></pre></td>
  <td class="code"><pre ondblclick="with (this.style) { overflow = (overflow == 'auto' || overflow == '') ? 'visible' : 'auto' }"><span class="r">class</span> <span class="cl">Group</span> &lt; <span class="co">ActiveRecord</span>::<span class="co">Base</span><tt>
</tt><tt>
</tt>  establish_connection(<tt>
</tt>  <span class="sy">:adapter</span> =&gt; <span class="s"><span class="dl">&quot;</span><span class="k">mysql</span><span class="dl">&quot;</span></span>,<tt>
</tt>  <span class="sy">:host</span> =&gt; <span class="s"><span class="dl">&quot;</span><span class="k">localhost</span><span class="dl">&quot;</span></span>,<tt>
</tt>  <span class="sy">:database</span> =&gt; <span class="s"><span class="dl">&quot;</span><span class="k">dbname</span><span class="dl">&quot;</span></span>,<tt>
</tt>  <span class="sy">:username</span> =&gt; <span class="s"><span class="dl">&quot;</span><span class="k">username</span><span class="dl">&quot;</span></span>,<tt>
</tt>  <span class="sy">:password</span> =&gt; <span class="s"><span class="dl">&quot;</span><span class="k">somepassword</span><span class="dl">&quot;</span></span>)<tt>
</tt>  <tt>
</tt>    set_table_name          <span class="sy">:cms_bbgroups</span><tt>
</tt>    belongs_to              <span class="sy">:user</span><tt>
</tt>    set_primary_key         <span class="sy">:group_id</span><tt>
</tt><tt>
</tt><span class="r">end</span></pre></td>
</tr></table>


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
</tt>11<tt>
</tt>12<tt>
</tt>13<tt>
</tt>14<tt>
</tt><strong>15</strong><tt>
</tt></pre></td>
  <td class="code"><pre ondblclick="with (this.style) { overflow = (overflow == 'auto' || overflow == '') ? 'visible' : 'auto' }"><span class="r">class</span> <span class="cl">User_Group</span> &lt; <span class="co">ActiveRecord</span>::<span class="co">Base</span><tt>
</tt><tt>
</tt>  establish_connection(<tt>
</tt>  <span class="sy">:adapter</span> =&gt; <span class="s"><span class="dl">&quot;</span><span class="k">mysql</span><span class="dl">&quot;</span></span>,<tt>
</tt>  <span class="sy">:host</span> =&gt; <span class="s"><span class="dl">&quot;</span><span class="k">localhost</span><span class="dl">&quot;</span></span>,<tt>
</tt>  <span class="sy">:database</span> =&gt; <span class="s"><span class="dl">&quot;</span><span class="k">dbname</span><span class="dl">&quot;</span></span>,<tt>
</tt>  <span class="sy">:username</span> =&gt; <span class="s"><span class="dl">&quot;</span><span class="k">username</span><span class="dl">&quot;</span></span>,<tt>
</tt>  <span class="sy">:password</span> =&gt; <span class="s"><span class="dl">&quot;</span><span class="k">somepassword</span><span class="dl">&quot;</span></span>)<tt>
</tt>  <tt>
</tt>  has_many                    <span class="sy">:group</span><tt>
</tt>  belongs_to                  <span class="sy">:user</span><tt>
</tt>  set_table_name              <span class="sy">:cms_bbuser_group</span><tt>
</tt>  set_primary_key             <span class="sy">:group_id</span><tt>
</tt><tt>
</tt><span class="r">end</span></pre></td>
</tr></table>


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
</tt>11<tt>
</tt>12<tt>
</tt>13<tt>
</tt>14<tt>
</tt></pre></td>
  <td class="code"><pre ondblclick="with (this.style) { overflow = (overflow == 'auto' || overflow == '') ? 'visible' : 'auto' }"><span class="r">class</span> <span class="cl">Sessions</span> &lt; <span class="co">ActiveRecord</span>::<span class="co">Base</span><tt>
</tt><tt>
</tt>    establish_connection(<tt>
</tt>    <span class="sy">:adapter</span> =&gt; <span class="s"><span class="dl">&quot;</span><span class="k">mysql</span><span class="dl">&quot;</span></span>,<tt>
</tt>    <span class="sy">:host</span> =&gt; <span class="s"><span class="dl">&quot;</span><span class="k">localhost</span><span class="dl">&quot;</span></span>,<tt>
</tt>    <span class="sy">:database</span> =&gt; <span class="s"><span class="dl">&quot;</span><span class="k">dbname</span><span class="dl">&quot;</span></span>,<tt>
</tt>    <span class="sy">:username</span> =&gt; <span class="s"><span class="dl">&quot;</span><span class="k">someuser</span><span class="dl">&quot;</span></span>,<tt>
</tt>    <span class="sy">:password</span> =&gt; <span class="s"><span class="dl">&quot;</span><span class="k">otherpassword</span><span class="dl">&quot;</span></span>)<tt>
</tt>    <tt>
</tt>    belongs_to                  <span class="sy">:user</span><tt>
</tt>    set_table_name              <span class="sy">:cms_session</span><tt>
</tt>    set_primary_key             <span class="sy">:uname</span><tt>
</tt>  <tt>
</tt> <span class="r">end</span></pre></td>
</tr></table>


<p>This allows us to connect to the DragonflyCMS database, and get information about the users, groups and sessions. I pulled this directly from the wonderful wiki article.</p>


<p>As per the wiki, I set up a before filter in my application.rb - but I had to modify it quite a bit..</p>


<table class="CodeRay"><tr>
  <td class="line_numbers" title="click to toggle" onclick="with (this.firstChild.style) { display = (display == '') ? 'none' : '' }"><pre>1<tt>
</tt>2<tt>
</tt>3<tt>
</tt>4<tt>
</tt><strong>5</strong><tt>
</tt></pre></td>
  <td class="code"><pre ondblclick="with (this.style) { overflow = (overflow == 'auto' || overflow == '') ? 'visible' : 'auto' }">   before_filter <span class="sy">:has_session</span><tt>
</tt><tt>
</tt>   <span class="r">def</span> <span class="fu">has_session</span>()<tt>
</tt><tt>
</tt>      <span class="r">if</span> session[<span class="sy">:user_id</span>].nil?<tt>
</tt></pre></td>
</tr></table>


<p>We have run the before filter and started the module to check the authentication. One of the things that I decided to do differently was check to see if we already had a session or not. It seemed to me that we could save some time by bypassing all of the work below if we already had the session set up. Now, we are read in the cookie:</p>


<table class="CodeRay"><tr>
  <td class="line_numbers" title="click to toggle" onclick="with (this.firstChild.style) { display = (display == '') ? 'none' : '' }"><pre>1<tt>
</tt></pre></td>
  <td class="code"><pre ondblclick="with (this.style) { overflow = (overflow == 'auto' || overflow == '') ? 'visible' : 'auto' }">         sid = <span class="co">Base64</span>.decode64(cookies[<span class="sy">:my_login</span>]).split(<span class="s"><span class="dl">'</span><span class="k">:</span><span class="dl">'</span></span>)<tt>
</tt></pre></td>
</tr></table>


<p>DragonflyCMS uses base64 encoding for it's cookies, and also uses a ':' as a field delimiter. So, we read the cookie in, decode it, and split it. We know that the user ID is the first field in the cookie, so we can do this:</p>


<table class="CodeRay"><tr>
  <td class="line_numbers" title="click to toggle" onclick="with (this.firstChild.style) { display = (display == '') ? 'none' : '' }"><pre>1<tt>
</tt>2<tt>
</tt>3<tt>
</tt></pre></td>
  <td class="code"><pre ondblclick="with (this.style) { overflow = (overflow == 'auto' || overflow == '') ? 'visible' : 'auto' }">        t = <span class="co">User</span>.find_by_user_id(sid[<span class="i">0</span>])<tt>
</tt><tt>
</tt>        <span class="r">if</span> s = <span class="co">Sessions</span>.find_by_uname(t.username)</pre></td>
</tr></table>


<p>We take the user ID out of the cookie, and cross reference it with the Users model to insure that the user really exists in the DragonflyCMS system. We then check if the username has a active session in the sessions table, and presto! we have a live user who is authenticated vs the dragonfly system.</p>


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
</tt>11<tt>
</tt>12<tt>
</tt>13<tt>
</tt>14<tt>
</tt><strong>15</strong><tt>
</tt>16<tt>
</tt></pre></td>
  <td class="code"><pre ondblclick="with (this.style) { overflow = (overflow == 'auto' || overflow == '') ? 'visible' : 'auto' }">            <span class="r">if</span> <span class="co">Person</span>.find_by_name(t.username)<tt>
</tt>               session[<span class="sy">:user_id</span>] = <span class="co">Person</span>.find_by_name(t.username).id<tt>
</tt>               session[<span class="sy">:username</span>] = t.username<tt>
</tt>            <span class="r">else</span><tt>
</tt>               <span class="iv">@person</span> = <span class="co">Person</span>.new(<span class="sy">:name</span> =&gt; t.username)<tt>
</tt>               <span class="r">if</span> <span class="iv">@person</span>.save<tt>
</tt>                  flash[<span class="sy">:notice</span>] = <span class="s"><span class="dl">&quot;</span><span class="k">Welcome to Application, </span><span class="dl">&quot;</span></span> + <span class="iv">@person</span>.name + <span class="s"><span class="dl">&quot;</span><span class="k">! Please take the time to fill<tt>
</tt>in all of the required information.</span><span class="dl">&quot;</span></span><tt>
</tt>                  redirect_to <span class="sy">:controller</span> =&gt; <span class="s"><span class="dl">'</span><span class="k">people</span><span class="dl">'</span></span>, <span class="sy">:action</span> =&gt; <span class="s"><span class="dl">'</span><span class="k">edit</span><span class="dl">'</span></span>, <span class="sy">:id</span> =&gt; <span class="iv">@person</span>.id<tt>
</tt>               <span class="r">else</span><tt>
</tt>                  <span class="c">#If we are here, it's a major WTF</span><tt>
</tt>                  flash[<span class="sy">:notice</span>] = <span class="s"><span class="dl">&quot;</span><span class="k">Some strange error occured. Perhaps you had chocolate chips in your cookies?</span><span class="dl">&quot;</span></span><tt>
</tt>                  render <span class="sy">:controller</span> =&gt; <span class="s"><span class="dl">'</span><span class="k">welcome</span><span class="dl">'</span></span>, <span class="sy">:action</span> =&gt; <span class="s"><span class="dl">'</span><span class="k">index</span><span class="dl">'</span></span><tt>
</tt><tt>
</tt>               <span class="r">end</span><tt>
</tt>            <span class="r">end</span></pre></td>
</tr></table>


<p>That huge chunk of code does a lot of stuff!</p>


<p>First, since we have a live user, we want to check to see if they have logged into our application before. I have a model called 'Person' which contains some information about the user that this application needs.</p>


<p>If they have not logged in before, we build them a new person object, and dump them into their edit page so they can fill out all of the neato little fields.</p>


<p>If they have logged in before, we create the session information in Rails which will allow us to authenticate them vs various models and functions as we need to.</p>


<table class="CodeRay"><tr>
  <td class="line_numbers" title="click to toggle" onclick="with (this.firstChild.style) { display = (display == '') ? 'none' : '' }"><pre>1<tt>
</tt>2<tt>
</tt>3<tt>
</tt>4<tt>
</tt><strong>5</strong><tt>
</tt></pre></td>
  <td class="code"><pre ondblclick="with (this.style) { overflow = (overflow == 'auto' || overflow == '') ? 'visible' : 'auto' }">         <span class="r">else</span><tt>
</tt>            session[<span class="sy">:user_id</span>] = <span class="pc">nil</span><tt>
</tt>         <span class="r">end</span><tt>
</tt>      <span class="r">end</span><tt>
</tt>   <span class="r">end</span></pre></td>
</tr></table>


<p>If all else fails, we make the session information read Nil, so that next time a page loads or what have you, we check again to make sure that the have not logged in elsewhere.</p>


<p>I also have been thinking about ways of increasing security. DragonflyCMS records the IP address of the session's user - it would be trivial to cross check that as well to insure that the cookie is not forged. As this application resides on an intranet, I have not implemented that level of cross-checking yet, but probably will in the future.</p>