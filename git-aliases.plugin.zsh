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
alias cob='git checkout -b '
checkout() {
  git checkout "$1"
  git status
}
alias co='checkout'
cop() {
  git checkout "$1"
  pull
  git status
}
fp() {
  pull
  bundle install
  bundle exec rake db:migrate
}
cofp() {
  co "$1"
  fp
}
backmerge() {
  curr_branch=`git rev-parse --abbrev-ref HEAD`
  cofp master
  reset
  git checkout $curr_branch
  git merge origin/master -m 'Backmerged master'
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
    git clone $1
  else
    git clone git@github.com:$1/$2.git
    cd $2
  fi
}
