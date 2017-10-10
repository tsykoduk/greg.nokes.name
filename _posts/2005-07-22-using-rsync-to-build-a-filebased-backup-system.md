---
id: 684
title: Using Rsync to build a filebased backup system
date: 2005-07-22T08:26:41+00:00
author: tsykoduk
layout: post
guid: 30/2008/12/27/using-rsync-to-build-a-filebased-backup-system
permalink: /2005/07/22/using-rsync-to-build-a-filebased-backup-system/
categories:
  - Computers! and Code!
---
<code>rm -rf backup.3
	mv backup.2 backup.3
	mv backup.1 backup.2
	cp -al backup.0 backup.1
	rsync -a --delete source_directory/  backup.0/</code>

		<p>(Hat tip to <a href="http://www.mikerubel.org/computers/rsync_snapshots/">Mike Rubel</a> for the code!)</p>