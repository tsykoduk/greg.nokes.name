---
id: 2859
title: Scan and Copy Redux
date: 2007-06-13T23:43:00+00:00
author: tsykoduk
layout: post
guid: 30/2008/12/27/scan-and-copy-redux
permalink: /2007/06/13/scan-and-copy-redux/
categories:
  - Computers! and Code!
---
A co-worker pointed out that <a href="http://greg.nokes.name/2007/4/3/scan-and-copy">Scan and Copy</a> did not work all that well on XP. Not a real issue, since I had used it to back up win2k machines in prep for a XP roll out. Well, anyways, I made the few changes to XP it, as well as adding in some more functionality.

            <!--more-->

            There are now 3 command line options


<ul>
  <li><b>-name</b> Names the target directory, which will be created if it does not exist</li>
  <li><b>-target</b> Gives a target directory to place the backup folder in.</li>
  <li> A list of file extensions to look for</li>
</ul>

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
</tt>13<tt>
</tt>14<tt>
</tt><strong>15</strong><tt>
</tt>16<tt>
</tt>17<tt>
</tt>18<tt>
</tt>19<tt>
</tt><strong>20</strong><tt>
</tt>21<tt>
</tt>22<tt>
</tt>23<tt>
</tt>24<tt>
</tt><strong>25</strong><tt>
</tt>26<tt>
</tt>27<tt>
</tt>28<tt>
</tt>29<tt>
</tt><strong>30</strong><tt>
</tt>31<tt>
</tt>32<tt>
</tt>33<tt>
</tt>34<tt>
</tt><strong>35</strong><tt>
</tt>36<tt>
</tt>37<tt>
</tt>38<tt>
</tt>39<tt>
</tt><strong>40</strong><tt>
</tt>41<tt>
</tt>42<tt>
</tt>43<tt>
</tt>44<tt>
</tt><strong>45</strong><tt>
</tt>46<tt>
</tt>47<tt>
</tt>48<tt>
</tt>49<tt>
</tt><strong>50</strong><tt>
</tt>51<tt>
</tt>52<tt>
</tt>53<tt>
</tt>54<tt>
</tt><strong>55</strong><tt>
</tt>56<tt>
</tt>57<tt>
</tt>58<tt>
</tt>59<tt>
</tt><strong>60</strong><tt>
</tt>61<tt>
</tt>62<tt>
</tt>63<tt>
</tt>64<tt>
</tt><strong>65</strong><tt>
</tt>66<tt>
</tt>67<tt>
</tt>68<tt>
</tt>69<tt>
</tt><strong>70</strong><tt>
</tt>71<tt>
</tt>72<tt>
</tt>73<tt>
</tt>74<tt>
</tt><strong>75</strong><tt>
</tt>76<tt>
</tt>77<tt>
</tt>78<tt>
</tt>79<tt>
</tt><strong>80</strong><tt>
</tt>81<tt>
</tt>82<tt>
</tt>83<tt>
</tt>84<tt>
</tt><strong>85</strong><tt>
</tt>86<tt>
</tt>87<tt>
</tt>88<tt>
</tt>89<tt>
</tt><strong>90</strong><tt>
</tt>91<tt>
</tt>92<tt>
</tt>93<tt>
</tt>94<tt>
</tt></pre></td>
  <td class="code"><pre ondblclick="with (this.style) { overflow = (overflow == 'auto' || overflow == '') ? 'visible' : 'auto' }"><span class="c">#Stuff we need</span><tt>
</tt>require <span class="s"><span class="dl">'</span><span class="k">getoptlong</span><span class="dl">'</span></span><tt>
</tt>require <span class="s"><span class="dl">'</span><span class="k">ftools</span><span class="dl">'</span></span><tt>
</tt> <tt>
</tt><span class="c">#Get the command line options</span><tt>
</tt><span class="c">#Required command lines</span><tt>
</tt><span class="c"># --name 'user name'</span><tt>
</tt><span class="c"># a list of extensions to search for</span><tt>
</tt><span class="c"># -- target 'path'</span><tt>
</tt><span class="c"># Target directory to put stuff into</span><tt>
</tt> <tt>
</tt><span class="iv">@backed</span> = <span class="i">0</span><tt>
</tt><span class="iv">@collisions</span> = <span class="i">0</span><tt>
</tt><span class="iv">@totfiles</span> = <span class="i">0</span><tt>
</tt><span class="iv">@filetype</span> = <span class="co">Array</span>.new<tt>
</tt> <tt>
</tt>opts = <span class="co">GetoptLong</span>.new(<tt>
</tt>      [<span class="s"><span class="dl">&quot;</span><span class="k">--name</span><span class="dl">&quot;</span></span>, <span class="s"><span class="dl">&quot;</span><span class="k">-n</span><span class="dl">&quot;</span></span>, <span class="co">GetoptLong</span>::<span class="co">REQUIRED_ARGUMENT</span>],<tt>
</tt>      [<span class="s"><span class="dl">&quot;</span><span class="k">--target</span><span class="dl">&quot;</span></span>,<span class="s"><span class="dl">&quot;</span><span class="k">-t</span><span class="dl">&quot;</span></span>,<span class="co">GetoptLong</span>::<span class="co">OPTIONAL_ARGUMENT</span>],<tt>
</tt>      [<span class="s"><span class="dl">&quot;</span><span class="k">--help</span><span class="dl">&quot;</span></span>,<span class="s"><span class="dl">&quot;</span><span class="k">-h</span><span class="dl">&quot;</span></span>,<span class="co">GetoptLong</span>::<span class="co">OPTIONAL_ARGUMENT</span>])<tt>
</tt> <tt>
</tt><span class="c">#Parse the options, assigning them to the correct variables.</span><tt>
</tt>opts.each <span class="r">do</span> |opt, arg|<tt>
</tt>  <span class="r">case</span> opt<tt>
</tt>    <span class="r">when</span>  <span class="s"><span class="dl">&quot;</span><span class="k">--name</span><span class="dl">&quot;</span></span><tt>
</tt>      <span class="iv">@name</span> = arg.to_s<tt>
</tt>    <span class="r">when</span> <span class="s"><span class="dl">&quot;</span><span class="k">--target</span><span class="dl">&quot;</span></span><tt>
</tt>      <span class="iv">@target</span> = arg.to_s<tt>
</tt>    <span class="r">end</span><tt>
</tt><span class="r">end</span><tt>
</tt> <tt>
</tt><span class="r">for</span> ext <span class="r">in</span> <span class="pc">ARGV</span><tt>
</tt>  <span class="iv">@filetype</span> &lt;&lt; ext<tt>
</tt><span class="r">end</span><tt>
</tt> <tt>
</tt> <tt>
</tt><span class="r">if</span> <span class="iv">@target</span>.nil?<tt>
</tt>  <span class="iv">@target</span> = <span class="s"><span class="dl">&quot;</span><span class="k">y</span><span class="ch">\:</span><span class="ch">\\</span><span class="k">backups</span><span class="ch">\\</span><span class="dl">&quot;</span></span><tt>
</tt><span class="r">end</span><tt>
</tt> <tt>
</tt><span class="iv">@path</span> = <span class="iv">@target</span> + <span class="iv">@name</span><tt>
</tt> <tt>
</tt><span class="c">#let's tell everyone what we are doing...</span><tt>
</tt>  puts <span class="s"><span class="dl">&quot;</span><span class="dl">&quot;</span></span><tt>
</tt>  puts <span class="s"><span class="dl">&quot;</span><span class="k">Copying to...</span><span class="dl">&quot;</span></span><tt>
</tt>  puts <span class="iv">@path</span><tt>
</tt>  puts <span class="s"><span class="dl">&quot;</span><span class="k">Looking for...</span><span class="dl">&quot;</span></span><tt>
</tt>  puts <span class="iv">@filetype</span><tt>
</tt>  puts <span class="s"><span class="dl">&quot;</span><span class="dl">&quot;</span></span><tt>
</tt> <tt>
</tt><span class="c">#Do basic checking to insure that everything we need is there</span><tt>
</tt> <tt>
</tt><span class="c">#need to improve logic here - </span><tt>
</tt>  <span class="r">rescue</span> <span class="r">if</span> lower level directorys <span class="r">do</span> <span class="r">not</span> exist!<tt>
</tt><span class="c">#Create base path if it does not exist?</span><tt>
</tt> <tt>
</tt><span class="r">unless</span> <span class="co">File</span>.exist?(<span class="iv">@path</span>)<tt>
</tt>    <span class="r">unless</span> <span class="co">File</span>.exist?(<span class="iv">@target</span>)<tt>
</tt>      <span class="co">Dir</span>.mkdir(<span class="iv">@target</span>)<tt>
</tt>    <span class="r">end</span><tt>
</tt>      <span class="co">Dir</span>.mkdir(<span class="iv">@path</span>)<tt>
</tt><span class="r">end</span><tt>
</tt> <tt>
</tt>  <span class="c">#Start main process of program</span><tt>
</tt>  <span class="co">Dir</span>.chdir(<span class="s"><span class="dl">&quot;</span><span class="k">c:</span><span class="ch">\\</span><span class="dl">&quot;</span></span>)<tt>
</tt>  <span class="co">Dir</span>[<span class="s"><span class="dl">'</span><span class="k">/**/**</span><span class="dl">'</span></span>].each <span class="r">do</span> |item|<tt>
</tt>    <span class="iv">@totfiles</span> = <span class="iv">@totfiles</span> + <span class="i">1</span><tt>
</tt>    <span class="r">unless</span>(<span class="co">FileTest</span>.directory?(item))<tt>
</tt>      <span class="r">if</span> <span class="iv">@filetype</span>.include?(<span class="co">File</span>.extname(item))<tt>
</tt>        <span class="r">if</span> <span class="co">FileTest</span>.exist?(<span class="iv">@path</span> + <span class="s"><span class="dl">&quot;</span><span class="ch">\\</span><span class="dl">&quot;</span></span> + <span class="co">File</span>.basename(item))<tt>
</tt>          p = <span class="iv">@path</span> + <span class="s"><span class="dl">&quot;</span><span class="ch">\\</span><span class="dl">&quot;</span></span> + <span class="co">File</span>.basename(item, <span class="s"><span class="dl">&quot;</span><span class="k">.*</span><span class="dl">&quot;</span></span>) + <span class="s"><span class="dl">&quot;</span><span class="k">_</span><span class="dl">&quot;</span></span>+ <tt>
</tt>            rand(<span class="i">100000000</span>).to_s + <span class="s"><span class="dl">&quot;</span><span class="k">_</span><span class="dl">&quot;</span></span> + <span class="co">File</span>.extname(item)<tt>
</tt>          <span class="co">File</span>.copy item, p<tt>
</tt>          printf(<span class="s"><span class="dl">&quot;</span><span class="k">C</span><span class="dl">&quot;</span></span>)<tt>
</tt>          <span class="iv">@collisions</span> = <span class="iv">@collisions</span> + <span class="i">1</span><tt>
</tt>          <span class="iv">@backed</span> = <span class="iv">@backed</span> + <span class="i">1</span><tt>
</tt>          <span class="c">#Duplicate File Error.</span><tt>
</tt>        <span class="r">else</span><tt>
</tt>          p = <span class="iv">@path</span> + <span class="s"><span class="dl">&quot;</span><span class="ch">\\</span><span class="dl">&quot;</span></span> + <span class="co">File</span>.basename(item)<tt>
</tt>          <span class="co">File</span>.copy item, p<tt>
</tt>          <span class="c">#Backed up file</span><tt>
</tt>          printf(<span class="s"><span class="dl">&quot;</span><span class="k">B</span><span class="dl">&quot;</span></span>)<tt>
</tt>          <span class="iv">@backed</span> = <span class="iv">@backed</span> + <span class="i">1</span><tt>
</tt>        <span class="r">end</span><tt>
</tt>      <span class="r">else</span><tt>
</tt>        printf(<span class="s"><span class="dl">&quot;</span><span class="k">.</span><span class="dl">&quot;</span></span>)<tt>
</tt>      <span class="r">end</span><tt>
</tt>    <span class="r">end</span><tt>
</tt>  <span class="r">end</span><tt>
</tt> <tt>
</tt> <tt>
</tt>puts <span class="s"><span class="dl">&quot;</span><span class="dl">&quot;</span></span><tt>
</tt>puts <span class="s"><span class="dl">&quot;</span><span class="k">Checked </span><span class="il"><span class="dl">#{</span><span class="iv">@totfiles</span><span class="dl">}</span></span><span class="k"> Files.</span><span class="dl">&quot;</span></span><tt>
</tt>puts <span class="s"><span class="dl">&quot;</span><span class="il"><span class="dl">#{</span><span class="iv">@backed</span><span class="dl">}</span></span><span class="k"> Files backed up with </span><span class="il"><span class="dl">#{</span><span class="iv">@collisions</span><span class="dl">}</span></span><span class="k"> filename collisions</span><span class="dl">&quot;</span></span><tt>
</tt></pre></td>
</tr></table>