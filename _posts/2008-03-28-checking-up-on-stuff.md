---
id: 1503
title: Checking up on stuff
date: 2008-03-28T23:04:00+00:00
author: tsykoduk
layout: post
guid: 30/2008/12/27/checking-up-on-stuff
permalink: /2008/03/28/checking-up-on-stuff/
categories:
  - Computers! and Code!
---
<img style="float: right;" src="http://greg.nokes.name/assets/2008/3/28/rosette_abtps_thumbnail.png" alt="" /><em>In doing some spring cleaning, I found this old article from years past. Enjoy!</em>

If you work in networking, you probably want to be notified when something crashes, looses connection or just generally goes T.U.
Enter, Condor NG! Condor NG is a simple shell script used by yours truly to monitor my work network. It's light, easy and just plain works.
<!--more-->

There are only two config files, the Site file (site.cfg) and the Mail file (mail.cfg). site.cfg should have a list of host names to check, one per line. As many as you want. mail.cfg should have the email addresses that you want to send reports to, one per line.

The rest assumes that we are installed into /belfry with a /belfry/tmp and /belfry/log - change as needed. You can change that under defines in the script. If you want it to email you (or text your cell phone thru the email interface - check with your provider for details if you do not know how) you will need to set the mailgate define to the host name of your mail gateway. If not, set mailgate to localhost, so it will not think that the entire world has crashed.

Use cron to schedule (I run it every five minutes)

<strong>Update 10/17/2010: </strong>Check out the updated code on <a href="http://github.com/tsykoduk/CondorNG">GitHub</a>!

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

</tt><strong>95</strong><tt>

</tt>96<tt>

</tt>97<tt>

</tt>98<tt>

</tt>99<tt>

</tt><strong>100</strong><tt>

</tt>101<tt>

</tt>102<tt>

</tt>103<tt>

</tt>104<tt>

</tt><strong>105</strong><tt>

</tt>106<tt>

</tt>107<tt>

</tt>108<tt>

</tt>109<tt>

</tt><strong>110</strong><tt>

</tt>111<tt>

</tt>112<tt>

</tt>113<tt>

</tt>114<tt>

</tt><strong>115</strong><tt>

</tt>116<tt>

</tt>117<tt>

</tt>118<tt>

</tt>119<tt>

</tt><strong>120</strong><tt>

</tt>121<tt>

</tt>122<tt>

</tt>123<tt>

</tt>124<tt>

</tt><strong>125</strong><tt>

</tt>126<tt>

</tt>127<tt>

</tt>128<tt>

</tt>129<tt>

</tt><strong>130</strong><tt>

</tt>131<tt>

</tt>132<tt>

</tt>133<tt>

</tt>134<tt>

</tt><strong>135</strong><tt>

</tt>136<tt>

</tt>137<tt>

</tt>138<tt>

</tt>139<tt>

</tt><strong>140</strong><tt>

</tt>141<tt>

</tt>142<tt>

</tt>143<tt>

</tt>144<tt>

</tt><strong>145</strong><tt>

</tt>146<tt>

</tt>147<tt>

</tt>148<tt>

</tt>149<tt>

</tt><strong>150</strong><tt>

</tt>151<tt>

</tt>152<tt>

</tt></pre>

</td>

<td class="code">

<pre ondblclick="with (this.style) { overflow = (overflow == 'auto' || overflow == '') ? 'visible' : 'auto' }"><span class="c">#!/bin/sh</span><tt>

</tt><span class="c">#set -x</span><tt>

</tt><span class="c"># Code (c) Greg Nokes under GPL 2 or later</span><tt>

</tt><span class="c"># greg (at) nokes (dot) name</span><tt>

</tt><span class="c">#Pinger 2.0a GNokes 10/7/05. Took original code, cleaned up.</span><tt>

</tt><span class="c">#</span><tt>

</tt><span class="c">#</span><tt>

</tt><span class="c">#3.0.1 10/18/05 added mail.cfg and re-wrote callhome() to use it; also cleaned up code a wee bit</span><tt>

</tt><span class="c">#3.0.2 10/18/05 removed path from config files</span><tt>

</tt><span class="c">#3.0.3 10/18/05 readded path to config files</span><tt>

</tt><span class="c">#</span><tt>

</tt><span class="c">#3.1.1 10/19/05 removed two call homes - program only calls home when host is down, comes up.</span><tt>

</tt><span class="c">#3.2 10/31/05 Need to follow one email directive</span><tt>

</tt><span class="c">#3.3 11/02/05 Need to have email sent only after host down on second cycle; added safteynet</span><tt>

</tt><span class="c">#3.3.1 11/03/05 Added MAILGATE, changed all paths to belfry. Moved exectution to belfry.</span><tt>

</tt><span class="c">###########</span><tt>

</tt><span class="c"># Defines #</span><tt>

</tt><span class="c">###########</span><tt>

</tt><span class="co">BASE</span>=<span class="rx"><span class="dl">/</span><span class="k">bin</span><span class="dl">/</span></span><tt>

</tt><span class="co">TEMP</span>=<span class="rx"><span class="dl">/</span><span class="k">belfry</span><span class="dl">/</span></span>tmp/condor.tmp<tt>

</tt><span class="co">LOG</span>=<span class="rx"><span class="dl">/</span><span class="k">belfry</span><span class="dl">/</span></span>log/condor.log<tt>

</tt><span class="co">TRACK</span>=<span class="rx"><span class="dl">/</span><span class="k">belfry</span><span class="dl">/</span></span>log/condordown.log<tt>

</tt><span class="co">SITE</span>=<span class="sh"><span class="dl">`</span><span class="k">cat /belfry/condorNG/site.cfg</span><span class="dl">`</span></span><tt>

</tt><span class="co">TOAST</span>=<span class="rx"><span class="dl">/</span><span class="k">belfry</span><span class="dl">/</span></span>tmp/condor.toast<tt>

</tt><span class="co">ML</span>=<span class="sh"><span class="dl">`</span><span class="k">cat /belfry/condorNG/mail.cfg</span><span class="dl">`</span></span><tt>

</tt><span class="co">RPT</span>=<span class="rx"><span class="dl">/</span><span class="k">belfry</span><span class="dl">/</span></span>tmp/condor.rpt<tt>

</tt><span class="co">MAILGATE</span>=<tt>

</tt><span class="c">#############</span><tt>

</tt><span class="c"># Functions #</span><tt>

</tt><span class="c">#############</span><tt>

</tt><span class="c"># All of my functions go here</span><tt>

</tt><span class="co">PING</span> ()<tt>

</tt>{<tt>

</tt><span class="c"># Do Pinging and write to Logfile</span><tt>

</tt><span class="c"># Also check for previous down state, ignore if site was up</span><tt>

</tt><span class="c"># callhome with down if site down, callhome with up if site came back up</span><tt>

</tt> <tt>

</tt><span class="r">for</span> i <span class="r">in</span> <span class="gv">$SITE</span><tt>

</tt><span class="r">do</span><tt>

</tt><span class="r">if</span> ! ping -c <span class="i">3</span> -w <span class="i">5</span> <span class="gv">$i</span>&gt;<span class="rx"><span class="dl">/</span><span class="k">dev</span><span class="dl">/</span><span class="mod">nu</span></span>ll<tt>

</tt><span class="r">then</span><tt>

</tt>echo <span class="gv">$i</span><span class="sy">:noping</span><tt>

</tt>printf <span class="s"><span class="dl">"</span><span class="k">Host:</span><span class="ch">\t</span><span class="k">Down</span><span class="ch">\t</span><span class="k">$i</span><span class="ch">\t</span><span class="k">$(date)</span><span class="ch">\n</span><span class="dl">"</span></span>&gt;&gt;<span class="gv">$LOG</span><tt>

</tt><span class="r">if</span> [ -e <span class="s"><span class="dl">"</span><span class="k">/tmp/$i.ping.dropped</span><span class="dl">"</span></span> ]<tt>

</tt><span class="r">then</span><tt>

</tt>echo <span class="gv">$i</span><span class="sy">:down</span><tt>

</tt><span class="co">CALLHOME</span> <span class="gv">$i</span> <span class="co">Down</span><tt>

</tt>rm <span class="rx"><span class="dl">/</span><span class="k">tmp</span><span class="dl">/</span></span><span class="gv">$i</span>.ping*<tt>

</tt>touch <span class="rx"><span class="dl">/</span><span class="k">tmp</span><span class="dl">/</span></span><span class="gv">$i</span>.ping.no<tt>

</tt>printf <span class="s"><span class="dl">"</span><span class="k">Host:</span><span class="ch">\t</span><span class="k">Down</span><span class="ch">\t</span><span class="k">$i</span><span class="ch">\t</span><span class="k">$(date)</span><span class="ch">\n</span><span class="dl">"</span></span>&gt;&gt;<span class="gv">$TRACK</span><tt>

</tt>elif [ -e <span class="s"><span class="dl">"</span><span class="k">/tmp/$i.ping.yes</span><span class="dl">"</span></span> ]<tt>

</tt><span class="r">then</span><tt>

</tt>echo <span class="gv">$i</span><span class="sy">:dropped</span><tt>

</tt>rm <span class="rx"><span class="dl">/</span><span class="k">tmp</span><span class="dl">/</span></span><span class="gv">$i</span>.ping*<tt>

</tt>touch <span class="rx"><span class="dl">/</span><span class="k">tmp</span><span class="dl">/</span></span><span class="gv">$i</span>.ping.drop<tt>

</tt>printf <span class="s"><span class="dl">"</span><span class="k">Host:</span><span class="ch">\t</span><span class="k">Dropped</span><span class="ch">\t</span><span class="k">$i</span><span class="ch">\t</span><span class="k">$(date)</span><span class="ch">\n</span><span class="dl">"</span></span>&gt;&gt;<span class="gv">$TRACK</span><tt>

</tt><span class="r">else</span><tt>

</tt>echo <span class="gv">$i</span><span class="sy">:dropped</span><tt>

</tt>rm <span class="rx"><span class="dl">/</span><span class="k">tmp</span><span class="dl">/</span></span><span class="gv">$i</span>.ping*<tt>

</tt>touch <span class="rx"><span class="dl">/</span><span class="k">tmp</span><span class="dl">/</span></span><span class="gv">$i</span>.ping.drop<tt>

</tt>printf <span class="s"><span class="dl">"</span><span class="k">Host:</span><span class="ch">\t</span><span class="k">Dropped</span><span class="ch">\t</span><span class="k">$i</span><span class="ch">\t</span><span class="k">$(date)</span><span class="ch">\n</span><span class="dl">"</span></span>&gt;&gt;<span class="gv">$TRACK</span><tt>

</tt>fi<tt>

</tt><span class="r">else</span><tt>

</tt><span class="r">if</span> [ -e <span class="s"><span class="dl">"</span><span class="k">/tmp/$i.ping.no</span><span class="dl">"</span></span> ]<tt>

</tt><span class="r">then</span><tt>

</tt>echo <span class="gv">$i</span><span class="sy">:back</span><tt>

</tt><span class="co">CALLHOME</span> <span class="gv">$i</span> <span class="co">Up</span><tt>

</tt>printf <span class="s"><span class="dl">"</span><span class="k">Host:</span><span class="ch">\t</span><span class="k">Up</span><span class="ch">\t</span><span class="k">$i</span><span class="ch">\t</span><span class="k">$(date)</span><span class="ch">\n</span><span class="dl">"</span></span>&gt;&gt;<span class="gv">$TRACK</span><tt>

</tt>printf <span class="s"><span class="dl">"</span><span class="k">Host:</span><span class="ch">\t</span><span class="k">Up</span><span class="ch">\t</span><span class="k">$i</span><span class="ch">\t</span><span class="k">$(date)</span><span class="ch">\n</span><span class="dl">"</span></span>&gt;&gt;<span class="gv">$LOG</span><tt>

</tt>elif [ -e <span class="s"><span class="dl">"</span><span class="k">/tmp/$i.ping.drop</span><span class="dl">"</span></span> ]<tt>

</tt><span class="r">then</span><tt>

</tt>echo <span class="gv">$i</span><span class="sy">:back</span><tt>

</tt>printf <span class="s"><span class="dl">"</span><span class="k">Host:</span><span class="ch">\t</span><span class="k">Up</span><span class="ch">\t</span><span class="k">$i</span><span class="ch">\t</span><span class="k">$(date)</span><span class="ch">\n</span><span class="dl">"</span></span>&gt;&gt;<span class="gv">$LOG</span><tt>

</tt>printf <span class="s"><span class="dl">"</span><span class="k">Host:</span><span class="ch">\t</span><span class="k">Up</span><span class="ch">\t</span><span class="k">$i</span><span class="ch">\t</span><span class="k">$(date)</span><span class="ch">\n</span><span class="dl">"</span></span>&gt;&gt;<span class="gv">$TRACK</span><tt>

</tt>elif [ -e <span class="s"><span class="dl">"</span><span class="k">/tmp/$i.ping.yes</span><span class="dl">"</span></span> ]<tt>

</tt><span class="r">then</span><tt>

</tt>printf <span class="s"><span class="dl">"</span><span class="k">Host:</span><span class="ch">\t</span><span class="ch">\t</span><span class="k">$i</span><span class="ch">\t</span><span class="k">$(date)</span><span class="ch">\n</span><span class="dl">"</span></span>&gt;&gt;<span class="gv">$LOG</span><tt>

</tt>fi<tt>

</tt>echo <span class="gv">$i</span><span class="sy">:pingcheck</span><tt>

</tt>rm <span class="rx"><span class="dl">/</span><span class="k">tmp</span><span class="dl">/</span></span><span class="gv">$i</span>.ping*<tt>

</tt>touch <span class="rx"><span class="dl">/</span><span class="k">tmp</span><span class="dl">/</span></span><span class="gv">$i</span>.ping.yes<tt>

</tt>fi<tt>

</tt>done<tt>

</tt>}<tt>

</tt> <tt>

</tt><span class="co">CALLHOME</span> ()<tt>

</tt>{<tt>

</tt><span class="c">#Build the Report</span><tt>

</tt> <tt>

</tt>printf <span class="s"><span class="dl">"</span><span class="k">$1 $2</span><span class="ch">\n</span><span class="dl">"</span></span>&gt;&gt; <span class="gv">$RPT</span><tt>

</tt> <tt>

</tt>}<tt>

</tt> <tt>

</tt><span class="co">MAILER</span> ()<tt>

</tt>{<tt>

</tt><span class="c"># Check to see if we can get to the gateway</span><tt>

</tt><span class="r">if</span> ping -c <span class="i">6</span> -w <span class="i">10</span> <span class="gv">$MAILGATE</span>&gt;<span class="rx"><span class="dl">/</span><span class="k">dev</span><span class="dl">/</span><span class="mod">nu</span></span>ll<tt>

</tt><span class="r">then</span><tt>

</tt><span class="c">#Yup - proceed</span><tt>

</tt><span class="r">for</span> m <span class="r">in</span> <span class="gv">$ML</span><tt>

</tt><span class="r">do</span><tt>

</tt>cat <span class="gv">$RPT</span> | mail -s <span class="s"><span class="dl">"</span><span class="k">Condor Report</span><span class="dl">"</span></span> <span class="gv">$m</span><tt>

</tt>done<tt>

</tt><span class="r">else</span><tt>

</tt><span class="c"># Uh-oh. We have a problem!</span><tt>

</tt><span class="c"># In a perfect world we would dial out with a modem</span><tt>

</tt>printf <span class="s"><span class="dl">"</span><span class="k">ALERT ALERT ALERT ALERT ALERT $(date) CANNOT SEND MAIL</span><span class="ch">\n</span><span class="dl">"</span></span>&gt;&gt;<span class="gv">$LOG</span><tt>

</tt>printf <span class="s"><span class="dl">"</span><span class="k">ALERT ALERT ALERT ALERT ALERT $(date) CANNOT SEND MAIL</span><span class="ch">\n</span><span class="dl">"</span></span>&gt;&gt;<span class="gv">$TRACK</span><tt>

</tt><span class="c"># Write a temp file so we can tell next cycle that we had a problem</span><tt>

</tt>touch <span class="gv">$TOAST</span><tt>

</tt> <tt>

</tt>fi<tt>

</tt> <tt>

</tt>}<tt>

</tt> <tt>

</tt><span class="co">MCP</span> ()<tt>

</tt>{<tt>

</tt> <tt>

</tt><span class="c"># Master Control Program</span><tt>

</tt> <tt>

</tt><span class="c"># Initial housekeeping</span><tt>

</tt>mv <span class="gv">$TEMP</span> /tmp/condor2.tmp<tt>

</tt>touch <span class="gv">$TEMP</span>&gt;<span class="rx"><span class="dl">/</span><span class="k">dev</span><span class="dl">/</span><span class="mod">nu</span></span>ll<tt>

</tt><span class="c"># We need to create the file, so the delete does not throw an error</span><tt>

</tt>touch <span class="gv">$RPT</span><tt>

</tt>rm <span class="gv">$RPT</span>&gt;<span class="rx"><span class="dl">/</span><span class="k">dev</span><span class="dl">/</span><span class="mod">nu</span></span>ll<tt>

</tt> <tt>

</tt><span class="c"># Write cool line to log</span><tt>

</tt>echo <span class="s"><span class="dl">"</span><span class="k"> =========================================================================</span><span class="dl">"</span></span>&gt;&gt; <span class="gv">$LOG</span><tt>

</tt> <tt>

</tt><span class="c"># Run Ping Checks on all target hosts</span><tt>

</tt><span class="co">PING</span><tt>

</tt> <tt>

</tt><span class="c"># Did we have a major problem last cycle?</span><tt>

</tt><span class="r">if</span> [ -e <span class="s"><span class="dl">"</span><span class="k">$TOAST</span><span class="dl">"</span></span> ]<tt>

</tt><span class="r">then</span><tt>

</tt>printf <span class="s"><span class="dl">"</span><span class="k">ALERT ALERT ALERT ALERT ALERT $(date) Main Site BACK!!</span><span class="ch">\n</span><span class="dl">"</span></span>&gt;&gt;<span class="gv">$RPT</span><tt>

</tt>rm <span class="rx"><span class="dl">/</span><span class="k">tmp</span><span class="dl">/</span><span class="mod">s</span></span>pokane.toast<tt>

</tt>fi<tt>

</tt> <tt>

</tt><span class="c"># If we have something to report, then send it off</span><tt>

</tt><span class="r">if</span> [ -e <span class="s"><span class="dl">"</span><span class="k">$RPT</span><span class="dl">"</span></span> ]<tt>

</tt><span class="r">then</span><tt>

</tt><span class="co">MAILER</span><tt>

</tt>fi<tt>

</tt>}<tt>

</tt> <tt>

</tt><span class="c">###########</span><tt>

</tt><span class="c"># Program #</span><tt>

</tt><span class="c">###########</span><tt>

</tt> <tt>

</tt><span class="co">MCP</span>&gt;&gt; <span class="gv">$TEMP</span><tt>

</tt></pre>

</td>

</tr>

</tbody>

</table>