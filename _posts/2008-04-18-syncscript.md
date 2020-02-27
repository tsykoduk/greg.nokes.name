---
id: 7160
title: SyncScript
date: 2008-04-18T03:56:00+00:00
author: tsykoduk
layout: post
guid: http://30/2008/12/27/syncscript
permalink: /2008/04/18/syncscript/
categories:
  - Computers! and Code!
---
One of the challenges where I work is keeping a near line copy of large amounts of data. Tape is to slow to restore off of, and can be a hassle since we have off site tape storage requirements. Thus SyncScript was born. It's a windows only, quick and dirty little ruby app to move about large amounts of data using a rather brute force method...
<!--more-->

Did I mention that it's windows only?

You will need to have either Ruby installed or use the spiffy <a href="http://www.erikveen.dds.nl/allinoneruby/index.html">AllInOneRuby</a> script to build yourself a ruby.exe.

Well, let's go ahead and jump right in and look at the config.rb

<table class="CodeRay">

<tbody>

<tr>

<td class="line_numbers" title="click to toggle" onclick="with (this.firstChild.style) { display = (display == '') ? 'none' : '' }">

<pre>1<tt>

</tt>2<tt>

</tt>3<tt>

</tt>4<tt>

</tt><strong>5</strong><tt>

</tt>6<tt>

</tt>7<tt>

</tt>8<tt>

</tt>9<tt>

</tt><strong>10</strong><tt>

</tt>11<tt>

</tt>12<tt>

</tt>13<tt>

</tt>14<tt>

</tt><strong>15</strong><tt>

</tt>16<tt>

</tt></pre>

</td>

<td class="code">

<pre><span class="c">#SyncScript Config</span><tt>

</tt><span class="c">#</span><tt>

</tt><span class="c"># Standard ruby lang here</span><tt>

</tt><span class="c"># so you can do things like</span><tt>

</tt><span class="c"># if date == Friday then ....</span><tt>

</tt><tt>

</tt><span class="c">#List backup sources here as UNC paths,</span><tt>

</tt><span class="c">#ie \\\\myserver\\myshare</span><tt>

</tt><tt>

</tt><span class="iv">@job_name</span> = <span class="s"><span class="dl">"</span><span class="k">Daily Backup</span><span class="dl">"</span></span><tt>

</tt><tt>

</tt><span class="iv">@sources</span> = [<tt>

</tt>  <span class="s"><span class="dl">"</span><span class="ch">\\</span><span class="ch">\\</span><span class="k">someserver</span><span class="ch">\\</span><span class="k">someshare</span><span class="dl">"</span></span>,<tt>

</tt>  <span class="s"><span class="dl">"</span><span class="ch">\\</span><span class="ch">\\</span><span class="k">someotherserver</span><span class="ch">\\</span><span class="k">someothershare</span><span class="dl">"</span></span> <span class="c">#,</span><tt>

</tt><tt>

</tt>]<tt>

</tt></pre>

</td>

</tr>

</tbody>

</table>

You will want to give the job some pithy name, and a few sources.

<table class="CodeRay">

<tbody>

<tr>

<td class="line_numbers" title="click to toggle" onclick="with (this.firstChild.style) { display = (display == '') ? 'none' : '' }">

<pre>1<tt>

</tt>2<tt>

</tt>3<tt>

</tt>4<tt>

</tt><strong>5</strong><tt>

</tt>6<tt>

</tt>7<tt>

</tt>8<tt>

</tt>9<tt>

</tt><strong>10</strong><tt>

</tt>11<tt>

</tt></pre>

</td>

<td class="code">

<pre><tt>

</tt><span class="c"># Where do we want to store the backup?</span><tt>

</tt><span class="c">#Do not use a trailing slash - bad things will happen</span><tt>

</tt><tt>

</tt><tt>

</tt><tt>

</tt><span class="r">if</span> <span class="co">Time</span>.now.day.to_i % <span class="i">2</span> != <span class="i">0</span><tt>

</tt>  <span class="iv">@target</span> = <span class="s"><span class="dl">"</span><span class="k">c:</span><span class="ch">\\</span><span class="k">backups</span><span class="ch">\\</span><span class="k">day</span><span class="dl">"</span></span><tt>

</tt><span class="r">else</span><tt>

</tt>  <span class="iv">@target</span> =  <span class="s"><span class="dl">"</span><span class="k">e:</span><span class="ch">\\</span><span class="k">backups</span><span class="ch">\\</span><span class="k">day</span><span class="dl">"</span></span><tt>

</tt><span class="r">end</span><tt>

</tt></pre>

</td>

</tr>

</tbody>

</table>

Here we are showing off some of the strength of the config file. Since it's simply a ruby file, we can use whatever ruby idioms we want - in this case, we have 2 hard drives in the target machine (c: and e:) and we want to split the backups between them for redundancy's sake. We could have simply mirrored them, but this way we get the full capacity and we still get some backup... the most we will loose is 1 day if a hard drive fails. Since this is a near line enhancement to an existing tape based system, that risk was deemed acceptable.

<table class="CodeRay">

<tbody>

<tr>

<td class="line_numbers" title="click to toggle" onclick="with (this.firstChild.style) { display = (display == '') ? 'none' : '' }">

<pre>1<tt>

</tt>2<tt>

</tt>3<tt>

</tt>4<tt>

</tt><strong>5</strong><tt>

</tt>6<tt>

</tt>7<tt>

</tt>8<tt>

</tt>9<tt>

</tt><strong>10</strong><tt>

</tt>11<tt>

</tt></pre>

</td>

<td class="code">

<pre><tt>

</tt><tt>

</tt><span class="c">#Valid types: Date, Incremental, Diff, Full, Copy</span><tt>

</tt><tt>

</tt><span class="iv">@type</span> = <span class="s"><span class="dl">'</span><span class="k">Full</span><span class="dl">'</span></span><tt>

</tt><tt>

</tt><span class="c">#Rotation Scheme</span><tt>

</tt><span class="c"># Pass how many _old_ jobs you want to keep</span><tt>

</tt><span class="c"># If you want to keep the most recient and 4 older backups</span><tt>

</tt><span class="c"># pass 4. That will keep a total of 5 backups (your current and 4 old)</span><tt>

</tt><span class="iv">@rotate</span> = <span class="i">2</span><tt>

</tt></pre>

</td>

</tr>

</tbody>

</table>

Pretty basic stuff here. The job types work - however full is the only one tested in a production environment - <span class="caps">YMMV</span>. The rotate # is the number of old backups you want to keep.

<table class="CodeRay">

<tbody>

<tr>

<td class="line_numbers" title="click to toggle" onclick="with (this.firstChild.style) { display = (display == '') ? 'none' : '' }">

<pre>1<tt>

</tt>2<tt>

</tt>3<tt>

</tt>4<tt>

</tt></pre>

</td>

<td class="code">

<pre>  <tt>

</tt><span class="c">#if you want to pre-run a batch file or command line command, put it here</span><tt>

</tt><tt>

</tt><span class="iv">@prerun</span> = <span class="pc">nil</span><tt>

</tt></pre>

</td>

</tr>

</tbody>

</table>

Yes, we can do pre-runs to clean up, or set stuff up for the backup (mapping a target drive, shutting down the AV system...)

<table class="CodeRay">

<tbody>

<tr>

<td class="line_numbers" title="click to toggle" onclick="with (this.firstChild.style) { display = (display == '') ? 'none' : '' }">

<pre>1<tt>

</tt>2<tt>

</tt>3<tt>

</tt>4<tt>

</tt><strong>5</strong><tt>

</tt>6<tt>

</tt></pre>

</td>

<td class="code">

<pre><tt>

</tt><tt>

</tt><span class="c">#Do you want crc32 validations done on all of the files after the run</span><tt>

</tt><span class="c">#At this time, this is unimpletmented. the copy routine does a validation as it runs.</span><tt>

</tt><tt>

</tt><span class="iv">@validate</span> = <span class="pc">false</span><tt>

</tt></pre>

</td>

</tr>

</tbody>

</table>

The crc32 is from when I was coding this as a linux app. However, that was shunted - and we use xcopy's validate function now.

<table class="CodeRay">

<tbody>

<tr>

<td class="line_numbers" title="click to toggle" onclick="with (this.firstChild.style) { display = (display == '') ? 'none' : '' }">

<pre>1<tt>

</tt>2<tt>

</tt>3<tt>

</tt>4<tt>

</tt><strong>5</strong><tt>

</tt>6<tt>

</tt></pre>

</td>

<td class="code">

<pre><tt>

</tt><tt>

</tt><span class="iv">@maillist</span> = [<tt>

</tt>  <span class="s"><span class="dl">'</span><span class="k">youremailaddress@domain.com</span><span class="dl">'</span></span>,<tt>

</tt>  <span class="s"><span class="dl">'</span><span class="k">anotheremailaddress@domain.com</span><span class="dl">'</span></span><tt>

</tt>]</pre>

</td>

</tr>

</tbody>

</table>

Where do you want the reports sent to.
You can go ahead and <a href="https://greg.nokes.name/assets/2008/4/18/SyncScript.zip">download</a> the full app if you wish. It's fully <a href="http://en.wikipedia.org/wiki/Copyleft">copyleft</a> - please just drop me a comment if you choose to use it or a child.
<strong>update:</strong> Just moved the code to <a href="https://github.com/tsykoduk/sync_script">github</a>