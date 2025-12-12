-- Lualine
require('lualine').setup {
  options = {
    icons_enabled = true,
    theme = 'auto',
    component_separators = { left = '❬', right = '❬'},
    section_separators = { left = '', right = ''},
    disabled_filetypes = {
      statusline = {},
      winbar = {},
    },
    ignore_focus = {},
    always_divide_middle = true,
    globalstatus = false,
    refresh = {
      statusline = 1000,
      tabline = 1000,
      winbar = 1000,
    }
  },
  sections = {
    lualine_a = {'mode'},
    lualine_b = {'branch', 'diff', 'diagnostics'},
    lualine_c = {'filename'},
    lualine_x = {'encoding', 'fileformat', 'filetype'},
    lualine_y = {'progress'},
    lualine_z = {'location'}
  },
  inactive_sections = {
    lualine_a = {},
    lualine_b = {},
    lualine_c = {'filename'},
    lualine_x = {'location'},
    lualine_y = {},
    lualine_z = {}
  },
  tabline = {},
  winbar = {},
  inactive_winbar = {},
  extensions = {}
}

-- Indent Blankline
require("ibl").setup{}

-- nvim treesitter
require('nvim-treesitter.configs').setup {
    ensure_installed = { "cpp", "c", "vim", "lua", "java", "json", "markdown", "pascal",
    "make", "cmake", "rasi", "css", "javascript", "html", "python" },

    sync_install = false,
    auto_install = false,

    highlight = {
        enable = true,
        use_languagetree = true,
    }
}

-- Nvim colorizer
require('colorizer').setup{
    '*',
}

-- Nvim autopairs
require('nvim-autopairs').setup({
  enable_check_bracket_line = false
})

-- Nvim-tree
vim.g.loaded_netrw = 1
vim.g.loaded_netrwPlugin = 1

require("nvim-tree").setup({
    sort_by = "case_sensitive",
    disable_netrw = true,
    hijack_netrw = true,
    hijack_cursor = true,
    hijack_unnamed_buffer_when_opening = false,
    sync_root_with_cwd = true,

    update_focused_file = {
        enable = true,
        update_root = true,
    },

    view = {
        adaptive_size = false,
        side = "left",
        preserve_window_proportions = true,
        width = 30,
    },

    git = {
        enable = true,
        ignore = true,
    },

    filesystem_watchers = {
        enable = true,
    },

    filters = {
        dotfiles = false,
    },

    actions = {
        open_file = {
            resize_window = true,
        },
    },

    renderer = {
        highlight_git = true,
        highlight_opened_files = "none",

        indent_markers = {
            enable = true,
        },
        icons = {
            show = {
                file = true,
                folder = true,
                folder_arrow = true,
                git = true,
            },

            glyphs = {
               default = "󰈚",
               symlink = "",
               folder = {
                default = "",
                empty = "",
                empty_open = "",
                open = "",
                symlink = "",
                symlink_open = "",
                arrow_open = "",
                arrow_closed = "",
               },
            },
        },
        group_empty = true,
    },
})

-- bufferline
require("bufferline").setup{
    highlights = {
        buffer_selected = {
            italic = false,
        },
    },
    options = {
        indicator = {
            style = 'icon',
        },
        offsets = {
                {
                    filetype = "NvimTree",
                    text = "File Explorer",
                    text_align = "center",
                    highlight = "Directory",
                    separator = true
                }
        },
        always_show_bufferline = false,
        show_buffer_close_icons = false,
        show_close_icon = false,
    },
}

require("telescope").setup{
    defaults = {
        vimgrep_arguments = {
          "rg",
          "-L",
          "--color=never",
          "--no-heading",
          "--with-filename",
          "--line-number",
          "--column",
          "--smart-case",
        },
        prompt_prefix = "   ",
        selection_caret = "  ",
        entry_prefix = "  ",
        initial_mode = "insert",
        selection_strategy = "reset",
        sorting_strategy = "ascending",
        layout_strategy = "horizontal",
        layout_config = {
          horizontal = {
            prompt_position = "top",
            preview_width = 0.55,
            results_width = 0.8,
          },
          vertical = {
            mirror = false,
          },
          width = 0.87,
          height = 0.80,
          preview_cutoff = 120,
        },
        file_sorter = require("telescope.sorters").get_fuzzy_file,
        file_ignore_patterns = { "node_modules" },
        generic_sorter = require("telescope.sorters").get_generic_fuzzy_sorter,
        path_display = { "truncate" },
        winblend = 0,
        border = {},
        borderchars = { "─", "│", "─", "│", "╭", "╮", "╯", "╰" },
        color_devicons = true,
        set_env = { ["COLORTERM"] = "truecolor" }, -- default = nil,
        file_previewer = require("telescope.previewers").vim_buffer_cat.new,
        grep_previewer = require("telescope.previewers").vim_buffer_vimgrep.new,
        qflist_previewer = require("telescope.previewers").vim_buffer_qflist.new,
        -- Developer configurations: Not meant for general override
        buffer_previewer_maker = require("telescope.previewers").buffer_previewer_maker,
        mappings = {
          n = { ["q"] = require("telescope.actions").close },
        },
    },
}
