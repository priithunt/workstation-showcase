local opt = vim.opt

opt.number = true
opt.relativenumber = true
opt.cursorline = true
opt.signcolumn = "yes"

opt.tabstop = 4
opt.shiftwidth = 4
opt.expandtab = true
opt.autoindent = true

opt.wrap = false
opt.scrolloff = 5
opt.ignorecase = true
opt.smartcase = true

opt.termguicolors = true
opt.background = "dark"
opt.splitright = true
opt.splitbelow = true

opt.clipboard:append("unnamedplus")
opt.swapfile = false
opt.undofile = true
opt.updatetime = 300
