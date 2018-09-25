#!/usr/bin/env bash

brew upgrade
heroku update
bundle update
git status
git add .
git commit -m "updating gems and stuff"
git push origin master
