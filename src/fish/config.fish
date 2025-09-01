set -Ux LANG en_US.UTF-8
set -Ux ARCHFLAGS "-arch x86_64"

set -Ux PATH "/usr/lib/ccache/bin/:$PATH"
set -Ux MAKEFLAGS "-j33 -l32"

set -Ux PATH $HOME/.cargo/bin:$PATH

fish_add_path --append --path $HOME/.cargo/bin

alias park="paru -Syua"
alias parc="paru --clean"
alias dco="docker compose"
alias dlogs="docker compose logs --tail 100 -f"
alias gch="git submodule foreach"
alias n="nvim"
alias ns="nvim -S"
alias l="eza --icons -al"
alias ls="eza --icons -a"
alias master="git fetch -p && git checkout master && git rebase origin/master"
alias main="git fetch -p && git checkout main && git rebase origin/main"
alias cdk="pnpm dlx aws-cdk"
alias staging="git branch -D staging && git checkout -b staging && g push -u origin staging -f"
alias cs="xclip -selection clipboard"
alias g="git"
alias pem="pnpm"

alias aco="clear && RUSTFLAGS=\"-Awarnings\" cargo"
alias cun="aco run --"

set -Ux XDG_CONFIG_HOME "$HOME/.config"

###-tns-completion-start-###
#if [ -f /home/viktor/.tnsrc ]; then 
#    source /home/viktor/.tnsrc 
#fi
###-tns-completion-end-###

#export ANDROID_HOME="/home/viktor/Android/Sdk"
#export ANDROID_NDK_HOME="/home/viktor/Android/Sdk/ndk-bundle"
#export PATH=$PATH:$ANDROID_HOME/platform-tools
#export PATH="$HOME/.local/share/gem/ruby/3.0.0/bin/:$PATH"
#export PATH="$PATH:$HOME/code/my/dotfiles/scripts"

set -Ux EDITOR "nvim"

# pnpm
set -gx PNPM_HOME "/home/viktor/.local/share/pnpm"
if not string match -q -- $PNPM_HOME $PATH
  set -gx PATH "$PNPM_HOME" $PATH
end
# pnpm end

# Add CUDA to PATH and LD_LIBRARY_PATH
set -gx PATH /opt/cuda/bin $PATH
set -gx LD_LIBRARY_PATH /opt/cuda/lib64 $LD_LIBRARY_PATH
