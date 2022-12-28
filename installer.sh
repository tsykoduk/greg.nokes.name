#!/usr/bin/env bash

#Let's check to see if we need to do anything

# git the latest updates
git remote update

git_remote=${1:-'@{u}'}
local=$(git rev-parse @)
remote=$(git rev-parse "$git_remote")
base=$(git merge-base @ "$git_remote")

if [[ $local = $remote ]] 
then
    echo "Up-to-date, nothing to do"
elif [[ $local = $base ]] 
then
    echo "Need to pull and update"
	#insure that rbenv is working
	eval "$(rbenv init -)"
	#let's set up the enviroment

	#git the latest updates
	rm Gemfile.lock # we should only use the upstream Gemfile - if the lock was overwritten, that could force us to not pull the latest
	git pull origin main

	# test for ruby version, install updated version if we are lagging
	#ruby-version file may not be up to date. better to parse the Gemfile.lock
	#expected_ruby=$(<.ruby-version) #this gives ex 3.1.2
	expected_ruby=$(cat Gemfile |grep "ruby \"~>"|sed 's\ruby "~>\\'| sed 's/.$//') #this gives ex 3.1.2
	installed_ruby=$(rbenv local) 	#this gives the local ruby according to rbenv ex 3.1.2

	if [[ $expected_ruby == $installed_ruby ]]
	then
		echo "ruby good, pressing on"
	else
		echo "installing updated ruby"
		if rbenv install $expected_ruby -s
		then
			rbenv local $expected_ruby
			#make sure bundle is updated
			gem install bundler
		else
			# what if rbenv does not support this version of ruby??
			echo "Woops, that version of ruby did not install"
			#bail out
			exit 1
		fi
	fi

	# fresh gems are good gems bundle update
	bundle update
	bundle clean

	# generate the site, and move it into the hosting directory
	bundle exec jekyll build --verbose --destination ~/sites/greg.nokes.name/
else
    echo "Something went well and truly wrong"
fi


