#!/bin/sh
# extractSubproject <orignal repopath> <new repopath> <subfolder> <new remote (optional)>

# clone repository
git clone --no-hardlinks $1 $2

# extract subproject
cd $2
git filter-branch --subdirectory-filter $3 HEAD
git reset --hard
git remote rm origin
rm -r .git/refs/original/
git reflog expire --expire=now --all
git gc --aggressive
git prune

# Add optional remote and push
if [ "$4" != "" ]; then
  git remote add origin $4
  git push origin master
fi
