#!/usr/bin/env bash

brew upgrade
bundle update
git status
git add .
git commit -m "updating gems and stuff"
git push origin master
