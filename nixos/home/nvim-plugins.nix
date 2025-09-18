{pkgs, ...}: let
  inherit (pkgs) fetchFromGitHub;
  inherit (pkgs) vimUtils;
  inherit (pkgs) vimPlugins;

  build = {
    owner,
    repo,
    rev,
    hash,
    pname ? repo,
    commit_at ? builtins.substring 0 7 rev,
  }:
    vimUtils.buildVimPlugin {
      inherit pname;
      version = "git-${commit_at}";
      src = fetchFromGitHub {
        inherit owner repo rev hash;
      };
    };

  nvim-treesitter-full = vimPlugins.nvim-treesitter.withPlugins (
    p: [
      p.tree-sitter-astro
      p.tree-sitter-bash
      p.tree-sitter-c
      p.tree-sitter-clojure
      p.tree-sitter-cmake
      p.tree-sitter-comment
      p.tree-sitter-commonlisp
      p.tree-sitter-cpp
      p.tree-sitter-css
      p.tree-sitter-csv
      p.tree-sitter-diff
      p.tree-sitter-dockerfile
      p.tree-sitter-editorconfig
      p.tree-sitter-fish
      p.tree-sitter-git_config
      p.tree-sitter-git_rebase
      p.tree-sitter-gitattributes
      p.tree-sitter-gitcommit
      p.tree-sitter-gitignore
      p.tree-sitter-go
      p.tree-sitter-gpg
      p.tree-sitter-graphql
      p.tree-sitter-html
      p.tree-sitter-htmldjango
      p.tree-sitter-http
      p.tree-sitter-hyprlang
      p.tree-sitter-ini
      p.tree-sitter-java
      p.tree-sitter-javadoc
      p.tree-sitter-javascript
      p.tree-sitter-jq
      p.tree-sitter-jsdoc
      p.tree-sitter-json
      p.tree-sitter-json5
      p.tree-sitter-jsonc
      p.tree-sitter-liquid
      p.tree-sitter-llvm
      p.tree-sitter-lua
      p.tree-sitter-luadoc
      p.tree-sitter-make
      p.tree-sitter-markdown
      p.tree-sitter-markdown_inline
      p.tree-sitter-mermaid
      p.tree-sitter-nginx
      p.tree-sitter-ninja
      p.tree-sitter-nix
      p.tree-sitter-objc
      p.tree-sitter-objdump
      p.tree-sitter-passwd
      p.tree-sitter-pod
      p.tree-sitter-pymanifest
      p.tree-sitter-python
      p.tree-sitter-regex
      p.tree-sitter-requirements
      p.tree-sitter-robot
      p.tree-sitter-robots
      p.tree-sitter-ruby
      p.tree-sitter-rust
      p.tree-sitter-scss
      p.tree-sitter-sql
      p.tree-sitter-ssh_config
      p.tree-sitter-svelte
      p.tree-sitter-terraform
      p.tree-sitter-tmux
      p.tree-sitter-toml
      p.tree-sitter-tsx
      p.tree-sitter-twig
      p.tree-sitter-typescript
      p.tree-sitter-vue
      p.tree-sitter-xml
      p.tree-sitter-yaml
    ]
  );

  oxocarbon = build {
    owner = "nyoom-engineering";
    repo = "oxocarbon.nvim";
    rev = "9f85f6090322f39b11ae04a343d4eb9d12a86897";
    hash = "sha256-BZiFM/V0UDv1IyJ70w5U0TpFqCKS4pnnK8GqzUrYd5M=";
  };

  mini-nvim = build {
    owner = "nvim-mini";
    repo = "mini.nvim";
    rev = "48b924e4f3b37f62246873d237a4a89704d88948";
    hash = "sha256-zGIPVVNSN4Y3GiRivyioZUUfsLNKBfOVEjJL1l7eGkw=";
  };

  oil = build {
    owner = "stevearc";
    repo = "oil.nvim";
    rev = "07f80ad645895af849a597d1cac897059d89b686";
    hash = "sha256-/+/XtVN7J9xVRunzAb4sgE5Zb0YrkUU2rXSROG+dJpc=";
  };
in [
  nvim-treesitter-full
  oxocarbon
  mini-nvim
  oil
  vimPlugins.nvim-web-devicons
  vimPlugins.plenary-nvim
  vimPlugins.telescope-nvim
  vimPlugins.telescope-fzf-native-nvim
  vimPlugins.which-key-nvim
  vimPlugins.trouble-nvim
]
