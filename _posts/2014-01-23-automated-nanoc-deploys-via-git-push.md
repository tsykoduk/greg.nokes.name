---
id: 1140
title: Automated Nanoc deploys via git push
date: 2014-01-23T17:30:44+00:00
author: tsykoduk
layout: post
guid: https://greg.nokes.name/?p=1140
permalink: /2014/01/23/automated-nanoc-deploys-via-git-push/
categories:
  - Computers! and Code!
excerpt_separator:  <!--more-->
---
I'm playing around with <a href="http://nanoc.ws">Nanoc</a> - a static site generator.  Basically,  <a href="http://nanoc.ws">nanoc</a> allows you you write your blog posts offline, and then generates your entire site in raw HTML. This allows you to host a site with out needing a database. In other words, it's dead quick. You can also forgo a web server, and just host your site from S3 if you want.

<!--more-->

That's pretty cool, but it seems to be a little more work then I really want. Since know my way around git and other command line tools, I decided that I could do better.
That and I wanted a more efficient way to share pictures of <a href="http://creations.nokes.name/cat-ears.gif">cats</a>.

Enter <a href="https://github.com/tsykoduk/random_tools/blob/master/picture_lister.sh">giflister.sh</a>. This little shell script is designed to be run as a <a href="http://git-scm.com/book/ch7-3.html#Server-Side-Hooks">git post recive hook</a>, and will automate deploying your nanoc site. Oh yeah, and it will also search your site for gifs, pngs, and jpegs, and give you a nice html file listing of links to them. This allows me to easily go to one spot, grab the picture that I want, and paste it into the tweet or chat program of my choice.
Since it's dead simple to get the pictures to my web server, I can add new ones as I find them.
Installing it is not for the faint of heart, but here are the steps that I took:

* Installed nanoc, got a basic site up and running
* SSH'd to my hosting server, set up a bare git repo (`git init --bare`)
* Back on my local machine, set up the git remote, and pushed to my hosting site
* SSH'd back to my hosting server, and copied the `post-receive.sample` to `post-receive`
* Copied <a href="https://github.com/tsykoduk/random_tools/blob/master/picture_lister.sh">giflister</a> into the new hook
* Git cloned the bare repo into a real repo (at `~/nanoc`)
* Made sure the paths etc in the post-receive hook were accurate
* Ran it once to see that it worked
* Tried a git push from my local workstation to insure that it worked as a hook
* Profit!

Not a trivial install process, and not something that anyone who is not familiar with git and bash should try, however the results are impressive as you can see:

```
~/Code/Nanoc ☯  git commit -m "add more bros"

[master d4c8ca2] add more bros

 1 file changed, 0 insertions(+), 0 deletions(-)

 create mode 100644 content/come-at-me-bro-2.jpg

~/Code/Nanoc ☯  git push origin master

Counting objects: 6, done.

Delta compression using up to 4 threads.

Compressing objects: 100% (4/4), done.

Writing objects: 100% (4/4), 330.91 KiB | 0 bytes/s, done.

Total 4 (delta 2), reused 0 (delta 0)

remote: Starting to push to production

remote: Get updates

remote: From /home/mysite/git/creations.nokes.name

remote:    63d06bc..d4c8ca2  master     -> origin/master

remote: Updating 63d06bc..d4c8ca2

remote: Fast-forward

remote:  content/come-at-me-bro-2.jpg | Bin 0 -> 338843 bytes

remote:  1 file changed, 0 insertions(+), 0 deletions(-)

remote:  create mode 100644 content/come-at-me-bro-2.jpg

remote: generate a new gitlister.html file

remote: sort the file

remote: copy stuff over, and set the permissions correctly

remote: done!

To myuser@mysite:~/git/creations.nokes.name.git

   63d06bc..d4c8ca2  master -> master
```

And, presto, we have more bros!