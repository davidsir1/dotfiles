return require('packer').startup(function(use)

	use 'wbthomason/packer.nvim'
	use 'morhetz/gruvbox'
--    use 'tomasr/molokai'
    use 'lukas-reineke/indent-blankline.nvim'
    use 'norcalli/nvim-colorizer.lua'
    use 'windwp/nvim-autopairs'
    use 'nvim-tree/nvim-web-devicons'


    -- LSP Plugins
    use 'neovim/nvim-lspconfig'
    use 'hrsh7th/cmp-nvim-lsp'
    use 'hrsh7th/cmp-buffer'
    use 'hrsh7th/nvim-cmp'
    use 'hrsh7th/cmp-path'
    use 'ray-x/lsp_signature.nvim'
    use 'onsails/lspkind.nvim'


    -- Luasnip
    use 'L3MON4D3/LuaSnip'
    use 'saadparwaiz1/cmp_luasnip'
    use 'rafamadriz/friendly-snippets' -- Completar os snippets com <TAB>

    use {'akinsho/bufferline.nvim', tag = "v3.*", requires = 'nvim-tree/nvim-web-devicons'}

    use {
        'nvim-treesitter/nvim-treesitter',
        run = ':TSUpdate'
    }

	use {
	  'nvim-lualine/lualine.nvim',
	  requires = { 'kyazdani42/nvim-web-devicons', opt = true }
	}

	use {
	  'nvim-telescope/telescope.nvim',
	  requires = { {'nvim-lua/plenary.nvim'} }
	}

    use {
        'nvim-tree/nvim-tree.lua',
        requires = {
         'nvim-tree/nvim-web-devicons', -- optional, for file icons
        },
        tag = 'nightly' -- optional, updated every week. (see issue #1193)
    }

end)
