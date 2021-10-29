local cmp = require('cmp')
local types = require('cmp.types')

cmp.setup.buffer{

  completion = {
    autocomplete = {
      types.cmp.TriggerEvent.TextChanged,
    },
    completeopt = 'menu,menuone,noselect',
    keyword_pattern = [[\%(-\?\d\+\%(\.\d\+\)\?\|\h\w*\%(-\w*\)*\)]],
    keyword_length = 1,
  },

  -- preselect = types.cmp.PreselectMode.Item,

  sources = {
    {name = 'buffer'}
  }
}


