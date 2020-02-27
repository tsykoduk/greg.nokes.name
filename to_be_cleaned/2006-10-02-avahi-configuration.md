---
id: 1492
title: Avahi Configuration
date: 2006-10-02T06:38:00+00:00
author: tsykoduk
layout: post
guid: 30/2008/12/27/avahi-configuration
permalink: /2006/10/02/avahi-configuration/
categories:
  - Computers! and Code!
---
So - a while back I talked about getting <a href="https://wiki.ubuntu.com/EdgyEft">Edgy Eft</a> installed and spun up on my home Server. One of the issues that I had was getting my <a href="http://www.apple.com">Macs</a> to play nice with this new version. I used to use <a href="http://www.porchdogsoft.com/products/howl/GettingStarted.html">Howl</a> to provide my <a href="http://www.multicastdns.org/">mDNS</a> goodness. Well, Howl is no longer supported - or even developed. So, it was time to get with the, errr, times.
<a href="http://avahi.org/">Avahi</a> is the new kid on the block. I was hoping that it would automagically pick up all of the services that I had running on my box, and publish information about them. Well, that was not the case. I have heard rumors that <a href="http://netatalk.sourceforge.net/">netatalk</a> (the Linux implementation of <a href="http://en.wikipedia.org/wiki/Apple_Filing_Protocol"><span class="caps">AFP</span></a> - Apple's file sharing protocol. <span class="caps">OSX</span> also supports <a href="http://en.wikipedia.org/wiki/Server_Message_Block"><span class="caps">SMB</span></a>, <a href="http://en.wikipedia.org/wiki/Network_File_System"><span class="caps">NFS</span></a> and others, but <span class="caps">AFP</span> is native, fast, and easy.) would automagically register with Avahi, but that did not work.
So, I have been putting off getting it configured, and relying on <span class="caps">SCP</span>/SFTP to access my server shares. As <span class="caps">OS X</span> does not support writing to <span class="caps">FTP</span>/SFTP out of the box, I have had to use a third part tool (<a href="http://rsug.itd.umich.edu/software/fugu/">Fugu</a> - I cannot recommend this program highly enough) to accomplish this. Last night, I had some time, and hacked on Avahi until it worked.
The Edgy install of Avahi pretty much worked out of the box. However, it did not configure any services. I had to dig through several man pages to get the following <a href="https://greg.nokes.name/assets/2006/10/5/afpd.service">format</a> figured out:
<script src="http://gist.github.com/644287.js?file=Avhai_Service.xml"></script>
This goes into /etc/avahi/services - or where ever you have your Avahi services directory. It's pretty easy once you get the format down. I made services for <a href="https://greg.nokes.name/assets/2006/10/5/sshd.service">ssh</a> and <a href="https://greg.nokes.name/assets/2006/10/5/httpd.service">http</a> as well.
<em>Update: Just did basic setups for <a href="https://greg.nokes.name/assets/2006/10/6/svn.service">svn</a>, <a href="https://greg.nokes.name/assets/2006/10/6/rsync.service">rsync</a>, <a href="https://greg.nokes.name/assets/2006/10/6/ntp.service">ntp</a> and <a href="https://greg.nokes.name/assets/2006/10/6/ipp.service">ipp</a></em>
I would like to see the Avahi folks include a directory called 'services-disabled' or some such thing, and have the common service definition files in there already. All you would have to do is symlink the files over to the services directory when you needed them enabled - you could have the daemon startup scripts automagically look for and do this when they start.
Then, you would have Linux with the plug and play simplicity of a Mac.