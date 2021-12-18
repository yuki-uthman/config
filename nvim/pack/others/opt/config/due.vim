packadd due.nvim

" lua require 'config.due'

lua << EOF

require('due_nvim').setup {
  prescript = '▸▸▸ ',           -- prescript to due data
  prescript_hi = 'Comment',      -- highlight group of it
  due_hi = 'String',             -- highlight group of the data itself
  ft = '*.md',                   -- filename template to apply aucmds :)
  today = 'TODAY',               -- text for today's due
  today_hi = 'Character',        -- highlight group of today's due
  overdue = 'OVERDUE',           -- text for overdued
  overdue_hi = 'Error',          -- highlight group of overdued
  date_hi = 'Conceal',           -- highlight group of date string
  pattern_start = '<',           -- start for a date string pattern
  pattern_end = '>',             -- end for a date string pattern
  use_clock_time = true,        -- allow due.nvim to calculate hours, minutes, and seconds
  default_due_time = "noon", -- if use_clock_time == true, calculate time until option on specified date. 
}

EOF

nnoremap <leader>d <cmd>lua require 'due_nvim'.draw(0)<CR>


