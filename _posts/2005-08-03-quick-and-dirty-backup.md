---
id: 190
title: Quick and dirty backup
date: 2005-08-03T14:24:14+00:00
author: tsykoduk
layout: post
guid: https://greg.nokes.name/?p=190
permalink: /2005/08/03/quick-and-dirty-backup/
categories:
  - Computers! and Code!
---
I have been working on a quick and dirty backup script to backup a MySQL database and several directories. Here is the fruit of my labor

	# change dir to backup dir
	
	cd /backup
	
	# Build next days worth of file backups
	rm -rf /backup/backup.4
	mv /backup/backup.3 /backup/backup.4
	mv /backup/backup.2 /backup/backup.3
	mv /backup/backup.1 /backup/backup.2
	cp -al /backup/backup.0 /backup/backup.1
	rsync -a-delete /srv/ /backup/backup.0/
	
	# Backup etc
	tar -cvf etc.tar /etc
	rm /backup/etc.tar.gz
	gzip etc.tar
	
	backup MySQL databases
	rm /backup/backup4.sql
	mv /backup/backup3.sql /backup/backup4.sql
	mv /backup/backup2.sql /backup/backup3.sql
	mv /backup/backup1.sql /backup/backup2.sql
	mv /backup/backup.sql  /backup/backup1.sql
	mysqldump-all-databases &gt;/backup/backup.sql
	
	# Make 1 compressed tarball of entire shebang
	rm /backup/backup.tar.gz
	tar -cvf /backup.tar /backup/*
	mv /backup.tar /backup
	gzip /backup/backup.tar

All of this assumes that you have a directory called 'backup' off the root of the file system that you can use for moving stuff about. It will provide you with 5 complete days of full file backups (in the space of 1, plus changes), 5 full days of MySQL backups and a daily snapshot of the /etc/ directory for what ever reason.