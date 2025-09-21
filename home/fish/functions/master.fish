function master --wraps='git fetch -p && git checkout master && git rebase origin/master' --description 'alias master=git fetch -p && git checkout master && git rebase origin/master'
  git fetch -p && git checkout master && git rebase origin/master $argv
end
