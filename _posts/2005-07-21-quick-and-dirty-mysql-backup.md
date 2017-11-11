---
id: 683
title: Quick and Dirty MySQL backup
date: 2005-07-21T14:51:00+00:00
author: tsykoduk
layout: post
guid: 30/2008/12/27/quick-and-dirty-mysql-backup
permalink: /2005/07/21/quick-and-dirty-mysql-backup/
categories:
  - Computers! and Code!
---
<code>cd ~/backup
	rm backup5.sql
	mv backup4.sql backup5.sql
	mv backup3.sql backup4.sql
	mv backup2.sql backup3.sql
	mv backup1.sql backup2.sql
	mv backup.sql backup1.sql
	mysqldump --all-databases &gt;backup.sql</code>

	This is a very quick and dirty backup script that should back up all of the Database's (databasi?) in a MySQL database, and maintain 5 days of storage. Next week, off site!