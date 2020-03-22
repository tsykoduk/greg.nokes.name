#!/usr/bin/env bash

# We want to stash the current branch, checkout master,
#  do our work on master, and then switch back to the original branch

myvar=$(git rev-parse --abbrev-ref HEAD)
git checkout master
brew upgrade
heroku update
sfdx update
bundle update
git status
git add .
git commit -m "updating gems and stuff"
git commit --allow-empty -m "Trigger rebuild" 
git push origin master
git checkout $myvar
heroku logs -t -a mysterious-depths-92606
