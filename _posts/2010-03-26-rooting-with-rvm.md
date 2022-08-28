---
id: 15235
title: rooting with rvm
date: 2010-03-26T13:51:16+00:00
author: tsykoduk
layout: post
guid: https://greg.nokes.name/?p=15235
permalink: /2010/03/26/rooting-with-rvm/
categories:
  - Computers! and Code!
tags:
  - production
  - root
  - ruby
  - rvm
excerpt_separator:  <!--more-->
---
<a href="https://greg.nokes.name/binaries/2010/03/GrowlHelperApp-1.jpg"><img class="alignleft size-medium wp-image-15236" title="GrowlHelperApp-1" src="https://greg.nokes.name/binaries/2010/03/GrowlHelperApp-1-300x71.jpg" alt="" width="300" height="71" /></a>

rvm (ruby version manager) is a kick ass tool that I use on a daily basis. It allows you to install lots of ruby versions, gems, gem sets, and what have you. You can test your app against new (or old) versions of ruby easily. You can also use it to manage rubies on a production system, for all users of that system.

<!--more-->

Yes, you heard me correctly. After needling Wayne into getting root support built into RVM so many weeks ago, this is really the only way that I use it. There are a few gotchas however. I will go through my best practices for installing rvm system wide in this article.
<strong>updated: 8/1/2010 : <a href="http://twitter.com/sutto">@sutto</a> and <a href="http://twitter.com/wayneeseguin">@wayneeseguin</a> have baked </strong><strong><a href="http://rvm.beginrescueend.com/deployment/system-wide/">root support into rvm</a> - use that!</strong>

<h2>Preparation</h2>

The first step is to prep the system for rvm.
On a <strong>ArchLinux</strong> system run the following:

```bash
pacman -S --noconfirm gcc gcc-libs make kernel-headers zlib libtool bison gdb strace gettext openssl git readline
```

<strong>Centos</strong>:

```bash
yum install -y gcc gcc-c++ kernel-devel zlib libtool bison gdb strace gettext git rpm-build redhat-rpm-config zlib-devel openssl openssl-devel git readline-devel
```

<strong>Debian</strong>:

```bash
aptitude install -y build-essential libreadline5-dev libssl-dev bison libz-dev zlib1g zlib1g-dev libxml2 libxml2-dev libxslt-dev libssl-dev openssl git readline-devel
```

And on your <strong>Mac</strong>, you'll want to get the latest XCode installed.

<h2>Install rvm</h2>

I normally add <code>gem: --no-rdoc --no-ri</code> to the <code>/etc/gemrc</code> file. I really dislike getting all of the RI and RDoc stuff generated, at it normally takes more time then the gem install.
When I install the base rvm package, I tend to use the latest git head. That way, I do not need to muck about getting ruby and rubygems installed on the machine in question. As long as I have git, I am good to go.

```bash
cd ~

git clone git://github.com/wayneeseguin/rvm.git temp_rvm

cd temp_rvm
```

This is all straight forward up to this point. We've done everything "by the <a href="http://rvm.beginrescueend.com/">book</a>" as it were. From here on out, be advised that installing things as root might cause breakage or instability.

<h2>Here there be dragons</h2>

We'll start off with this:

```bash
sudo su
```

and then continue from the temp_rvm directory we just created:

```bash
./install

cd ~

rm -rf temp_rvm
```

Now, you should have a non-working rvm install located in <code>/usr/local/rvm</code>. We are almost done, just a few more little things left.
First off, create a <code>/etc/rvmrc</code> file and add this line:

```bash
export rvm_path=/usr/local/rvm
```

Next, edit your <code>/etc/profile</code> to include the following line on the bottom:

```bash
# Load RVM if it is installed,

#  first try to load  user install

#  then try to load root install, if user install is not there.

if [ -s "$HOME/.rvm/scripts/rvm" ] ; then

  . "$HOME/.rvm/scripts/rvm"

elif [ -s "/usr/local/rvm/scripts/rvm" ] ; then

  . "/usr/local/rvm/scripts/rvm"

fi
```

<h2>Cleaning up</h2>

You'll want to <code>chown</code> the <code>/usr/local/rvm</code> directory to add a group that contains the folks you want to be able to administrate your rubies, install gems and what not. I then <code>chmod -R g+w /usr/local/rvm</code> to allow the group access. I have had mixed luck with this - best case scenario is to grant ownership to the 1 user who is going to be tasked with loading rubies and tell them to get at it.

I also use the <code>rvm use  ruby_version --default</code> option when I select a ruby for use system wide. It works really well.

<h2>Closing thoughts, and a present for all that read this far...</h2>

rvm is an excellent tool. I have run it on several production systems as root, and only run it that way any more. It sits next to homebrew on my Mac, and makes testing stuff super simple.

Here is the setup [script that I use which automates everything above](http://gist.github.com/418634.js?file=rvm_systemizer_setup)