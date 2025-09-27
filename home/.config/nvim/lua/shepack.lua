--- @param src string
--- @param commit string
local function add(src, commit)
  return { src = src, version = commit }
end

vim.pack.add({
  add("https://github.com/nvim-treesitter/nvim-treesitter", "5a70b1eb8cbdf6c7f0a59dfb7356ad198421b620"),

  add("https://github.com/nyoom-engineering/oxocarbon.nvim", "9f85f6090322f39b11ae04a343d4eb9d12a86897"),
  add("https://github.com/HiPhish/rainbow-delimiters.nvim", "687ef75fdbd497eabc9eea92b52e7b4d403b3319"),
  add("https://github.com/nvim-lualine/lualine.nvim", "b8c23159c0161f4b89196f74ee3a6d02cdc3a955"),

  add("https://github.com/nvim-telescope/telescope.nvim", "b4da76be54691e854d3e0e02c36b0245f945c2c7"),
  add("https://github.com/nvim-telescope/telescope-fzf-native.nvim", "1f08ed60cafc8f6168b72b80be2b2ea149813e55"),
  add("https://github.com/debugloop/telescope-undo.nvim", "928d0c2dc9606e01e2cc547196f48d2eaecf58e5"),

  add("https://github.com/lewis6991/gitsigns.nvim", "f780609807eca1f783a36a8a31c30a48fbe150c5"),
  add("https://github.com/catgoose/nvim-colorizer.lua", "51cf7c995ed1eb6642aecf19067ee634fa1b6ba2"),
  add("https://github.com/kylechui/nvim-surround", "a868c256c861044beb9794b4dd126480dcdfbdad"),
  add("https://github.com/nvim-mini/mini.nvim", "80a11490e44a7fe8c911a3b4a827c56df3894058"),
  add("https://github.com/folke/flash.nvim", "b68bda044d68e4026c4e1ec6df3c5afd7eb8e341"),
  add("https://github.com/ThePrimeagen/harpoon", "ed1f853847ffd04b2b61c314865665e1dadf22c7"),
  add("https://github.com/stevearc/oil.nvim", "07f80ad645895af849a597d1cac897059d89b686"),
  add("https://github.com/folke/which-key.nvim", "370ec46f710e058c9c1646273e6b225acf47cbed"),
  add("https://github.com/stevearc/conform.nvim", "b4aab989db276993ea5dcb78872be494ce546521"),
  add("https://github.com/folke/trouble.nvim", "f176232e7759c4f8abd923c21e3e5a5c76cd6837"),
  add("https://github.com/saecki/crates.nvim", "ac9fa498a9edb96dc3056724ff69d5f40b898453"),

  add("https://github.com/hrsh7th/nvim-cmp", "b5311ab3ed9c846b585c0c15b7559be131ec4be9"),
  add("https://github.com/hrsh7th/cmp-path", "c642487086dbd9a93160e1679a1327be111cbc25"),
  add("https://github.com/hrsh7th/cmp-buffer", "b74fab3656eea9de20a9b8116afa3cfc4ec09657"),
  add("https://github.com/hrsh7th/cmp-nvim-lsp", "bd5a7d6db125d4654b50eeae9f5217f24bb22fd3"),

  add("https://github.com/nvim-tree/nvim-web-devicons", "6e51ca170563330e063720449c21f43e27ca0bc1"),
  add("https://github.com/nvim-lua/plenary.nvim", "b9fd5226c2f76c951fc8ed5923d85e4de065e509"),
})
