#!/usr/bin/env bash

brew upgrade
heroku update
sfdx update
bundle update
git status
git add .
git commit -m "updating gems and stuff"
git commit --allow-empty -m "Trigger rebuild" 
git push origin master
heroku logs -t -a mysterious-depths-92606