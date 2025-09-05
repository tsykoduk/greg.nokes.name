---
id: 470
title: AD vs Ruby vs Me
date: 2007-10-04T21:44:00+00:00
author: tsykoduk
layout: post
guid: https://greg.nokes.name/?p=470
permalink: /2007/10/04/ad-vs-ruby-vs-me/
categories:
  - Computers! and Code!
description: "Learn how to integrate Ruby on Rails with Microsoft Active Directory for seamless LDAP authentication. Complete code examples and setup guide included."
---
<p>So, I was tasked to create a authentication system for one of the apps that I wrote a while back at work. I had written the application in Ruby on Rails, and we use Microsoft's Active Directory for network authentication. Taking pity on the users of my application, I decided to do some research and see if I could bump my authentication vs the <span class="caps">AD LDAP</span> server. This is what I came up with...</p>

<!--more-->

<p>First things first - we need to add the secret sauce to the model which will allow use to connect to a <span class="caps">LDAP</span> server. We want to add the following function to the model that handles your users. We also need to add a <code>require 'ldap'</code> to the model, before the class definition. You also want to define <code>AD_DOMAIN_NAME</code> to be what ever the domain that your users will be logging into.</p>

```ruby
  attr_accessor :password
  
  def self.login(login, password, host)
    begin
      if password.nil? || password == "" || login.nil? || login == ""
        return false
      else
        conn = LDAP::Conn.new(host, 389)
        conn.set_option(LDAP::LDAP_OPT_PROTOCOL_VERSION, 3 )
        fulllogin = AD_DOMAIN_NAME + login
        conn.bind(fulllogin, password)
        if conn.err == 0
          conn.unbind
          return true
        else
          conn.unbind
          return false
        end
      end
      
    rescue
      return false
    end
  
  end
```

I also added the following to allow me to create the basic user skeleton with out the validations running on it.

```ruby  
  def build
      self.save(false)
  end
```

I did not want the users passwords to be recorded in the log files, so we need to add this to the application controller

```ruby
 filter_parameter_logging :password
```

Now, we need to add some code to the controller which controls your users and their authentication. I use the following

```ruby
  def authenticate
   temp = params[:login]
   if User.login(temp[:userid], temp[:password], LDAP_SERVER)
     if @user = User.find_by_userid(temp[:userid].downcase)
       @user.last_login = Time.now
       @user.save
       session[:id] = @user.id
       flash[:notice] = 'Login Successful! <br/> Welcome back, ' + @user.firstname
       session[:timeout] = Time.now
       redirect_to :controller => 'tickets', :action => 'new'
     else
       @newuser = User.new
       @newuser.userid = temp[:userid].downcase
       @newuser.last_login = Time.now
       session[:timeout] = Time.now
       if @newuser.build
         session[:id] = @newuser.id
         flash[:notice] = 'Please update your information'
         redirect_to :action => "myaccount"
       else
         flash[:warning] = 'Error saving your account information'
         reset_session()
         redirect_to :controller => 'users', :action => 'index'
      end
    end
   else
     flash[:warning] = 'Login Failed! Please verify your user ID and password and try again'
     redirect_to :action => 'login'
  end 
 end
```

<p>What does this mess do? Let's look at it.</p>


<p>First we assume that we have a form already hooked up to this function. When we call this, we assume that we have been passed 2 values, <code>userid</code> and <code>password</code>. We assume that we have defined <code>LDAP_SERVER = "your_server"</code> some where else in the controller.</p>


<p>So, first things, we pass the user name and password to the model and attempt to authenticate. We check to assure that none of the fields are blank. The line <code>if password.nil? || password == "" || login.nil? || login == ""</code> takes care of this, and we pass a <code>false</code> value back to the calling function if any of it is true.</p>


<p>Next, we need to set up the connection to the <span class="caps">LDAP</span> server <code>conn = LDAP::Conn.new(host, 389)</code> and <code>conn.set_option(LDAP::LDAP_OPT_PROTOCOL_VERSION, 3 )</code>  takes care of this. Assuming that everything works, we now have a good connection to the <span class="caps">LDAP</span> server. You can test this assumption with <code>conn.bound?</code> (for example, from the console).</p>


<p>We need to pass the user name and password to the connection and see if we get a positive result from the resultant credentials check. <code>fulllogin = AD_DOMAIN_NAME + login</code> formats the ad domain name and user name correctly, and then <code>conn.bind(fulllogin, password)</code> sends the credentials off to the <span class="caps">LDAP</span> server. It will pause, and then return the <span class="caps">LDAP</span> object.</p>


<p>This is all well and good, but did we log in? <code>if conn.err == 0</code> checks the error code returned when we tried to authenticate. If we have anything other then 0, we had problems, so we toss a false back up to the calling function. If we get a 0 back, then we toss a <code>true</code> back up to calling function and press on.</p>


<p>Let's assume that we get a true back in the controller. So, the user has provided AD a good user name and password. We might have some information that we want to cache locally in the application for performance reasons. For example, I cache the users email address, first name and last name. I made a design choice to keep my applications interaction with AD as little as possible, so I do not pull that information from it.</p>


<p>If the controller can find a user record with the same user name as the user name which was provided, we press on. If not, we pop the user over to their 'My Account' page and force them to fill out a form which captures the data that we need.</p>


<p>We then save that data to the local database. Auto populating the database with information from AD is left to the gentle reader.</p>