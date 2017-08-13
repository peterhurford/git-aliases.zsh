pull_or_push() {
  if [ $# -eq 2 ]; then
    git $1 $2 `git rev-parse --abbrev-ref HEAD`
  else
    git $1 origin `git rev-parse --abbrev-ref HEAD`
  fi
}
pull() { pull_or_push "pull" $@ }
push() { pull_or_push "push" $@ }

alias gf='git fetch'
alias gb='git branch'
alias unmerged="git branch --no-merged"
alias plog="git log --oneline --decorate"

reset() {
  if [ $# -eq 0 ]; then
    git reset --hard
  else
    local curr_branch=`git rev-parse --abbrev-ref HEAD`
    git checkout $curr_branch $1
  fi
}

flog() {
  git log -p $1
}

status() {
  if [ "$GIT_ALIASES_SHORTER_GIT_STATUS" -ne 1 ]; then; git status
  else; git status -sb; fi
}
alias s='status'

co() {
  git fetch
  git checkout "$1"
  if [ "$GIT_ALIASES_SILENCE_GIT_STATUS" -ne 1 ]; then; git status; fi
}
compdef _git co=git-checkout

cob() {
  git checkout -b "$1"
  if [ "$GIT_ALIASES_AUTOPUSH_NEW_BRANCH" -eq 1 ]; then
    git add "$(git rev-parse --show-toplevel)" && git commit -a -m "Started $1" && push
  fi
}

cobm() {
  git checkout master && pull && git checkout -b "$1"
}

cobd() {
  git checkout dev && pull && git checkout -b "$1"
}

corbm() {
  corp master && git checkout -b "$1"
}

corbd() {
  corp dev && git checkout -b "$1"
}

cop() {
  git fetch && git checkout "$1" && pull && git fetch
  if [ "$GIT_ALIASES_SILENCE_GIT_STATUS" -ne 1 ]; then; git status; fi
}
compdef _git cop=git-checkout


rp() {
  pull && git fetch && rb
}

rb() {
  bundle install && bundle exec rake db:migrate && bundle exec rake db:test:prepare && bundle exec rake db:seed
}

corp() {
  co "$1" && rp
}
compdef _git corp=git-checkout


backmerge_branch() {
  local curr_branch=`git rev-parse --abbrev-ref HEAD`
  pull && cop $1 && co $curr_branch && git merge $1 -m 'Backmerged master' && push
  echo 'Backmerge completed.'
}

backmerge() {
  backmerge_branch 'master'
}

backmerge_dev() {
  backmerge_branch 'dev'
}

ruby_backmerge() {
  local curr_branch=`git rev-parse --abbrev-ref HEAD`
  pull && corp master && reset && co $curr_branch && git merge origin/master -m 'Backmerged master' && push
  echo 'Backmerge completed.  You may have to restart your local server.'
}

backmerge_all() {
  git fetch
  local curr_branch=`git rev-parse --abbrev-ref HEAD`
  for branch in $(git for-each-ref --format='%(refname)' refs/heads/); do
    local branch=${branch/refs\/heads\//}
    echo "!!! Backmerging $branch ..."
    cop master
    co $branch && git merge origin/master -m 'Backmerged master' && push
  done 
  co curr_branch
}


release() {
  if [ $# -eq 0 ]; then echo "You must pass a tag to release.";
  else cop master && git tag $1 && git push origin $1;
  fi
}


deploy() {
  if [ -f 'bin/deploy' ]; then bin/deploy; else; git push heroku master; fi
}
alias deproy=deploy


dif() {
  if [ "$GIT_ALIASES_ICDIFF" -eq 1 ]; then; git icdiff
  elif [ "$GIT_ALIASES_ICDIFF" -eq 2 ]; then; git difftool --extcmd icdiff
  else; git diff; fi
  git status
}


prune() {
  git branch -D "$1" && git push origin --delete "$1"
}


clone() {
  local yes_cd=true
  while getopts "d:" OPTION
  do
    case $OPTION in
      d)
        local yes_cd=false
        shift
        ;;
    esac
  done
  if [[ -z $2 ]]; then
    local repo_name=$1
    while [ "${repo_name%%/*}" != "$repo_name" ]; do
       repo_name=${repo_name#*/}
    done
    repo_name=${repo_name%.*}
    git clone $1
    if $yes_cd; then; cd $repo_name; fi
  else
    if [[ $# -eq 3 ]]; then
      git clone git@github.com:$1/$2.git $3
      if $yes_cd; then; cd $3; fi
    else
      git clone git@github.com:$1/$2.git
      if $yes_cd; then; cd $2; fi
    fi
  fi
}


oldbranches() {
  if [[ $# -eq 0 ]]; then; local hed=10; else; local hed=$1; fi
  echo $hed
  echo $#
  git for-each-ref --sort=committerdate --format='No updates to %(refname:short) since %(committerdate:short)...' | head -n $hed
}
