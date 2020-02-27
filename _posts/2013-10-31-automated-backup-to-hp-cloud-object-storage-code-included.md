---
id: 15553
title: Automated Backup to HP Cloud Object Storage, Code Included
date: 2013-10-31T10:52:01+00:00
author: tsykoduk
layout: post
guid: https://greg.nokes.name/?p=15553
permalink: /2013/10/31/automated-backup-to-hp-cloud-object-storage-code-included/
categories:
  - Computers! and Code!
tags:
  - backups
  - HowTo
  - HP Cloud
excerpt_separator:  <!--more-->
---
(cross posted from the <a href="http://www.hpcloud.com/blog/automated-backup-hp-cloud-object-storage-code-included">HPCloud Blog</a>. With 75% more typos!)
One of the most basic problems with systems that need to persist data, is making sure that you can recover those systems in the case of a critical error. I’ve used and written backup systems for more time then I’d like to admit (<a href="https://greg.nokes.name/2009/01/12/itunes-backups/">for example</a>). With the advent of cloud storage systems such as S3, moving your data offsite has become much easier, and much easier to recover data from your offsite storage system.

<!--more-->


Back when I got started in this industry, a tape backup would take hours. And then you’d have to drive it to your safety deposit box and store it. When you needed to recover data, it was a drive and then hours to restore it.
The next iteration was removable hard drives. These were quicker to back up to and restore from, however the offsite portion was still onerous. That’s why I developed <a href="https://greg.nokes.name/2008/04/18/syncscript/">SyncScript</a> - caching a local copy of the backup mades sense when most of the restore request were for things deleted in the last 24 - 48 hours.
However with the advent of Cloud Storage and higher speed internet pipes you can keep offsite backups, and get them back reasonably quickly. Since I work with OpenStack now days, that’s the hammer that makes sense to use.
Here is what I did to get a dead simple backup from a HP Cloud instance to HP’s Object Storage.
First, I installed the python tools. I followed the directions below:
For Centos 6.3:

<pre><code>yum install python-pip

pip install python-keystoneclient

pip install python-swiftclient

</code></pre>

For Ubuntu 13.04:

<pre><code>aptitude install python-pip

pip install python-keystoneclient

pip install python-swiftclient

</code></pre>

Then I edited the <code>.bashrc</code> for the user preforming the backup using <code>nano ~/.bashrc</code> to include this

<pre><code>## Enable openstack client stuff

export OS_TENANT_NAME=MY-PROJECT-NAME

export OS_USERNAME=MY-USER-NAME

export OS_PASSWORD='MY-PASSWORD'

export OS_AUTH_URL=https://region-b.geo-1.identity.hpcloudsvc.com:35357/v2.0/

export OS_REGION_NAME=region-b.geo-1

</code></pre>

This will back up to US-East. If you wanted to backup to US-West, you’d want a <code>.bashrc</code> that included this:

<pre><code>## Enable openstack client stuff

export OS_TENANT_NAME=MY-PROJECT-NAME

export OS_USERNAME=MY-USER-NAME

export OS_PASSWORD='MY-PASSWORD'

export OS_AUTH_URL=https://region-a.geo-1.identity.hpcloudsvc.com:35357/v2.0/

export OS_REGION_NAME=region-a.geo-1

</code></pre>

After I finshed updating the <code>.bashrc</code>, I went ahead and ran <code>source ./bashrc</code> to load the changes.
I was then able to access swift.
I tested that like this:

<pre><code>ubuntu@test-server:~$ swift list

Server_Backups

ubuntu@test-server:~$

</code></pre>

I had already created the <code>Server_Backups</code> container via the web interface, following <a href="https://community.hpcloud.com/article/uploading-file-your-container-using-management-console">these directions</a>.
Once I had my server set up to access Object Storage, I was able to use the following script and cron to automate a complete backup of everything that was important on my server.
<script src="https://gist.github.com/tsykoduk/eb35a67433d3a01499dd.js"></script>
(up to date source code lives on <a href="https://github.com/tsykoduk/random_tools/blob/master/swift_backup.sh">GitHub</a>)