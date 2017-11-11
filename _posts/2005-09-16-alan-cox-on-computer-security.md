---
id: 882
title: Alan Cox on Computer Security
date: 2005-09-16T18:05:32+00:00
author: tsykoduk
layout: post
guid: 30/2008/12/27/alan-cox-on-computer-security
permalink: /2005/09/16/alan-cox-on-computer-security/
categories:
  - Computers! and Code!
---
O'Reilly (Ho, <a href="http://www.ci.sebastopol.ca.us/">Sebastopol!)</a> has a really good interview with Alan Cox about where computer security is going.


<blockquote>It is beginning to improve, but at the moment computer security is rather basic and mostly reactive. Systems fail absolutely rather than degrade. We are still in a world where an attack like the slammer worm combined with a <span class="caps">PC BIOS</span> eraser or disk locking tool could wipe out half the PCs exposed to the internet in a few hours. In a sense we are fortunate that most attackers want to control and use systems they attack rather than destroy them.</blockquote>

-<a href="http://www.oreillynet.com/pub/a/network/2005/09/12/alan-cox.html?page=1">Alan Cox</a>


If you are at all interested in computer security, I recommend that you go and read this.


Here is my take:


A lot of what he says is accurate. By increasing the sophistication of the programmers toolkit, and making it more 'bug aware', I think that the average quality of code will increase. More quality code will mean less holes.


However, it's more then just well written code. There are several other layers to this. First off, how much interaction between parts of the computer do we allow? Do we allow your web browser to read your address book? Do we allow the web browser to create files on your local machine? This interaction can be dangerous, and exploited. As we build more complex bounds checking on the actions that any one application can take, we increase the complexity of the code, and make the programmers life harder.


I think that the new tools that Alan talked about will end up just keeping the status quo. As the code gets more and more complex, and we need communication channels between different applications on a machine,or across the network, it's going to become harder and harder to think of every method that could be used to hijack a process and use it for ill.


It's going to be an arms race. White hats vs black hats. It's been that way for a long time, and it's only going to increase. What has changed is the amount of interconnectedness in the world, and the fact that 90% of those machines are running a joke of an Operating System.


Certain large software companies have convinced us that we need to have large amounts of interaction between all of our applications, all of the time. I do not know if this is as true as some think. Interaction is good, however it needs to be regulated by the user. Users also should not be able to make certain modifications to the machine with out an administrators approval.


Under Linux and Mac <span class="caps">OS X</span>, if you are going to install certain applications (ones that effect the entire OS, and not just your user space) you are prompted for a admin password. That is the way that it should be. Windows (2k and above) will fail to install, saying that you must have admin rights. The problem is that, under windows, 99% of the users are admins on their machines. With all of the remote exploits for Windows, it really does not matter, as you no longer have to actually install bad code, you can just get it like you get a cold.


If Windows were to <a href="http://en.wikipedia.org/wiki/Sandbox_%28computer_security%29">sandbox</a> the user space in better, then most of these issues would not be issues. If you are logged in, and you visit a evil web page that tries to install evil spy ware, if windows sandboxed the userspace your machine would be o.k. There are just so many processes running in the background in windows, trying to make your life easier for you, that the evil software piggybacks off of one of them, and presto - you are infected.


In the mean time - if you are buying a new computer, get a <a href="http://www.apple.com">Mac.</a> Practice <a href="http://greg.nokes.name/safe.jpg">safe computing</a>! Be careful out there!