---
id: 7062
title: Archive in Mephisto
date: 2008-03-05T21:27:00+00:00
author: tsykoduk
layout: post
guid: 30/2008/12/27/archive-in-mephisto
permalink: /2008/03/05/archive-in-mephisto/
categories:
  - Computers! and Code!
---
<p>So, I could not find this anywhere - at least not detailed out enough for my small brain. Here is a short how-to on creating monthly archives in Mephisto, using Liquid....</p>

            <!--more-->

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
</tt></pre></td>
  <td class="code"><pre ondblclick="with (this.style) { overflow = (overflow == 'auto' || overflow == '') ? 'visible' : 'auto' }"><span class="ta">&lt;h1&gt;</span>Archives<span class="ta">&lt;/h1&gt;</span><tt>
</tt>      {% if section.months.size <span class="er">&gt;</span> 0 %}<tt>
</tt>        <span class="ta">&lt;ul&gt;</span><tt>
</tt>        {% for month in section.months %}<tt>
</tt>          <span class="ta">&lt;li&gt;</span><span class="ta">&lt;a</span> <span class="an">href</span>=<span class="s"><span class="dl">&quot;</span><span class="k">{{ section | monthly_url: month }}</span><span class="dl">&quot;</span></span><span class="ta">&gt;</span><tt>
</tt>                    {{ month | format_date: 'my' }} <tt>
</tt>                    <span class="ta">&lt;strong&gt;</span><span class="en">&amp;#187;</span><span class="ta">&lt;/strong&gt;</span> <tt>
</tt>                     {{ section | monthly_articles: month | size }}<span class="ta">&lt;/a&gt;</span><span class="ta">&lt;/li&gt;</span><tt>
</tt>        {% endfor %}<tt>
</tt>        <span class="ta">&lt;/ul&gt;</span><tt>
</tt>      {% endif %}</pre></td>
</tr></table>

Pretty slick - it took me a bit of digging to find all of this stuff and put it together.