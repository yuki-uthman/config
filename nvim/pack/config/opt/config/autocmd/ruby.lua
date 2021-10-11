
local types = require('cmp.types')

require'cmp'.setup.buffer {
  completion = {
     autocomplete = {
            types.cmp.TriggerEvent.TextChanged,
      },
  },

  sources = {
    { name = 'cmp-tabnine' },
  },
}




