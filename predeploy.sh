#!/bin/bash

# based on https://gist.github.com/bewest/6100033
# travis encrypt --add -r user-org-name/repo-name 'GIT_NAME="Your Committer Name [via travis key]" GIT_EMAIL=committer@example.com GH_TOKEN=ahead0fxxxxxxxxxxxxxxxxxxx'


echo "BUMP HELLO WORLD set up $GH_REPO [via travis] for $GIT_NAME <${GIT_EMAIL}>"
export REPO_URL="https://$GH_TOKEN@github.com/$GH_REPO.git"
git config --global user.email "$GIT_EMAIL"
git config --global user.name "$GIT_NAME"
git branch -a
echo "STATUS"
git status
git remote rename origin old
echo "remotes pre pre-authorized remote url"
git remote -v
git remote add origin $REPO_URL
git config remote.origin.url $REPO_URL

echo "DEBUG, cd out"
test -d out && (
  cd out
  echo -n "user.email"
  git config user.email
  echo -n "user.name"
  git config user.name

) || echo "fresh build, no out directory"

export PATH=$TRAVIS_BUILD_DIR/node_modules/.bin:$PATH