final: prev: let
  pin = base: {
    owner,
    repo,
    rev,
    hash,
    commit_at,
  }:
    builtins.trace ">>> overlay: pin ${owner}/${repo}@${builtins.substring 0 7 rev}"
    base.overrideAttrs (old: {
      src = prev.fetchFromGitHub {
        inherit owner repo rev hash;
      };
      version = "git-${commit_at}";
    });

  pin-nvim = base: {
    owner,
    repo,
    rev,
    hash,
    commit_at,
  }:
    builtins.trace ">>> overlay: pin-nvim ${owner}/${repo}@${builtins.substring 0 7 rev}"
    base.overrideAttrs (old: {
      src = prev.fetchFromGitHub {
        inherit owner repo rev hash;
      };
      version = "git-${commit_at}";
      doCheck = false;
      doInstallCheck = false;
    });
in {
  neovim-unwrapped = pin-nvim prev.neovim-unwrapped {
    owner = "neovim";
    repo = "neovim";
    rev = "ff777f9a858a5f360e220596c63bc69e19a1d5c1";
    commit_at = "2025-09-16";
    hash = "sha256-/goaMQ1EH2mmDJnUVEovY9tRelM2kXdJq2w5tx9MOKc=";
  };

  vimPlugins =
    prev.vimPlugins
    // {
      nvim-treesitter = pin prev.vimPlugins.nvim-treesitter {
        owner = "nvim-treesitter";
        repo = "nvim-treesitter";
        rev = "7aa24acae3a288e442e06928171f360bbdf75ba4d";
        commit_at = "2025-09-14";
        hash = "";
      };

      plenary-nvim = pin prev.vimPlugins.plenary-nvim {
        owner = "nvim-lua";
        repo = "plenary.nvim";
        rev = "b9fd5226c2f76c951fc8ed5923d85e4de065e509";
        commit_at = "2025-07-27";
        hash = "sha256-9Un7ekhBxcnmFE1xjCCFTZ7eqIbmXvQexpnhduAg4M0=!";
      };

      nvim-web-devicons = pin prev.vimPlugins.nvim-web-devicons {
        owner = "nvim-tree";
        repo = "nvim-web-devicons";
        rev = "6e51ca170563330e063720449c21f43e27ca0bc1";
        commit_at = "2025-09-04";
        hash = "sha256-2Q6ZZQj5HFXTw1YwX3ibdGOTwfbfPUBbcPOsuBUpSjc=";
      };

      telescope-nvim = pin prev.vimPlugins.telescope-nvim {
        owner = "nvim-telescope";
        repo = "telescope.nvim";
        rev = "b4da76be54691e854d3e0e02c36b0245f945c2c7";
        commit_at = "2025-05-12";
        hash = "sha256-JpW0ehsX81yVbKNzrYOe1hdgVMs6oaaxMLH6lECnOJg=";
      };

      telescope-fzf-native-nvim = pin prev.vimPlugins.telescope-fzf-native-nvim {
        owner = "nvim-telescope";
        repo = "telescope-fzf-native.nvim";
        rev = "1f08ed60cafc8f6168b72b80be2b2ea149813e55";
        commit_at = "2025-03-12";
        hash = "sha256-Zyv8ikxdwoUiDD0zsqLzfhBVOm/nKyJdZpndxXEB6ow=";
      };

      which-key-nvim = pin prev.vimPlugins.which-key-nvim {
        owner = "folke";
        repo = "which-key.nvim";
        rev = "370ec46f710e058c9c1646273e6b225acf47cbed";
        commit_at = "2025-02-22";
        hash = "sha256-uvMcSduMr7Kd2oUmIOYzvWF4FIl6bZxIYm9FSw/3pCo=";
      };

      trouble-nvim = pin prev.vimPlugins.trouble-nvim {
        owner = "folke";
        repo = "trouble.nvim";
        rev = "3fb3bd737be8866e5f3a170abc70b4da8b5dd45a";
        commit_at = "2025-09-15";
        hash = "sha256-W6iO5f+q4busBuP0psE7sikn87wwc1BkztsMnVkjnW0=";
      };
    };
}
