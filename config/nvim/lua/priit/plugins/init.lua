return {
  {
    "blazkowolf/gruber-darker.nvim",
    lazy = false,
    priority = 1000,
    config = function()
      vim.cmd.colorscheme("gruber-darker")
      vim.api.nvim_set_hl(0, "Normal", { bg = "#181818" })
      vim.api.nvim_set_hl(0, "NormalFloat", { bg = "#181818" })
      vim.api.nvim_set_hl(0, "Comment", { fg = "#888888", italic = true })
    end,
  },
  { "nvim-lualine/lualine.nvim", opts = { options = { theme = "auto" } } },
  { "lewis6991/gitsigns.nvim", opts = {} },
  {
    "nvim-telescope/telescope.nvim",
    dependencies = { "nvim-lua/plenary.nvim" },
    cmd = "Telescope",
    keys = {
      { "<leader>ff", "<Cmd>Telescope find_files<CR>", desc = "Find files" },
      { "<leader>fg", "<Cmd>Telescope live_grep<CR>", desc = "Live grep" },
    },
    opts = {},
  },
  {
    "nvim-treesitter/nvim-treesitter",
    lazy = false,
    build = ":TSUpdate",
    config = function()
      local treesitter = require("nvim-treesitter")
      local languages = { "bash", "json", "lua", "markdown", "python", "toml", "yaml" }

      treesitter.setup({})
      treesitter.install(languages)
      vim.api.nvim_create_autocmd("FileType", {
        pattern = languages,
        callback = function(args)
          pcall(vim.treesitter.start, args.buf)
          vim.bo[args.buf].indentexpr = "v:lua.require'nvim-treesitter'.indentexpr()"
        end,
      })
    end,
  },
  { "folke/which-key.nvim", event = "VeryLazy", opts = {} },
  { "numToStr/Comment.nvim", opts = {} },
  { "windwp/nvim-autopairs", event = "InsertEnter", opts = {} },
}
