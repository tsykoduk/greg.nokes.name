#!/usr/bin/env bash

#Let's check to see if we need to do anything

# git the latest updates
git remote update

UPSTREAM=${1:-'@{u}'}
LOCAL=$(git rev-parse @)
REMOTE=$(git rev-parse "$UPSTREAM")
BASE=$(git merge-base @ "$UPSTREAM")

if [ $LOCAL = $REMOTE ]; then
    echo "Up-to-date, nothing to do"
elif [ $LOCAL = $BASE ]; then
    echo "Need to pull and update"
	#insure that rbenv is working
	eval "$(rbenv init -)"
	#let's set up the enviroment

	#git the latest updates
	rm Gemfile.lock # we should only use the upstream Gemfile - if the lock was overwritten, that could force us to not pull the latest
	git pull origin main

	# test for ruby version, install updated version if we are lagging
	expected_ruby=$(<.ruby-version) #this gives ex 3.1.2
	installed_ruby=$(rbenv local) 	#this gives the local ruby according to rbenv ex 3.1.2

	if [[ $expected_ruby == $installed_ruby ]]
	then
		echo "ruby good, pressing on"
	else
		echo "installing updated ruby"
		rbenv install $expected_ruby -s
		rbenv local $expected_ruby
		gem install bundler
	fi

	# fresh gems are good gems bundle update
	bundle update

	# generate the site, and move it into the hosting directory
	bundle exec jekyll build --verbose --destination ~/sites/greg.nokes.name/
else
    echo "Diverged"
fi


