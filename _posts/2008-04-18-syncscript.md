---
id: 560
title: SyncScript
date: 2008-04-18T03:56:00+00:00
author: tsykoduk
layout: post
guid: https://greg.nokes.name/?p=560
permalink: /2008/04/18/syncscript/
categories:
  - Computers! and Code!
---
One of the challenges where I work is keeping a near line copy of large amounts of data. Tape is to slow to restore off of, and can be a hassle since we have off site tape storage requirements. Thus SyncScript was born. It's a windows only, quick and dirty little ruby app to move about large amounts of data using a rather brute force method...
<!--more-->

Did I mention that it's windows only?

You will need to have either Ruby installed or use the spiffy <a href="http://www.erikveen.dds.nl/allinoneruby/index.html">AllInOneRuby</a> script to build yourself a ruby.exe.

Well, let's go ahead and jump right in and look at the config.rb

```ruby
#SyncScript Config
#
# Standard ruby lang here
# so you can do things like
# if date == Friday then ....

#List backup sources here as UNC paths,
#ie \\\\myserver\\myshare

@job_name = "Daily Backup"

@sources = [
 "\\\\someserver\\someshare",
 "\\\\someotherserver\\someothershare" #,

]
```

You will want to give the job some pithy name, and a few sources.

```ruby
# Where do we want to store the backup?
#Do not use a trailing slash - bad things will happen

if Time.now.day.to_i % 2 != 0
 @target = "c:\\backups\\day"
else
 @target = "e:\\backups\\day"
end
```

Here we are showing off some of the strength of the config file. Since it's simply a ruby file, we can use whatever ruby idioms we want - in this case, we have 2 hard drives in the target machine (c: and e:) and we want to split the backups between them for redundancy's sake. We could have simply mirrored them, but this way we get the full capacity and we still get some backup... the most we will loose is 1 day if a hard drive fails. Since this is a near line enhancement to an existing tape based system, that risk was deemed acceptable.

```ruby
#Valid types: Date, Incremental, Diff, Full, Copy

@type = 'Full'

#Rotation Scheme
# Pass how many _old_ jobs you want to keep
# If you want to keep the most recient and 4 older backups
# pass 4. That will keep a total of 5 backups (your current and 4 old)
@rotate = 2
```

Pretty basic stuff here. The job types work - however full is the only one tested in a production environment - YMMV. The rotate # is the number of old backups you want to keep.

```ruby
#if you want to pre-run a batch file or command line command, put it here

@prerun = nil
```

Yes, we can do pre-runs to clean up, or set stuff up for the backup (mapping a target drive, shutting down the AV system...)

```ruby
#Do you want crc32 validations done on all of the files after the run
#At this time, this is unimpletmented. the copy routine does a validation as it runs.

@validate = false
```

The crc32 is from when I was coding this as a linux app. However, that was shunted - and we use xcopy's validate function now.

```ruby
@maillist = [
 'youremailaddress@domain.com',
 'anotheremailaddress@domain.com'
]
```

Where do you want the reports sent to.

It's fully <a href="http://en.wikipedia.org/wiki/Copyleft">copyleft</a> - please just drop me a comment if you choose to use it or a child.

<strong>update:</strong> Just moved the code to <a href="https://github.com/tsykoduk/sync_script">github</a>