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
if command -v brew &> /dev/null
then
  brew upgrade
else
  echo -e "\033[34m Brew not installed  \033[0;39m\n"
fi

if command -v heroku &> /dev/null
then
  heroku update
else
  echo -e "\033[34m Heroku CLI not installed  \033[0;39m\n"
fi

if command -v sfdx &> /dev/null
then
  sfdx update
else
  echo -e "\033[34m Salesforce CLI not installed  \033[0;39m\n"
fi

gem update --system -N

bundle update
git status
git add .
git commit -m "updating gems and stuff"
git commit --allow-empty -m "Trigger rebuild" 

for fn in `git remote`; do
	echo -e "\033[34m processing remote $fn now \033[0;39m\n"
    git push $fn main
done

git push origin main

#switch back to my working branch
git checkout $myvar
#restore the working state
git stash pop

#watch heroku rebuild the app

if command -v heroku &> /dev/null
then
  heroku logs -t -a mysterious-depths-92606
else
  echo -e "\033[34m Heroku CLI not installed  \033[0;39m\n"
fi
