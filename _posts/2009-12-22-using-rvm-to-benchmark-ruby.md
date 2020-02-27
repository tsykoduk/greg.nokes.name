---
id: 15204
title: Using RVM to benchmark Ruby
date: 2009-12-22T11:33:02+00:00
author: tsykoduk
layout: post
guid: https://greg.nokes.name/?p=15204
permalink: /2009/12/22/using-rvm-to-benchmark-ruby/
categories:
  - Computers! and Code!
tags:
  - ruby
  - rvm
  - scaling
excerpt_separator:  <!--more-->
---
<img class="size-medium wp-image-15206 alignright" title="Screen shot 2009-12-16 at 5.19.10 PM" src="https://greg.nokes.name/wp-content/uploads/2009/12/Screen-shot-2009-12-16-at-5.19.10-PM-300x207.png" alt="Screen shot 2009-12-16 at 5.19.10 PM" width="210" height="145" />

One of the things that I get to do is advise folks on web application architecture and backend process optimization. All of that is to say that I need to know how certain versions of things like ruby perform under different loads, and be able to advise people on when and where to deploy each one. For testing ruby and ruby programs, <a href="http://rvm.beginrescueend.com/">RVM</a> is invaluable. I'll take you through how I tested a slew of ruby version automagically in this article.
<!--more-->
For reference, the machine that I ran these tests on looks like this:

<pre>MemTotal: 16,416,772 kB

CPU: Dual Core AMD Opteron(tm) Processor 880

CPU MHz: 2405.522

CPU cache size: 1024 KB

CPU bogomips: 4813.78

Total number of Cores: 4

OS: Centos 5.4 x86_64</pre>

The first step is to make sure that you have RVM installed, and the rubies that you want to test against installed.

<pre>gem install rvm 

&amp;&amp; rvm-install 

&amp;&amp; rvm reload

&amp;&amp; rvm install 1.8.6,1.8.7,1.9.1,ree,jruby</pre>

Since I wanted to test against 1.8.6 - 1.9.1 as well as ree and jruby, RVM let me install all of those rubies with one command. I then grabbed the swell <a href="http://github.com/acangiano/ruby-benchmark-suite">ruby benchmark suite</a>. Once I had that all cloned from GitHub, I proceeded on to the actual meat of the process.

<pre>rvm use 1.8.6

rake bench:file FILE=benchmarks/macro-benchmarks/bm_hilbert_matrix.rb

rvm use 1.8.7

rake bench:file FILE=benchmarks/macro-benchmarks/bm_hilbert_matrix.rb

rvm use 1.9.1

rake bench:file FILE=benchmarks/macro-benchmarks/bm_hilbert_matrix.rb

rvm use ree

rake bench:file FILE=benchmarks/macro-benchmarks/bm_hilbert_matrix.rb

rvm use jruby

rake bench:file FILE=benchmarks/macro-benchmarks/bm_hilbert_matrix.rb</pre>

Then, you wait.
I chose to run the Hibert Matrix test - it seemed a good baseline emphasizing computational speed. Since it's the same code for each test, there is not an issue with code optimization.

<blockquote>In linear algebra, a Hilbert matrix is a square matrix with entries being the unit fractions...The Hilbert matrix is symmetric and positive definite. The Hilbert matrix is also totally positive (meaning the determinant of every submatrix is positive).
The Hilbert matrix is an example of a Hankel matrix.
The determinant can be expressed in closed form, as a special case of the Cauchy determinant.</blockquote>

<a href="http://www.answers.com/topic/hilbert-matrix">Answers.com</a>
Greek to me, but I guess it means that it's a complex mathematical formula. Anyway, here are the results:
<strong>Ruby 1.8.6</strong>
1.8.6 was able to run the benchmark in 0.04116 seconds at it's quickest. This was at 10 dimensions of the Hilbert Matrix, and it used 4,460,544 bytes of RAM. One of the interesting things that I noted was the the memory bump between each run. On the 60 dimension run, for example, we had memory usage of 12,062,720 bytes for the first run (which completed in 21.785932 seconds), 12,161,024 bytes for the second run (completing in 22.652201 seconds) and 12,308,480 bytes on the third run (completing in 23.352486 seconds). After that, the memory stabilized and the times actually came down into the mid 22 seconds.
<strong>Ruby 1.8.7</strong>
1.8.7 faired worse then 1.8.6 at the lower dimensions of the test. It's quickest run was 0.043361 seconds,  using 4,575,232 bytes of RAM. The RAM bloat was still evident - ranging from 4,575,232 to 5,255,168 bytes in the 10 dimension runs. It was also markedly slower at the higher end of the tests then 1.8.6 - it's best time at 60 dimensions was 27.688745 seconds, however it was frugal on it's RAM, only needing 11,960,320 bytes. The longest run took an astonishing 28.061131 seconds.
<strong>REE 1.8.7</strong>
REE's current version is based on 1.8.7. It purports to be an optimized version, so it should have better numbers then 1.8.7. Well, it does. It's fastest run was 0.040396 second, using 10,399,744 bytes of RAM. Memory growth was also evident - in 10 dimensions we saw growth from 9,875,456 bytes to 10,997,760 bytes - however it did stabilize on the last few runs.
<strong>JRuby 1.8.7</strong>
JRuby is also currently based on the 1.8.7 branch. At lower numbers of dimensions it was hideously slow - .4 seconds for the first run in 10 dimensions. The second run was .19 second, and then down to .09. It used from 61,407,232 bytes of RAM to 68,616,192. However, at the higher ends it began to shine. All of the runs were in the 10.8 second range (twice as fast as any other 1.8 ruby!) using an amazing 235,077,632 bytes of RAM.
<strong>Rubinius 1.8.7</strong>
I really wanted to test this - however at the time of publication, I was not able to get it up and running. I think when they are closer to a final product, this will bear investigating.
<strong>1.9.1</strong>
Out of the gate, 1.9.1 was a strong competitor. The first run took only .0075 seconds. The next four ranged from 0.0046 to 0.0044 seconds. Yes, 10 times faster then 1.8, and 100 times faster then JRuby. More amazing, the memory started at 6,303,744 bytes, <em>and did not move</em>. As the dimensions climbed, the RAM rose a bit to 6,377,472 bytes. At 60 dimensions it completed the task in a amazing 8.81176 seconds at best. That's a full two seconds faster then anyone else.
<strong>Final Thoughts</strong>
I think it's safe to say, look at moving your applications to Ruby 1.9. It appears that there are some very strong benefits to be gained by the move. You should also keep an eye on REE when they update it to run 1.9, as well as when Rubinus makes it out of the gate.
<strong><em>update</em><span style="font-weight: normal;"> - after some data normalization, I was able to cobble together these charts:</span></strong>

<p style="text-align: center;"><strong><span style="font-weight: normal;"><a href="https://greg.nokes.name/wp-content/uploads/2009/12/Screen-shot-2009-12-23-at-10.25.41-AM.png"><img class="size-medium wp-image-15215 aligncenter" title="Screen shot 2009-12-23 at 10.25.41 AM" src="https://greg.nokes.name/wp-content/uploads/2009/12/Screen-shot-2009-12-23-at-10.25.41-AM-300x193.png" alt="" width="300" height="193" /></a><a href="https://greg.nokes.name/wp-content/uploads/2009/12/Screen-shot-2009-12-23-at-10.25.49-AM.png"><img class="aligncenter size-medium wp-image-15216" title="Screen shot 2009-12-23 at 10.25.49 AM" src="https://greg.nokes.name/wp-content/uploads/2009/12/Screen-shot-2009-12-23-at-10.25.49-AM-300x201.png" alt="" width="300" height="201" /></a><a href="https://greg.nokes.name/wp-content/uploads/2009/12/Screen-shot-2009-12-23-at-10.25.56-AM.png"><img class="aligncenter size-medium wp-image-15217" title="Screen shot 2009-12-23 at 10.25.56 AM" src="https://greg.nokes.name/wp-content/uploads/2009/12/Screen-shot-2009-12-23-at-10.25.56-AM-300x182.png" alt="" width="300" height="182" /></a>

</span></strong></p>