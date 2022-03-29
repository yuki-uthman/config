
vim.cmd 'packadd vim-endwise'
vim.cmd 'packadd pairz.nvim'

-- map C-H to BS
-- remember it should be imap!
vim.cmd 'imap <C-H> <BS>'

local utils = require 'pairz.utils'
local core  = require 'pairz.core'

require 'pairz'.setup {

  pairz = {
    global = {
      ["["] = core:new { left = "[", right = "]" }
    },
  },
  fallback = {
    enter = function()
      utils.feedkey("<CR>", "n")
      utils.feedkey("<Plug>DiscretionaryEnd" , "")
      return ""
    end,
  }

}


