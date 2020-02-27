---
id: 15379
title: Quick and dirty storage
date: 2011-03-04T13:14:41+00:00
author: tsykoduk
layout: post
guid: https://greg.nokes.name/2011/03/04/quick-and-dirty-storage/
permalink: /2011/03/04/quick-and-dirty-storage/
categories:
  - Computers! and Code!
tags:
  - Hardware
  - Storage
excerpt_separator:  <!--more-->
---
With the advent of low cost, high capacity storage solutions, and really easy SAN tools baked into most linux distros, a DIY SAN solution is a lot easier then it might seem.

<!--more-->
Lets start with the hardware. Depending on your needs, a <a title="Petabytes on a budget: How to build cheap cloud storage | Backblaze Blog" href="http://blog.backblaze.com/2009/09/01/petabytes-on-a-budget-how-to-build-cheap-cloud-storage/">BackBlaze Storage Pod</a> might be right up your alley, or a <a href="http://pogolinux.com/bomquotes/webbom?system=218">SuperMicro 24 disk 2U SAS</a> chassis with 15k RPM SAS drives might power your virtual database.


The Backblaze is an awesome solution - for massive, low cost storage. Since you are not using RAID cards, you'll want to use <a title="mdadm - Wikipedia, the free encyclopedia" href="http://en.wikipedia.org/wiki/Mdadm">mdadm</a> to arrange the drives into a big RAID10 array. You loose 50% of your space to redundancy - however you gain short rebuild times, and the ability to survive multiple drive failures. You also get quite a nice speed boost, if that's at all important to you. I'd suggest 2 GigE network interfaces, bonded together. You're not concerned about massive speed, however the ability to get good transfer rates no matter what else is happening is nice.


f you are using one of the 24 disk 2U chassis, you'll have hardware RAID - and I'd use that. Again, RAID10 for speed, or a bunch of RAID5's for smaller filesystems. You can even build out a RAID50 using a few RAID5's and LVM on top of them. For a machine like this, I'd use the two built in GigE ports for the management interfaces, and then add a 4 port card for the SAN traffic.


On top of the mdadm RAID array, you can put <a title="Logical Volume Manager (Linux) - Wikipedia, the free encyclopedia" href="http://en.wikipedia.org/wiki/Logical_Volume_Manager_(Linux)">LVM</a>, if you wish. You gain the ability to snapshot and move filesystems. I've personally set it up with and with out LVM. It totally depends on the use case and your comfort level with LVM.


The next item in the stack is the filesystem. On linux I like to use <a href="http://xfs.org/">XFS</a>, as it deals with large files well and is stable and mature. On BSD <a title="ZFS - Wikipedia, the free encyclopedia" href="http://en.wikipedia.org/wiki/ZFS">ZFS</a> is the flavor du jour, and is well supported.


Beyond that, there are several choices you will need to make. Are you going to expose the filesystem using NFS (targeting macs, VMWare or Linux), Samba and CIFS (Targeting Windows machines) or iSCSI (building out a real SAN solution)?


Any choices you make on how to deliver the data you'll want to take a look at the network layout closely. Separate switches for the SAN are preferred, however a VLAN works as well. You'll want to enable jumbo frames, and give the SAN interfaces separate, non-routable address space. One of the tactics that I have seen is to give the SAN device a single network interface on the data network, so that it is remotely manageable, and dedicate the rest to the SAN network.


With the advent of built in iSCSI initiators in Windows Server 2008, and the fantastic iSCSI IET project, the barriers to entry with iSCSI have come down a lot. It's simple to spin up an iSCSI target on a linux box, and then mount it on windows, VMWare, or linux machines.


Here is how I proceeded:


First I obtained my storage device. I installed Debian 6, and the following packages


<code>apt-get install iscsitarget iscsitarget-dkms lvm2 xfsdump xfsprogs</code>


I arranged the disks into a RAID10 using mdadm. Then I layered LVM and then XFS on top of it.

To host the acutal iSCSI device, I created a sparse file using the linux dd command. This basically works as a quota, with an option for easy growth. The exact command that I used to create the sparse file is


<code>dd if=/dev/zero of=/path/to/file/name bs=1 count=1 seek=size</code>


For a iSCSI share aimed at a linux host, you will want to then put a filesystem on the sparse file. (confusing, eh?). I used the command


<code>mkfs.xfs /path/to/file/name</code>


If you were going to be mounting the device on a windows machine, I'd use the windows tools to format it using NTFS. Just mount the iSCSI device on the windows machine, and use the tools there to prepare and format it.


Sizing the file can be a daunting proposition. However, don't worry. It's really easy to grow the device when you need to. Just use the same dd command, with a larger size switch. You'll want to back up the file first, and test how the filesystem handles growth before you try this on real, live data.


Now you have to set the device up as an iSCSI target. Using IET is actually really simple. The conf file pretty much explains itself. On Ubuntu the file is at /etc/ietd.conf - and on debian 6 it's at /etc/iet/ietd.conf. Not really concerned about security (this being a test enviroment) I only added 1 line to the ietf.cong file:


<code>Target iqn.2005-00.nokes.name:storage.vol1.pool.lvm</code>


And presto, instant iscsi target goodness.


As an aside, you can also mount the device locally, if you have filesystem support for it. For example,

<code>mount -t xfs -o loop /pool/iscsitarget /mnt/</code>


would mount my xfs formatted sparse file onto the /mnt directory.


In retrospect, a home built SAN solution is a lot less expensive, and a lot easier then you'd think.