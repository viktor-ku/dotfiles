local spec = require("shepack-utils")

spec.one("plenary")
spec.one("nvim-web-devicons")

spec.mod("telescope")
spec.mod("mini")

spec.one("cmp")
spec.one("crates")
spec.one("formatting")
spec.one("gitsigns")
spec.one("harpoon")
spec.one("hop")
spec.one("lualine")
spec.one("oil")
spec.one("rainbow-delimiters")
spec.one("theme")
spec.one("treesitter")
spec.one("trouble")
spec.one("which-key")

require("pckr").add(spec.plugins())
