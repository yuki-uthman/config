local cmp = require('cmp')
local types = require('cmp.types')

cmp.setup.buffer{

  completion = {
    autocomplete = {
      types.cmp.TriggerEvent.TextChanged,
    },
    completeopt = 'menu,menuone,noselect',
    keyword_pattern = [[\%(-\?\d\+\%(\.\d\+\)\?\|\h\w*\%(-\w*\)*\)]],
    keyword_length = 4,
  },


  comparators = {
    cmp.config.compare.length,
    cmp.config.compare.score,
    cmp.config.compare.offset,
    cmp.config.compare.exact,
    cmp.config.compare.kind,
    cmp.config.compare.sort_text,
    cmp.config.compare.order,
  },

  sources = {
    {name = 'look'}
  }
}


