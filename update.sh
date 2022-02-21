#!/usr/bin/env bash

# We want to stash the current branch, checkout master,
#  do our work on master, and then switch back to the 
#  original branch

# If you are already on master, it just complains 
#  and does not do anythiung


# Determine what branch we are on and save 
myvar=$(git rev-parse --abbrev-ref HEAD)
#save working state of current branch
git stash
#Switch to master
git checkout main
git pull origin main
#do the work
brew upgrade
gem update --system -N
heroku update
sfdx update
bundle update
git status
git add .
git commit -m "updating gems and stuff"
git commit --allow-empty -m "Trigger rebuild" 

for fn in `git remote`; do
	echo "processing remote $fn now"
    git push $fn main
done

git push origin main

#switch back to my working branch
git checkout $myvar
#restore the working state
git stash pop

#watch heroku rebuild the app
heroku logs -t -a mysterious-depths-92606