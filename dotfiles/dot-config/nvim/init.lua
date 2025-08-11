-- Sets up leader key.
vim.g.mapleader = " "
vim.g.maplocalleader = " "

-- Improves navigation.
vim.opt.number = true
vim.opt.relativenumber = true
vim.opt.cursorline = true
vim.opt.cursorcolumn = true
vim.keymap.set("n", "<C-h>", "<C-w><C-h>")
vim.keymap.set("n", "<C-l>", "<C-w><C-l>")
vim.keymap.set("n", "<C-j>", "<C-w><C-j>")
vim.keymap.set("n", "<C-k>", "<C-w><C-k>")

-- Improves aesthetics.
vim.opt.signcolumn = "yes"
vim.cmd([[highlight Normal guibg=none]])
vim.opt.tabstop = 4
vim.opt.list = true
vim.opt.listchars = { tab = "> ", trail = "-" }

-- Switches to system clipboad.
vim.opt.clipboard = "unnamedplus"

-- Sets up plugins.
vim.pack.add({
    "https://github.com/tpope/vim-sleuth",
    "https://github.com/tpope/vim-fugitive",
    "https://github.com/lewis6991/gitsigns.nvim",
    "https://github.com/nvim-neo-tree/neo-tree.nvim",
    "https://github.com/nvim-lua/plenary.nvim",
    "https://github.com/MunifTanjim/nui.nvim",
    "https://github.com/neovim/nvim-lspconfig",
})

-- Sets up some shortcuts.
vim.keymap.set("n", "<Esc>", ":noh<LF><Esc>")
vim.keymap.set("n", "<Leader>d", ":lua vim.diagnostic.open_float()<LF>")
vim.keymap.set("n", "<Leader>e", ":Neotree toggle right<LF>")
vim.keymap.set("n", "<Leader>t", ":terminal<LF>")
vim.keymap.set("n", "<Leader>c", ":bd<LF>")
