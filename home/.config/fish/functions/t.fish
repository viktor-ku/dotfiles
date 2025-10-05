function t
  if test -z "$TMUX"
    # 🏠 If we're not inside tmux, start a new session in home (or a custom dir)
    tmux new -c "$HOME" $argv
  else
    # 📦 Already inside tmux → open a new window in home, with args if any
    tmux new-window -c "$HOME" $argv
  end
end
