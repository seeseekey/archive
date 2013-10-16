#!/bin/sh
# moves a folder from one git repository to another
# moveFolder <absolute repository one path> <repository one folder> <absolute repository two path>

# prepare repository one
cd $1
git clean -f -d -x
git checkout -b tmpBranch
git filter-branch --subdirectory-filter $2 HEAD
mkdir $2
mv * $2
git add .
git commit -a -m "Move files into folder"

#import in repository two
cd $3
git remote add repositoryOne $1
git pull repositoryOne tmpBranch
git remote rm repositoryOne

#cleanup
cd $1
git checkout master
git branch -D tmpBranch

#remove folder with history from repository one
cd $1
git filter-branch -f --index-filter "git rm -rf --cached --ignore-unmatch $2" HEAD