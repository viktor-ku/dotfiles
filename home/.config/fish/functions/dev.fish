function dev
  git fetch -p && git checkout dev && git rebase origin/dev $argv
end
