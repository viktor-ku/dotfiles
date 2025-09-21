function main --wraps='git fetch -p && git checkout main && git rebase origin/main' --description 'alias main=git fetch -p && git checkout main && git rebase origin/main'
  git fetch -p && git checkout main && git rebase origin/main $argv
end
