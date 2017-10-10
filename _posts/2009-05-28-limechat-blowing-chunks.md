---
id: 14229
title: Limechat blowing chunks
date: 2009-05-28T21:11:00+00:00
author: tsykoduk
layout: post
guid: 30/2009/06/03/limechat-blowing-chunks
permalink: /2009/05/28/limechat-blowing-chunks/
categories:
  - Computers! and Code!
tags:
  - linkedin
---
I love <a href="http://limechat.net/mac/">Limechat</a> for my mac IRC needs. However, it started blowing chunks a few OSX updates ago, and that was plain annoying!

<em><strong>update</strong> <a href="http://limechat.net/mac/">Limechat 1.0</a> fixes the problem. Yay!</em>

<!--more-->

I found a really simple fix. Open up markedscroller.rb and comment out line 40. Works like a charm for me.

Simply do <code>sudo mate /Applications/LimeChat.app/Contents/Resources/markedscroller.rb</code> and scroll down to line 40. make the changes below.
<div class="CodeMacro">
<table class="CodeRay" border="0">
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
</tt></pre>
</td>
<td class="code">
<pre ondblclick="with (this.style) { overflow = (overflow == 'auto' || overflow == '') ? 'visible' : 'auto' }">  <span class="c"># draw lines</span><tt>
</tt>      <span class="c">#This line seems to blow chunks when highlights happen. W/o it it seems to work?</span><tt>
</tt>      <span class="c"># NSRectClip(self.rectForPart(NSScrollerKnobSlot).inset(3.0, 4.0)) </span><tt>
</tt>      <span class="c"># end changes</span><tt>
</tt>      <span class="iv">@dataSource</span>.scroller_markColor(<span class="pc">self</span>).set<tt>
</tt>      lines.each {|i| i.stroke }<tt>
</tt>      <span class="pc">self</span>.drawKnob<tt>
</tt>  <span class="r">end</span></pre>
</td>
</tr>
</tbody></table>
</div>
<em>Note, if you do not use textmate, or do not have the command line bindings installed, substitute your favorite text editor for the <code>mate</code> command.</em>