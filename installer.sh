#!/usr/bin/env bash

#let's set up the enviroment


#git the latest updates

git pull origin main

# test for ruby version, install updated version if we are lagging

expected_ruby=$(<.ruby-version) #this gives ex 3.1.2
installed_ruby=$(rbenv local)

if [[ "$expected_ruby" == "$installed_ruby" ]]
then
	echo "ruby good, pressing on"
else
	echo "installing updated ruby"
	rbenv install $expected_ruby -s
	rbenv local $expected_ruby
fi


# fresh gems are good gems bundle update

bundle update

# generate the site, and move it into the hosting directory

bundle exec jekyll build --destination ~/sites/greg.nokes.name/