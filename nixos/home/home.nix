{
  inputs,
  pkgs,
  ...
}: {
  programs.home-manager.enable = true;

  home = {
    stateVersion = "25.05";
    username = "victoria";
    homeDirectory = "/home/victoria";

    pointerCursor = {
      gtk.enable = true;
      package = pkgs.bibata-cursors;
      name = "Bibata-Modern-Classic";
      size = 16;
    };

    packages = with pkgs; [
      # tiny (but size does not matter, right?) tools
      ripgrep
      fd
      fzf
      tree-sitter
      tmux
      inputs.swww.packages.${pkgs.system}.swww
      eza
      autojump
      playerctl
      nerd-fonts._0xproto

      # adult tools
      rustup
      nodejs_24
      python313
      dbeaver-bin

      pnpm

      # comms
      telegram-desktop
      slack

      # my favourite browsers :3 (all of them suck)
      brave
      google-chrome

      # toys
      spotify

      # LSPs
      nil
      pyright
      lua-language-server

      # Formatters / linters
      alejandra
      ruff
      stylua
    ];
  };

  programs.autojump = {
    enable = true;
    enableFishIntegration = true;
  };

  programs.neovim = {
    enable = true;
    plugins = (import ./nvim-plugins.nix) {inherit pkgs;};
  };

  home.file = {
    ".config/nvim" = {
      source = ./.config/nvim;
    };

    ".config/fish/functions/fish_prompt.fish" = {
      source = ./.config/fish/functions/fish_prompt.fish;
    };

    ".config/kitty/oxocarbon.conf" = {
      source = ./.config/kitty/oxocarbon.conf;
    };
  };

  programs.fish = {
    enable = true;

    shellAliases = {
      n = "nvim";
      ns = "nvim -S";
      g = "git";
      l = "eza -lah";
      ll = "eza -lah";
      ls = "eza";
      up = "sudo nixos-rebuild switch --flake /etc/nixos";
    };

    functions = {
      # functions
    };
  };

  programs.eza = {
    enable = true;
    enableFishIntegration = true;
  };

  programs.tmux = {
    enable = true;

    prefix = "C-b";

    terminal = "tmux-256color";

    extraConfig = ''
      set  -g base-index      0
      setw -g pane-base-index 0

      set -g status-keys vi
      set -g mode-keys   vi

      set  -g mouse             off
      setw -g aggressive-resize off
      setw -g clock-mode-style  12

      # make delay shorter
      set -sg escape-time 0

      set-option -g history-limit 10000
      set-option -g focus-events on

      # Oxocarbon-style tmux theme
      set -g status on
      set -g status-justify centre
      set -g status-interval 2

      # Colors from Oxocarbon Dark
      set -g status-bg '#161616'
      set -g status-fg '#f2f4f8'

      # Left and right status
      set -g status-left '#[fg=#33b1ff,bg=#161616,bold] #S #[fg=#161616,bg=#161616,nobold,nounderscore,noitalics]'
      set -g status-left-length 60

      set -g status-right '#[fg=#f2f4f8]#(~/Code/My/cpuprincess/target/release/cpuprincess)'
      set -g status-right-length 60

      # Active window title
      set-window-option -g window-status-current-style 'fg=#161616,bg=#33b1ff,bold'
      set-window-option -g window-status-current-format ' #I:#W '

      # Inactive windows
      set-window-option -g window-status-style 'fg=#525252,bg=#161616'
      set-window-option -g window-status-format ' #I:#W '

      # Pane border
      set-option -g pane-border-style 'fg=#393939'
      set-option -g pane-active-border-style 'fg=#33b1ff'

      # Message style
      set-option -g message-style 'bg=#161616,fg=#f2f4f8'

      # Command prompt
      set-option -g message-command-style 'bg=#161616,fg=#33b1ff'

      # Mode style (e.g. copy mode)
      set -g mode-style 'bg=#393939,fg=#ffffff'
    '';
  };

  programs.git = {
    enable = true;
    userEmail = "viktor@ku.family";
    userName = "Viktor Kuroljov";
    delta = {
      enable = true;
      options = {
        decorations = {
          commit-decoration-style = "bold yellow box ul";
          file-decoration-style = "none";
          file-style = "bold yellow ul";
        };
        features = "decorations";
        whitespace-error-style = "22 reverse";
      };
    };
    aliases = {
      s = "status";
      ch = "checkout";
      cm = "commit";
      b = "branch";
      lg = "log --oneline --all --decorate --graph";
      pp = "push";
      diffc = "diff --cached";
      pum = "push --set-upstream origin main";
      mr = "push --set-upstream origin HEAD";
    };
    extraConfig = {
      push = {
        default = "simple";
      };
      color = {
        ui = "auto";
        interactive = "auto";
      };
      rerere = {
        enabled = true;
      };
      init = {
        defaultBranch = "main";
      };
      core = {
        editor = "nvim";
        whitespace = "trailing-space,space-before-tab";
      };
    };
  };

  programs.kitty = {
    enable = true;
    enableGitIntegration = true;
    settings = {
      font_size = 16;
      modify_font = "cell_height +8px";
      input_delay = 0;
      repaint_delay = 6;
      sync_to_monitor = "no";
      wayland_enable_ime = "no";
      enable_audio_bell = "no";
      update_check_interval = 0;
      window_border_width = 0;
      draw_minimal_borders = "no";
      hide_window_decorations = "yes";
      window_padding_width = "8 30 4 30";
      single_window_padding_width = -1;
      cursor_trail = 6;
      cursor_trail_decay = "0.09 0.18";
      allow_remote_control = "no";
      listen_on = "none";
      background_opacity = 0.96;
    };
    extraConfig = ''
      font_family family="0xProto Nerd Font Mono"
      font_bold auto
      italic_font auto
      bold_italic_font auto

      include oxocarbon.conf
    '';
  };

  programs.fuzzel = {
    enable = true;
    settings.main = {};
  };

  wayland.windowManager.hyprland = {
    enable = true;

    package = inputs.hyprland.packages.${pkgs.stdenv.hostPlatform.system}.hyprland;
    portalPackage = inputs.hyprland.packages.${pkgs.stdenv.hostPlatform.system}.xdg-desktop-portal-hyprland;

    plugins = with inputs.hyprland-plugins.packages.${pkgs.stdenv.hostPlatform.system}; [
      #
    ];

    settings = {
      "$mod" = "SUPER";
      "$terminal" = "kitty";
      "$menu" = "fuzzel";
      general = {
        gaps_in = 16;
        gaps_out = 32;
        border_size = 0;
      };
      plugin = {
        #
      };
      monitor = [
        "DP-1,2560x1440@165,0x0,1,vrr,0"
      ];
      exec-once = [
        "dunst"
        "swww-daemon"
        "swww img ~/Pictures/Wallpaper/1.png"
      ];
      misc = {
        vfr = false;
      };
      input = {
        natural_scroll = true;
        sensitivity = -0.5;
        kb_layout = "us,ru";
        kb_variant = "";
        kb_options = "grp:ctrl_alt_toggle";
      };
      env = [
        "NIXOS_OZONE_WL,1"
        "MOZ_ENABLE_WAYLAND,1"
      ];
      bind =
        [
          "$mod SHIFT, Return, exec, $terminal"
          "$mod SHIFT, Q, exec, hyprctl dispatch exit"
          "$mod, P, exec, $menu"
          "$mod, TAB, workspace, previous"

          # Media keys -> Spotify only (fallback to any player if Spotify not running by appending ,%any)
          ", XF86AudioPlay, exec, playerctl --player=spotify play-pause"
          ", XF86AudioNext, exec, playerctl --player=spotify next"
          ", XF86AudioPrev, exec, playerctl --player=spotify previous"
        ]
        ++ (
          # workspaces
          # binds $mod + [shift +] {1..9} to [move to] workspace {1..9}
          builtins.concatLists (builtins.genList (
              i: let
                ws = i + 1;
              in [
                "$mod, code:1${toString i}, workspace, ${toString ws}"
                "$mod SHIFT, code:1${toString i}, movetoworkspace, ${toString ws}"
              ]
            )
            9)
        );
    };
  };

  gtk.enable = true;
  qt.enable = true;
  qt.platformTheme.name = "gtk";
}
