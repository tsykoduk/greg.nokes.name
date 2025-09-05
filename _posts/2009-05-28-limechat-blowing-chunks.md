---
id: 720
title: Limechat blowing chunks
date: 2009-05-28T21:11:00+00:00
author: tsykoduk
layout: post
guid: https://greg.nokes.name/?p=720
permalink: /2009/05/28/limechat-blowing-chunks/
categories:
  - Computers! and Code!
tags:
  - linkedin
description: "Fix LimeChat IRC client crashes on Mac OSX with a simple one-line code edit. Learn how to comment out the problematic line in markedscroller.rb to stop crashes."
---
I love <a href="http://limechat.net/mac/">Limechat</a> for my mac IRC needs. However, it started blowing chunks a few OSX updates ago, and that was plain annoying!

<em><strong>update</strong> <a href="http://limechat.net/mac/">Limechat 1.0</a> fixes the problem. Yay!</em>

<!--more-->

I found a really simple fix. Open up markedscroller.rb and comment out line 40. Works like a charm for me.

Simply do <code>sudo mate /Applications/LimeChat.app/Contents/Resources/markedscroller.rb</code> and scroll down to line 40. make the changes below.


```
# draw lines
#This line seems to blow chunks when highlights happen. W/o it it seems to work?
# NSRectClip(self.rectForPart(NSScrollerKnobSlot).inset(3.0, 4.0)) 
# end changes
@dataSource.scroller_markColor(self).set
lines.each {|i| i.stroke }
self.drawKnob
end
```

<em>Note, if you do not use textmate, or do not have the command line bindings installed, substitute your favorite text editor for the <code>mate</code> command.</em>