---
id: 2270
title: Scan and Copy
date: 2007-04-03T17:13:00+00:00
author: tsykoduk
layout: post
guid: 30/2008/12/27/scan-and-copy
permalink: /2007/04/03/scan-and-copy/
categories:
  - Computers! and Code!
---
<p>One of the ways I am able to exercise my Ruby skills is in the day to day network admin tasks. For example, I had to come up with a method of saving all of a users 'important' documents off of their desktop computer in preparation for a wipe and re-image. Not only that, but it's a good idea. So I wrote 'scan and copy'</p>

 <!--more-->

```ruby
#Stuff we need
require 'getoptlong'
require 'ftools'

#Get the command line options
#Required command lines
# --name 'user name'
# a list of extensions to search for

@backed = 0
@collisions = 0
@totfiles = 0
@filetype = Array.new

opts = GetoptLong.new(["--name", "-n", GetoptLong::REQUIRED_ARGUMENT])

#Parse the options, assigning them to the correct variables.
opts.each do |opt, arg|
  case opt
    when  "--name"
      @path = "y\:\\backups\\" + arg.to_s
    end
end

for ext in ARGV
  @filetype << ext
end


#let's tell everyone what we are doing...
  puts ""
  puts "Copying to..."
  puts @path
  puts "Looking for..."
  puts @filetype
  puts ""

#Do basic checking to insure that everything we need is there

unless File.exist?(@path)
  Dir.mkdir(@path)
end

  #Start main process of program
  Dir['/**/**'].each do |item|
    @totfiles = @totfiles + 1
    unless(FileTest.directory?(item))
      if @filetype.include?(File.extname(item))
        if FileTest.exist?(@path + "\\" + File.basename(item))
          p = @path + "\\" + File.basename(item, ".*") +
             "_"+ rand(100000000).to_s + "_" + File.extname(item)
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