pull_or_push() {
  if [ $# -eq 2 ]; then
    git $1 $2 `git rev-parse --abbrev-ref HEAD`
  else
    git $1 origin `git rev-parse --abbrev-ref HEAD`
  fi
}
pull() { pull_or_push "pull" $@ }
push() { pull_or_push "push" $@ }

alias s='git status'
alias gf='git fetch'
alias gb='git branch'
alias reset='git reset --hard'
co() {
  git checkout "$1"
  if [ "$GIT_ALIASES_SILENCE_GIT_STATUS" -ne 1 ]; then; git status; fi
}
compdef _git co=git-checkout
cob() {
  git checkout -b "$1"
  if [ "$GIT_ALIASES_AUTOPUSH_NEW_BRANCH" -eq 1 ]; then
    git add "$(git rev-parse --show-toplevel)"
    git commit -a -m "Started $1"
    push
  fi
}
cobm() {
  git checkout master
  pull
  git checkout -b "$1"
}
cop() {
  git checkout "$1"
  pull
  git fetch
  if [ "$GIT_ALIASES_SILENCE_GIT_STATUS" -ne 1 ]; then; git status; fi
}
compdef _git cop=git-checkout
rp() {
  pull
  git fetch
  bundle install
  bundle exec rake db:migrate
  bundle exec rake db:test:prepare
}
corp() {
  co "$1"
  rp
}
compdef _git corp=git-checkout
backmerge() {
  local curr_branch=`git rev-parse --abbrev-ref HEAD`
  cop master
  co $curr_branch
  git merge origin/master -m 'Backmerged master'
  push
  echo 'Backmerge completed.'
}
ruby_backmerge() {
  local curr_branch=`git rev-parse --abbrev-ref HEAD`
  corp master
  reset
  co $curr_branch
  git merge origin/master -m 'Backmerged master'
  push
  echo 'Backmerge completed.  You may have to restart your local server.'
}
dif() {
  git diff
  git status
}
prune() {
  git branch -d "$1"
  git push origin --delete "$1"
}
clone() {
  if [[ -z $2 ]]; then
    local repo_name=$1
    while [ "${repo_name%%/*}" != "$repo_name" ]; do
       repo_name=${repo_name#*/}
    done
    repo_name=${repo_name%.*}
    git clone $1
    cd $repo_name
  else
    git clone git@github.com:$1/$2.git
    cd $2
  fi
}
