
local fzf = require("fzf")

local options = {
  relative = 'cursor',
  border = 5,
  height = 7,
  width = 20,
  row = -8,
  col = -1,
}

local open_dict = coroutine.wrap(function()
  local result = fzf.fzf(
          "rg '' " .. vim.o.dictionary,
          "--ansi",
          options
        )
  -- result is a list of lines that fzf returns, if the user has chosen
  if result then
    print(result[1])
  end
end)

-- open_dict()

local api = vim.api
local mode = "i"
local lhs = "<C-Q>"
local rhs = ":lua require 'nvim-fzf'."
-- api.nvim_set_keymap(mode, lhs, rhs, {silent = true})

-- api.nvim_set_keymap(mode, lhs, '<cmd>lua require"nvim-fzf".open_dict<cr>', {
--       nowait = true, noremap = true, silent = true
-- })


return {open_dict = open_dict}
