---
id: 430
title: Scan and Copy Redux
date: 2007-06-13T23:43:00+00:00
author: tsykoduk
layout: post
guid: https://greg.nokes.name/?p=430
permalink: /2007/06/13/scan-and-copy-redux/
categories:
  - Computers! and Code!
description: "Updated Windows backup script with XP compatibility, command-line options for naming directories, target paths, and file extension filtering for system migration tasks."
---
<p>A co-worker pointed out that <a href="https://greg.nokes.name/2007/4/3/scan-and-copy/">Scan and Copy</a> did not work all that well on XP. Not a real issue, since I had used it to back up win2k machines in prep for a XP roll out. Well, anyways, I made the few changes to XP it, as well as adding in some more functionality.</p>

<!--more-->

<p>There are now 3 command line options</p>

<ul>
  <li><b>-name</b> Names the target directory, which will be created if it does not exist</li>
  <li><b>-target</b> Gives a target directory to place the backup folder in.</li>
  <li> A list of file extensions to look for</li>
</ul>

```ruby
#Stuff we need
require 'getoptlong'
require 'ftools'
 
#Get the command line options
#Required command lines
# --name 'user name'
# a list of extensions to search for
# -- target 'path'
# Target directory to put stuff into
 
@backed = 0
@collisions = 0
@totfiles = 0
@filetype = Array.new
 
opts = GetoptLong.new(
      ["--name", "-n", GetoptLong::REQUIRED_ARGUMENT],
      ["--target","-t",GetoptLong::OPTIONAL_ARGUMENT],
      ["--help","-h",GetoptLong::OPTIONAL_ARGUMENT])
 
#Parse the options, assigning them to the correct variables.
opts.each do |opt, arg|
  case opt
    when  "--name"
      @name = arg.to_s
    when "--target"
      @target = arg.to_s
    end
end
 
for ext in ARGV
  @filetype << ext
end
 
 
if @target.nil?
  @target = "y\:\\backups\\"
end
 
@path = @target + @name
 
#let's tell everyone what we are doing...
  puts ""
  puts "Copying to..."
  puts @path
  puts "Looking for..."
  puts @filetype
  puts ""
 
#Do basic checking to insure that everything we need is there
 
#need to improve logic here - 
  rescue if lower level directorys do not exist!
#Create base path if it does not exist?
 
unless File.exist?(@path)
    unless File.exist?(@target)
      Dir.mkdir(@target)
    end
      Dir.mkdir(@path)
end
 
  #Start main process of program
  Dir.chdir("c:\\")
  Dir['/**/**'].each do |item|
    @totfiles = @totfiles + 1
    unless(FileTest.directory?(item))
      if @filetype.include?(File.extname(item))
        if FileTest.exist?(@path + "\\" + File.basename(item))
          p = @path + "\\" + File.basename(item, ".*") + "_"+ 
            rand(100000000).to_s + "_" + File.extname(item)
          File.copy item, p
          printf("C")
          @collisions = @collisions + 1
          @backed = @backed + 1
          #Duplicate File Error.
        else
          p = @path + "\\" + File.basename(item)
          File.copy item, p
          #Backed up file
          printf("B")
          @backed = @backed + 1
        end
      else
        printf(".")
      end
    end
  end
 
 
puts ""
puts "Checked #{@totfiles} Files."
puts "#{@backed} Files backed up with #{@collisions} filename collisions"
```