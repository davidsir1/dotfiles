vim.cmd.colorscheme("gruvbox")
vim.cmd("syntax on")
vim.cmd("set guicursor=")
vim.cmd("set clipboard+=unnamedplus")

if vim.fn.exists('+termguicolors') == 1 then
    vim.opt.termguicolors = true
end

-- Settings to blankline
vim.opt.list = true
vim.opt.listchars:append "eol:↴"

vim.opt.mouse='a'
vim.opt.number = true
vim.opt.hlsearch = true
vim.opt.incsearch = true
vim.opt.tabstop = 4
vim.opt.softtabstop = 4
vim.opt.shiftwidth = 4
vim.opt.expandtab = true
vim.opt.cursorline = true
vim.opt.splitbelow = true
vim.opt.splitright = true
vim.opt.scrolloff = 8
