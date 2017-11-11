---
id: 7066
title: 'Console Ninja'ry'
date: 2008-03-06T21:08:00+00:00
author: tsykoduk
layout: post
guid: 30/2008/12/27/console-ninja-ry
permalink: /2008/03/06/console-ninja-ry/
categories:
  - Computers! and Code!
---
In an ever misguided attempt to reorginize this blog, I decided that I had far too many sections. I wanted to use tags more, and sections less. But that left me with the following question - how to move the articles around? Should I do it by hand? Na....

            <!--more-->

            So, the first task to tackle was to make sure that the existing section structure was migrated over to tags.


I cobbled together this little hunk of code


<table class="CodeRay"><tr>
  <td class="line_numbers" title="click to toggle" onclick="with (this.firstChild.style) { display = (display == '') ? 'none' : '' }"><pre>1<tt>
</tt>2<tt>
</tt>3<tt>
</tt>4<tt>
</tt><strong>5</strong><tt>
</tt>6<tt>
</tt>7<tt>
</tt>8<tt>
</tt></pre></td>
  <td class="code"><pre ondblclick="with (this.style) { overflow = (overflow == 'auto' || overflow == '') ? 'visible' : 'auto' }">sections = <span class="co">Sections</span>.find(<span class="sy">:all</span>)<tt>
</tt><span class="r">for</span> sect <span class="r">in</span> sections<tt>
</tt>  arts = sect.articles<tt>
</tt>  <span class="r">for</span> art <span class="r">in</span> arts<tt>
</tt>    art.tag = sect.name<tt>
</tt>    art.save<tt>
</tt>  <span class="r">end</span><tt>
</tt><span class="r">end</span></pre></td>
</tr></table>


This will parse all of the articles in the database, and add a tag for each section that they belong to.


Second was how to move the articles around...


<table class="CodeRay"><tr>
  <td class="line_numbers" title="click to toggle" onclick="with (this.firstChild.style) { display = (display == '') ? 'none' : '' }"><pre>1<tt>
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
</tt></pre></td>
  <td class="code"><pre ondblclick="with (this.style) { overflow = (overflow == 'auto' || overflow == '') ? 'visible' : 'auto' }">sect = <span class="co">Section</span>.find_by_name(<span class="s"><span class="dl">&quot;</span><span class="k">old_section_name</span><span class="dl">&quot;</span></span>)<tt>
</tt>new_sect = <span class="co">Section</span>.find_by_name(<span class="s"><span class="dl">&quot;</span><span class="k">new_section_name</span><span class="dl">&quot;</span></span>)<tt>
</tt>arts = sect.articles<tt>
</tt><span class="r">for</span> art <span class="r">in</span> arts<tt>
</tt>  <span class="r">if</span> art.sections.include? new_sect<tt>
</tt>    art.sections.delete sect<tt>
</tt>  <span class="r">else</span><tt>
</tt>    art.sections &lt;&lt; new_sect<tt>
</tt>    art.sections.delete sect<tt>
</tt>  <span class="r">end</span><tt>
</tt>  art.save<tt>
</tt><span class="r">end</span></pre></td>
</tr></table>


Since it's not really an automatable choice, I plugged the correct values in for <code>old_section_name</code> and <code>new_section_name</code> and  allowed it to move stuff where I wanted it. Viola, 20 sections down to 4.