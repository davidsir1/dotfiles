
require"lsp_signature".setup()

local cmp = require'cmp'

local lspkind = require('lspkind')
local source_mapping = {
    buffer = "◉ Buffer",
    nvim_lsp = "󱥋 LSP",
    nvim_lua = "󰢱 Lua",
    path = " Path",
    luasnip = " LuaSnip"
}


cmp.setup({

    sources = {
        { name = 'nvim_lsp' },
        { name = 'luasnip' },
        { name = 'buffer' },
        { name = 'path' },
        { name = 'nvim_lua' },
    },

    formatting = {
        format = function(entry, vim_item)
            vim_item.kind = lspkind.presets.default[vim_item.kind]
            local menu = source_mapping[entry.source.name]
            if entry.completion_item.data ~= nil and entry.completion_item.data.detail ~= nil then
                 menu = entry.completion_item.data.detail .. ' ' .. menu
            end
            vim_item.menu = menu
            return vim_item
        end
    },

    snippet = {
        expand = function(args)
            require('luasnip').lsp_expand(args.body)
        end,
    },

    mapping = {
         ['<C-n>'] = cmp.mapping.select_next_item({ behavior = cmp.SelectBehavior.Insert }),
         ['<C-p>'] = cmp.mapping.select_prev_item({ behavior = cmp.SelectBehavior.Insert }),
         ['<Down>'] = cmp.mapping.select_next_item({ behavior = cmp.SelectBehavior.Select }),
         ['<Up>'] = cmp.mapping.select_prev_item({ behavior = cmp.SelectBehavior.Select }),
         ['<C-d>'] = cmp.mapping.scroll_docs(-4),
         ['<C-f>'] = cmp.mapping.scroll_docs(4),
         ['<C-Space>'] = cmp.mapping.complete(),
         ['<C-e>'] = cmp.mapping.close(),
         ['<CR>'] = cmp.mapping.confirm(),
    }

})

-- Language Server Protocol -=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-
local capabilities = require('cmp_nvim_lsp').default_capabilities()

-- C/C++ Language server
require'lspconfig'.clangd.setup{
    capabilities = capabilities,

    cmd = { "clangd-15", "--header-insertion=never" },

    filetype = { "cpp", "c", "hpp", "h", "hxx", "cxx" },
}

-- Lua Language server
local runtime_path = vim.split(package.path, ";")
table.insert(runtime_path, "lua/?.lua")
table.insert(runtime_path, "lua/?/init.lua")

require'lspconfig'.lua_ls.setup({
    autostart = false,
    settings = {
        Lua = {
            runtime = {
                version = "LuaJIT",
                path = runtime_path,
            },
            diagnostics = {
                globals = { "vim" },
            },
            workspace = {
                 library = vim.api.nvim_get_runtime_file("", true),
            },
            telemetry = {
                enable = false,
            },
        },
    },
})
require("luasnip/loaders/from_vscode").load()

require'lspconfig'.pyright.setup{}

-- Javascript HTMl CSS
local server = {'tsserver', 'eslint'}
for _, lsp in pairs(server) do
    require'lspconfig'[lsp].setup {
        capabilities = capabilities,
    }
end

require'lspconfig'.cssls.setup{
    capabilities = capabilities,
}

require'lspconfig'.html.setup{
    capabilities = capabilities,
}

vim.diagnostic.config({
     virtual_text = false
})

-- Mostrar diagnósticos de linha automaticamente na janela de hover
vim.o.updatetime = 250
vim.cmd [[autocmd CursorHold,CursorHoldI * lua vim.diagnostic.open_float(nil, {focus=false})]]
