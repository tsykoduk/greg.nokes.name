---
id: 2944
title: AD vs Ruby vs Me
date: 2007-10-04T21:44:00+00:00
author: tsykoduk
layout: post
guid: 30/2008/12/27/ad-vs-ruby-vs-me
permalink: /2007/10/04/ad-vs-ruby-vs-me/
categories:
  - Computers! and Code!
---
<p>So, I was tasked to create a authentication system for one of the apps that I wrote a while back at work. I had written the application in Ruby on Rails, and we use Microsoft's Active Directory for network authentication. Taking pity on the users of my application, I decided to do some research and see if I could bump my authentication vs the <span class="caps">AD LDAP</span> server. This is what I came up with...</p>

            <!--more-->

            <p>First things first - we need to add the secret sauce to the model which will allow use to connect to a <span class="caps">LDAP</span> server. We want to add the following function to the model that handles your users. We also need to add a <code>require 'ldap'</code> to the model, before the class definition. You also want to define <code>AD_DOMAIN_NAME</code> to be what ever the domain that your users will be logging into.</p>


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
</tt>17<tt>
</tt>18<tt>
</tt>19<tt>
</tt><strong>20</strong><tt>
</tt>21<tt>
</tt>22<tt>
</tt>23<tt>
</tt>24<tt>
</tt><strong>25</strong><tt>
</tt></pre></td>
  <td class="code"><pre ondblclick="with (this.style) { overflow = (overflow == 'auto' || overflow == '') ? 'visible' : 'auto' }">  attr_accessor <span class="sy">:password</span><tt>
</tt>  <tt>
</tt>  <span class="r">def</span> <span class="pc">self</span>.login(login, password, host)<tt>
</tt>    <span class="r">begin</span><tt>
</tt>      <span class="r">if</span> password.nil? || password == <span class="s"><span class="dl">&quot;</span><span class="dl">&quot;</span></span> || login.nil? || login == <span class="s"><span class="dl">&quot;</span><span class="dl">&quot;</span></span><tt>
</tt>        <span class="r">return</span> <span class="pc">false</span><tt>
</tt>      <span class="r">else</span><tt>
</tt>        conn = <span class="co">LDAP</span>::<span class="co">Conn</span>.new(host, <span class="i">389</span>)<tt>
</tt>        conn.set_option(<span class="co">LDAP</span>::<span class="co">LDAP_OPT_PROTOCOL_VERSION</span>, <span class="i">3</span> )<tt>
</tt>        fulllogin = <span class="co">AD_DOMAIN_NAME</span> + login<tt>
</tt>        conn.bind(fulllogin, password)<tt>
</tt>        <span class="r">if</span> conn.err == <span class="i">0</span><tt>
</tt>          conn.unbind<tt>
</tt>          <span class="r">return</span> <span class="pc">true</span><tt>
</tt>        <span class="r">else</span><tt>
</tt>          conn.unbind<tt>
</tt>          <span class="r">return</span> <span class="pc">false</span><tt>
</tt>        <span class="r">end</span><tt>
</tt>      <span class="r">end</span><tt>
</tt>      <tt>
</tt>    <span class="r">rescue</span><tt>
</tt>      <span class="r">return</span> <span class="pc">false</span><tt>
</tt>    <span class="r">end</span><tt>
</tt>  <tt>
</tt>  <span class="r">end</span></pre></td>
</tr></table>


<p>I also added the following to allow me to create the basic user skeleton with out the validations running on it.</p>


<table class="CodeRay"><tr>
  <td class="line_numbers" title="click to toggle" onclick="with (this.firstChild.style) { display = (display == '') ? 'none' : '' }"><pre>1<tt>
</tt>2<tt>
</tt>3<tt>
</tt></pre></td>
  <td class="code"><pre ondblclick="with (this.style) { overflow = (overflow == 'auto' || overflow == '') ? 'visible' : 'auto' }">  <span class="r">def</span> <span class="fu">build</span><tt>
</tt>      <span class="pc">self</span>.save(<span class="pc">false</span>)<tt>
</tt>  <span class="r">end</span></pre></td>
</tr></table>


<p>I did not want the users passwords to be recorded in the log files, so we need to add this to the application controller</p>


<table class="CodeRay"><tr>
  <td class="line_numbers" title="click to toggle" onclick="with (this.firstChild.style) { display = (display == '') ? 'none' : '' }"><pre><tt>
</tt></pre></td>
  <td class="code"><pre ondblclick="with (this.style) { overflow = (overflow == 'auto' || overflow == '') ? 'visible' : 'auto' }">   filter_parameter_logging <span class="sy">:password</span></pre></td>
</tr></table>


<p>Now, we need to add some code to the controller which controls your users and their authentication. I use the following</p>


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
</tt>17<tt>
</tt>18<tt>
</tt>19<tt>
</tt><strong>20</strong><tt>
</tt>21<tt>
</tt>22<tt>
</tt>23<tt>
</tt>24<tt>
</tt><strong>25</strong><tt>
</tt>26<tt>
</tt>27<tt>
</tt>28<tt>
</tt>29<tt>
</tt><strong>30</strong><tt>
</tt></pre></td>
  <td class="code"><pre ondblclick="with (this.style) { overflow = (overflow == 'auto' || overflow == '') ? 'visible' : 'auto' }">  <span class="r">def</span> <span class="fu">authenticate</span><tt>
</tt>   temp = params[<span class="sy">:login</span>]<tt>
</tt>   <span class="r">if</span> <span class="co">User</span>.login(temp[<span class="sy">:userid</span>], temp[<span class="sy">:password</span>], <span class="co">LDAP_SERVER</span>)<tt>
</tt>     <span class="r">if</span> <span class="iv">@user</span> = <span class="co">User</span>.find_by_userid(temp[<span class="sy">:userid</span>].downcase)<tt>
</tt>       <span class="iv">@user</span>.last_login = <span class="co">Time</span>.now<tt>
</tt>       <span class="iv">@user</span>.save<tt>
</tt>       session[<span class="sy">:id</span>] = <span class="iv">@user</span>.id<tt>
</tt>       flash[<span class="sy">:notice</span>] = <span class="s"><span class="dl">'</span><span class="k">Login Successful! &lt;br/&gt; Welcome back, </span><span class="dl">'</span></span> + <span class="iv">@user</span>.firstname<tt>
</tt>       session[<span class="sy">:timeout</span>] = <span class="co">Time</span>.now<tt>
</tt>       redirect_to <span class="sy">:controller</span> =&gt; <span class="s"><span class="dl">'</span><span class="k">tickets</span><span class="dl">'</span></span>, <span class="sy">:action</span> =&gt; <span class="s"><span class="dl">'</span><span class="k">new</span><span class="dl">'</span></span><tt>
</tt>     <span class="r">else</span><tt>
</tt>       <span class="iv">@newuser</span> = <span class="co">User</span>.new<tt>
</tt>       <span class="iv">@newuser</span>.userid = temp[<span class="sy">:userid</span>].downcase<tt>
</tt>       <span class="iv">@newuser</span>.last_login = <span class="co">Time</span>.now<tt>
</tt>       session[<span class="sy">:timeout</span>] = <span class="co">Time</span>.now<tt>
</tt>       <span class="r">if</span> <span class="iv">@newuser</span>.build<tt>
</tt>         session[<span class="sy">:id</span>] = <span class="iv">@newuser</span>.id<tt>
</tt>         flash[<span class="sy">:notice</span>] = <span class="s"><span class="dl">'</span><span class="k">Please update your information</span><span class="dl">'</span></span><tt>
</tt>         redirect_to <span class="sy">:action</span> =&gt; <span class="s"><span class="dl">&quot;</span><span class="k">myaccount</span><span class="dl">&quot;</span></span><tt>
</tt>       <span class="r">else</span><tt>
</tt>         flash[<span class="sy">:warning</span>] = <span class="s"><span class="dl">'</span><span class="k">Error saving your account information</span><span class="dl">'</span></span><tt>
</tt>         reset_session()<tt>
</tt>         redirect_to <span class="sy">:controller</span> =&gt; <span class="s"><span class="dl">'</span><span class="k">users</span><span class="dl">'</span></span>, <span class="sy">:action</span> =&gt; <span class="s"><span class="dl">'</span><span class="k">index</span><span class="dl">'</span></span><tt>
</tt>      <span class="r">end</span><tt>
</tt>    <span class="r">end</span><tt>
</tt>   <span class="r">else</span><tt>
</tt>     flash[<span class="sy">:warning</span>] = <span class="s"><span class="dl">'</span><span class="k">Login Failed! Please verify your user ID and password and try again</span><span class="dl">'</span></span><tt>
</tt>     redirect_to <span class="sy">:action</span> =&gt; <span class="s"><span class="dl">'</span><span class="k">login</span><span class="dl">'</span></span><tt>
</tt>  <span class="r">end</span> <tt>
</tt> <span class="r">end</span></pre></td>
</tr></table>


<p>What does this mess do? Let's look at it.</p>


<p>First we assume that we have a form already hooked up to this function. When we call this, we assume that we have been passed 2 values, <code>userid</code> and <code>password</code>. We assume that we have defined <code>LDAP_SERVER = "your_server"</code> some where else in the controller.</p>


<p>So, first things, we pass the user name and password to the model and attempt to authenticate. We check to assure that none of the fields are blank. The line <code>if password.nil? || password == "" || login.nil? || login == ""</code> takes care of this, and we pass a <code>false</code> value back to the calling function if any of it is true.</p>


<p>Next, we need to set up the connection to the <span class="caps">LDAP</span> server <code>conn = LDAP::Conn.new(host, 389)</code> and <code>conn.set_option(LDAP::LDAP_OPT_PROTOCOL_VERSION, 3 )</code>  takes care of this. Assuming that everything works, we now have a good connection to the <span class="caps">LDAP</span> server. You can test this assumption with <code>conn.bound?</code> (for example, from the console).</p>


<p>We need to pass the user name and password to the connection and see if we get a positive result from the resultant credentials check. <code>fulllogin = AD_DOMAIN_NAME + login</code> formats the ad domain name and user name correctly, and then <code>conn.bind(fulllogin, password)</code> sends the credentials off to the <span class="caps">LDAP</span> server. It will pause, and then return the <span class="caps">LDAP</span> object.</p>


<p>This is all well and good, but did we log in? <code>if conn.err == 0</code> checks the error code returned when we tried to authenticate. If we have anything other then 0, we had problems, so we toss a false back up to the calling function. If we get a 0 back, then we toss a <code>true</code> back up to calling function and press on.</p>


<p>Let's assume that we get a true back in the controller. So, the user has provided AD a good user name and password. We might have some information that we want to cache locally in the application for performance reasons. For example, I cache the users email address, first name and last name. I made a design choice to keep my applications interaction with AD as little as possible, so I do not pull that information from it.</p>


<p>If the controller can find a user record with the same user name as the user name which was provided, we press on. If not, we pop the user over to their 'My Account' page and force them to fill out a form which captures the data that we need.</p>


<p>We then save that data to the local database. Auto populating the database with information from AD is left to the gentle reader.</p>