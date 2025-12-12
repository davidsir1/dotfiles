local opt = { noremap = true, silent = true }
local map = vim.keymap.set
vim.g.mapleader = ";"

-- Mover-se no modo insert
map('i', '<C-e>', "<ESC>^i", { desc = "move beginning of line"})
map('i', '<C-b>', "<End>", { desc = "move end of line"})
map('i', '<C-h>', "<Left>", { desc = "move left"})
map('i', '<C-l>', "<Right>", { desc = "move right"})
map('i', '<C-k>', "<Up>", { desc = "move up"})
map('i', '<C-j>', "<Down>", { desc = "move down"})

-- Limpar os highlights
map('n', '<Esc>', '<Cmd>noh<CR>', { desc = "general clear highlights"})

-- Move um bloco selecionado - alt+j/k
map('v', '<A-j>', ":m '>+1<CR>gv=gv", {desc = "move line up"})
map('v', '<A-k>', ":m '<-2<CR>gv=gv", {desc = "move line down"})
map('i', '<A-j>', '<Esc>:m .+1<CR>==gi', {desc = "move line up"})
map('i', '<A-k>', '<Esc>:m .-2<CR>==gi', {desc = "move line down"})

-- salva o arquivo e sai do nvim
map('n', '<C-s>', ':w<CR>', {desc = "file save"})
map('n', '<C-q>', ':q!<CR>', {desc = "exiting"})

-- Mapeamento para o Nvim-tree
map('n', '<C-n>', ':NvimTreeToggle<CR>', { desc = "nvimtree toggle window"})
map('n', '<leader>e', ':NvimTreeFocus<CR>', { desc = "nvimtree focus window"})

-- Mapeamento do Telescope
local builtin = require('telescope.builtin')
map('n', '<leader>ff', builtin.find_files, { desc = "telescope find files"})
map('n', '<leader>fg', builtin.live_grep, { desc = "telescope live grep"})
map('n', '<leader>fb', builtin.buffers, { desc = "telescope find buffers"})
map('n', '<leader>fh', builtin.help_tags, { desc = "telescope help page"})

-- Mapeamento do Telescope do LSP
-- vim.keymap.set('n', '<leader>gi', ':Telescope lsp_implementations<CR>', {silent = true})
-- vim.keymap.set('n', '<leader>gd', ':Telescope lsp_definitions<CR>', {silent = true})
-- vim.keymap.set('n', '<leader>gr', ':Telescope lsp_references<CR>', {silent = true})

map('n', 'gD', vim.lsp.buf.declaration, opt)
map('n', 'gd', vim.lsp.buf.definition, opt)
map('n', 'gi', vim.lsp.buf.implementation, opt)

-- Mapeamento dos buffers
map('n', '<tab>', ':BufferLineCycleNext<CR>', opt)
map('n', '<s-tab>', ':BufferLineCyclePrev<CR>', opt)
map('n', '<A-c>', ':bd<CR>', opt)

-- Mapeamento de navegação das janelas
map('n', '<C-h>', '<C-w>h', opt)
map('n', '<C-j>', '<C-w>j', opt)
map('n', '<C-k>', '<C-w>k', opt)
map('n', '<C-l>', '<C-w>l', opt)

-- Mapeamento de ajustar tamanho da janela
map('n', '<C-Up>', ':resize +2<CR>', opt)
map('n', '<C-Down>', ':resize -2<CR>', opt)
map('n', '<C-Left>', ':vertical resize -2<CR>', opt)
map('n', '<C-Right>', ':vertical resize +2<CR>', opt)

-- Dividir a janela
map('n', 'ss', ':split<Return>', {desc = "split screen"})
map('n', 'sv', ':vsplit<Return>', {desc = "split screen vertical"})

-- Mapeamento do modo terminal
map('t', '<ESC>', '<C-\\><C-n>', opt)
