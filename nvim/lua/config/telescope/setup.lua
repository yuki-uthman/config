
local actions = require "telescope.actions"

require("telescope").setup {
  extensions = {
      fzf = {
        fuzzy = true,                    -- false will only do exact matching
        override_generic_sorter = true,  -- override the generic sorter
        override_file_sorter = true,     -- override the file sorter
        case_mode = "respect_case",        -- or "ignore_case" or "respect_case"
                                         -- the default case_mode is "smart_case"
      }
    },

    -- extensions = {
    --     fzy_native = {
    --         override_generic_sorter = true,
    --         override_file_sorter = true,
    --     }
    -- },

  defaults = {
    layout_config = {
      width = 0.99,
      height = 0.99,

      horizontal = {
        preview_width  = 0.75,
      },
      vertical = {
        preview_height = 0.75,
      },

      scroll_speed = 1,
    },

    mappings = {
      i = {
        -- ["<esc>"] = actions.close,
        ["<c-j>"] = actions.move_selection_next,
        ["<c-k>"] = actions.move_selection_previous,
        ["<Down>"] = actions.preview_scrolling_down,
        ["<Up>"] = actions.preview_scrolling_up,
      },
    },

    file_ignore_patterns = {
      "dict/*",
    },

  },

  -- file_previewer = require("telescope.previewers").vim_buffer_cat.new,
  -- grep_previewer = require("telescope.previewers").vim_buffer_vimgrep.new,
  -- qflist_previewer = require("telescope.previewers").vim_buffer_qflist.new,


}

require('telescope').load_extension('fzf')
-- require('telescope').load_extension('neoclip')

-- git submodule update --init --recursive
-- require('telescope').load_extension('fzy_native')
