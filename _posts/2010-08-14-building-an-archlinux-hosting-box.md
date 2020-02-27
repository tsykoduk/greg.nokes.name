---
id: 15325
title: Building an ArchLinux hosting box (part 1)
date: 2010-08-14T20:31:23+00:00
author: tsykoduk
layout: post
guid: https://greg.nokes.name/?p=15325
permalink: /2010/08/14/building-an-archlinux-hosting-box/
categories:
  - Computers! and Code!
excerpt_separator:  <!--more-->
---
<a href="https://greg.nokes.name/wp-content/uploads/2010/08/Other-Linux-2.6.x-kernel-64-bit.png"><img class="alignleft size-medium wp-image-15337" style="border: 5px solid black;" title="Other Linux 2.6.x kernel 64-bit" src="https://greg.nokes.name/wp-content/uploads/2010/08/Other-Linux-2.6.x-kernel-64-bit-300x224.png" alt="" width="300" height="224" /></a>

One of my favorite linux distros has been <a href="http://www.archlinux.org/">archlinux</a> since the early oughts. It's default install is super lightweight, and it's configuration system is a joy (especially after working with several distros with many rc directories and hundreds of symlinks).

<!--more-->

However, there is a learning curve with archlinux. Since it's so stripped down, some things that you might expect to see are not installed or configured. And following it's minimalist mantra, packages tend to not configure themselves when you install them. Following is blow by blow to help get a box booted up and running.

First off, you need to get the installer. archlinux used to come in one flavor (i686), which back when everyone else was running i386 was really really nice. Now days, they offer i686 (for older boxes) or x86-64 (for 64 bit boxes) Head on <a href="http://www.archlinux.org/download/">over</a> and grab a netinstall. Be nice and leave your torrent running for a while. You also can grab a core cd. It's quicker, but you might have a big update to do right after the first boot.

Pop the CD in, start the VM with the image or what have you.

You are then presented with a nice grub screen. Choose the default, and proceed.

<img class="alignnone size-full wp-image-15327" title="Other Linux 2.6.x kernel 64-bit-2" src="https://greg.nokes.name/wp-content/uploads/2010/08/Other-Linux-2.6.x-kernel-64-bit-2.png" alt="" width="717" height="221" />

Login as root and fire up /arch/setup. You'll want to read the intro screen, but the main takeaway is that alt-f7 will show your stdout, should you need it.

Choose option 1 <em>select source</em> and then choose http/ftp. It will ask you to configure your network. Normally, you can just accept all of the defaults. If your NIC is not recognized, you'll need to get the driver for it, and install it by hand. That has not happened to me in years however.

Once you get to the <em>Network is configured</em> screen you are ready to proceed onwards.

<a href="https://greg.nokes.name/wp-content/uploads/2010/08/Other-Linux-2.6.x-kernel-64-bit-3.png"><img class="alignnone size-full wp-image-15328" title="Other Linux 2.6.x kernel 64-bit-3" src="https://greg.nokes.name/wp-content/uploads/2010/08/Other-Linux-2.6.x-kernel-64-bit-3.png" alt="woot!" width="183" height="98" /></a>

You'll want to choose a mirror to download from. Try and make a sane choice. The archlinux.org one is throttled, so it will be rather slow. I personally like kernel.org, but your milage may vary


You'll be prompted to set you clock next. I suggest choosing your timezone, and then setting your system clock to UTC. I normally tell it to just use NTP, and go with it after that.

<a href="https://greg.nokes.name/wp-content/uploads/2010/08/Other-Linux-2.6.x-kernel-64-bit-4.png"><img class="alignnone size-full wp-image-15329" title="Other Linux 2.6.x kernel 64-bit-4" src="https://greg.nokes.name/wp-content/uploads/2010/08/Other-Linux-2.6.x-kernel-64-bit-4.png" alt="" width="703" height="240" /></a>

Next up, the always scary hard drive partitioning. You are using a system with drives that have nothing on them, right?

Unless you have special needs, letting it have at it gives a good, solid default setup. If you need LVM, or some weird scheme, by all means, have at it.

It will want to create a <code>/boot</code>, <code>swap</code>, <code>/</code> and <code>/home</code> partition. It asks you how big you want each one, with home being the last. remember to leave some space for your home directory! It will ask you what format you want to use (ext3 for safety, ext4 for cutting edge, xfs for 200% more fun), so tell it, and proceed onwards. Once you see the magic OK button, we are good to go!

Choose return to main menu, and <em>select packages</em> will be highlighted for you. So that's what you should do next. You'll want to choose the defaults here, as the "base" package list is just that. Click on through to install, and let it go.

Take a moment to revel in the up to date packages flying past. Also take a moment to grab a frosty cold beverage of your choice. It's going to be awhile.

Next up, configuring the system, and installing the bootloader. You might want to change the root password.

All of the above is pretty straightforward, if you ever have installed linux before.

After the system reboots, you'll be presented with a baseline system. Not much is running, and not much is installed. We need to do some work to get the system into a useable state.

<a href="https://greg.nokes.name/wp-content/uploads/2010/08/Other-Linux-2.6.x-kernel-64-bit-8.png"><img class="alignnone size-full wp-image-15333" title="Other Linux 2.6.x kernel 64-bit-8" src="https://greg.nokes.name/wp-content/uploads/2010/08/Other-Linux-2.6.x-kernel-64-bit-8.png" alt="" width="719" height="75" /></a>

<strong>First Update:</strong>

<blockquote>Note: As a rolling-release distribution, updating your Arch Linux system is not always as straightforward as with other fixed-release distributions. Furthermore, pacman is not a "fire-and-forget" package manager. As a result, properly maintaining an Arch Linux system with pacman tends to confuse new users (as recurring forum discussions would indicate). <strong>Please read the following section thoroughly before continuing.</strong></blockquote>

from <a href="http://wiki.archlinux.org/index.php/Pacman#Upgrading_packages">Upgrading packages</a>

You'll want to run a quick update. <a href="http://wiki.archlinux.org/index.php/Pacman">pacman</a> is Arch's package manager. The basic upgrade command is <code>pacman -Syu</code>. You'll want to run this to preload the package files anyways.

<strong>SSHD</strong>

One of the first things that I like to install is SSH. The Archwiki has a great section on <a href="http://wiki.archlinux.org/index.php/SSH">installing ssh/sshd</a>. Basically, you will want to install the package (<code>pacman -S openssh</code>), edit the <code>/etc/ssh/sshd_conf</code>, <code>/etc/hosts.allow</code> and <code>/etc/rc.conf</code> and then start sshd using <code>/etc/rc.d/sshd start</code>.

You should then be able to ssh into to the box.

<strong>sudo</strong>

<code>pacman -S sudo</code> will get that setup. You'll want to add what ever users need sudo access to the <code>/etc/sudoers</code> file.

<strong>Webserver</strong>

There are a few choices here. In my mind, the better choice is <a href="http://www.archlinux.org/packages/community/i686/nginx/">Nginx</a>, and the "safer" choice is <a href="http://www.archlinux.org/packages/extra/i686/apache/">Apache2</a>. But, if your tastes run to the exotic, you can choose from cherokee, yaws, or several others. Mongrel2 is not packaged for Archlinux as of yet, but when it becomes stable, I'm sure it will be included.

<strong>Why Nginx?</strong>

Nginx is a light weight, fast, simple web server. It's config files are fairly straightforward, and did I mention it's fast? It's best used as a front end, serving static files and balancing between several back end application servers (unicorn or passenger for Ruby, php-fpm for php, and what ever python uses these days for python.)

<strong>Ruby</strong>

<code>pacman -S --noconfirm gcc gcc-libs make kernel-headers zlib libtool bison gdb strace gettext openssl git readline</code> to install the prerequisites for rvm and building rubies, and <code>bash &lt;&lt;( curl -L http://bit.ly/rvm-install-system-wide )</code> for rvm system wide. You can also do <code>bash < <( curl http://rvm.beginrescueend.com/releases/rvm-install-head )</code> for a per user install. You'll need to add <code>source /usr/local/lib/rvm</code> to your <code>/etc/bash.bashrc</code> file, and either open a new terminal window or run the source command to initialize rvm. I advise that you read up on <a href="http://rvm.beginrescueend.com/">rvm</a>. It's a killer tool, and if your not using it, your doing it wrong.

I then install the ruby and gems that I need (<code>rvm install version</code> and then <code> gem install blarg</code>, where blarg is a list of real gems.)

<strong>PostgreSQL</strong> (or, if you insist, MySQL)

Arch's wiki has a really good <a href="http://wiki.archlinux.org/index.php/PostgreSQL">article</a> on PostgreSQL. It also has a great article on <a href="http://wiki.archlinux.org/index.php/MySQL">MySQL</a>. Head on over after you choose your poison.

<strong>Finishing Touches</strong>

You have a solid box for hosting setup. You'll want to harden the machine, but that's another article...