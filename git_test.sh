#!/bin/bash

git remote update &> /dev/null
git status -uno | grep -i "Your branch is behind 'origin/main'"  &> /dev/null

if [ $? -eq 0 ]; then
  read -p "there has been changes in master barnch do you want to git pull: " yes
  if [[ $yes == yes ]] || [[ $yes == y ]] || [[ $yes == Y ]]; then
    git pull
    echo "Your local branch is up to date with origin/master now"
  else
    echo "Skipping git pull, your local branch is not up to date with master branch"
  fi
elif [ $? -eq 1 ]; then
  echo "You branch is up to date. No need for 'git pull'"
fi
