
vim.cmd 'packadd vim-endwise'
vim.cmd 'packadd pairs.nvim'

-- require 'pairs'.setup()


local utils = require 'pairs.utils'

require 'pairs'.setup {

  fallback = {
    enter = function()
      utils.feedkey("<CR>", "n")
      utils.feedkey("<Plug>DiscretionaryEnd" , "")
      return ""
    end,
  }

}


