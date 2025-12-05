set -gx XDG_CONFIG_HOME $HOME/.config
set -gx XDG_DATA_HOME $HOME/.local/share
set -gx XDG_CACHE_HOME $HOME/.cache

fish_add_path --append --path $HOME/.cargo/bin
fish_add_path --append --path $HOME/.local/bin

set -gx ANDROID_HOME $HOME/Android/Sdk
fish_add_path --append --path $ANDROID_HOME/emulator
fish_add_path --append --path $ANDROID_HOME/platform-tools
fish_add_path --append --path $ANDROID_HOME/tools

if type -q zoxide
  zoxide init fish --cmd j | source
end

fish_add_path --append --path $HOME/.docker/bin
