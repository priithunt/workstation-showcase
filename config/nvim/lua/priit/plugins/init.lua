return {
  { "folke/tokyonight.nvim", priority = 1000 },
  { "nvim-lualine/lualine.nvim" },
  { "lewis6991/gitsigns.nvim" },
  { "nvim-telescope/telescope.nvim", dependencies = { "nvim-lua/plenary.nvim" } },
  { "nvim-treesitter/nvim-treesitter", build = ":TSUpdate" },
  { "folke/which-key.nvim", event = "VeryLazy" },
  { "numToStr/Comment.nvim", opts = {} },
  { "windwp/nvim-autopairs", event = "InsertEnter", opts = {} },
}
