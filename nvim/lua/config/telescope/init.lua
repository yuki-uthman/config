local action_state = require "telescope.actions.state"
local actions = require "telescope.actions"
local conf = require("telescope.config").values
local finders = require "telescope.finders"
local make_entry = require "telescope.make_entry"
local pickers = require "telescope.pickers"
local previewers = require "telescope.previewers"
local sorters = require "telescope.sorters"
local themes = require "telescope.themes"

local M = {}

-- local layout_config_defaults = {

--   horizontal = {
--     width = 0.8,
--     height = 0.9,
--     prompt_position = "bottom",
--     preview_cutoff = 120,
--   },

--   vertical = {
--     width = 0.8,
--     height = 0.9,
--     prompt_position = "bottom",
--     preview_cutoff = 40,
--   },

--   center = {
--     width = 0.8,
--     height = 0.9,
--     preview_cutoff = 40,
--     prompt_position = "top",
--   },

--   cursor = {
--     width = 0.8,
--     height = 0.9,
--     preview_cutoff = 40,
--   },

--   bottom_pane = {
--     height = 25,
--     prompt_position = "top",
--   },
-- }

function M.edit_neovim()
  local opts_with_preview, opts_without_preview

  opts_with_preview = {
    prompt_title = "~ dotfiles ~",
    dynamic_preview_title = true,
    shorten_path = false,
    cwd = "~/.config/nvim",

    layout_strategy = "flex",
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
  }

  opts_without_preview = vim.deepcopy(opts_with_preview)
  opts_without_preview.previewer = false

  require("telescope.builtin").find_files(opts_with_preview)
end

local list = vim.fn.split((vim.fn.globpath(vim.o.rtp, 'doc/*.txt')))

-- local bufnr = 76
-- vim.api.nvim_buf_set_lines(bufnr, 0, -1, false, list)

local parse = function(entry)
  local _, _, filename, lnum, col, text = string.find(entry, [[([^:]+):(%d+):(%d+):(.*)]])

  local ok
  ok, lnum = pcall(tonumber, lnum)
  if not ok then
    lnum = nil
  end

  ok, col = pcall(tonumber, col)
  if not ok then
    col = nil
  end

  local t = {
    filename = filename,
    lnum = lnum,
    col = col,
    text = text,
  }

  return t
end

local function custom_entry()
  return function(entry)
    if entry == "" then
      return nil
    end

    local parsed = parse(entry)

    return {
      value = parsed.text,
      ordinal = parsed.text,
      display = parsed.text,
      path = parsed.filename,
      filename = parsed.filename,
      lnum = parsed.lnum,
      col = parsed.col,
    }
  end
end

local function get_linked_group(hl)
  local id = vim.fn.hlID(hl)
  local linked_id = vim.fn.synIDtrans(id)
  local linked_group = vim.fn.synIDattr(linked_id, 'name')
  return linked_group
end

local function restore_hl(prompt_bufnr)
  vim.cmd("highlight! link TelescopePreviewLine " .. TelescopePreviewLine)
  vim.cmd("highlight! link TelescopeSelection " .. TelescopeSelection)
  vim.cmd("highlight! link TelescopeMatching " .. TelescopeMatching)

  TelescopePreviewLine = nil
  TelescopeSelection   = nil
  TelescopeMatching    = nil

  actions.close(prompt_bufnr)
end


function M.help_grep(opts)

  TelescopePreviewLine = get_linked_group('TelescopePreviewLine')
  TelescopeSelection = get_linked_group('TelescopeSelection')
  TelescopeMatching = get_linked_group('TelescopeMatching')

  vim.cmd "highlight! link TelescopePreviewLine PmenuSel"
  vim.cmd "highlight! link TelescopeSelection PmenuSel"
  vim.cmd "highlight! link TelescopeMatching Clear"

  require("telescope.builtin").grep_string {
    search_dirs = list,

    layout_strategy = "vertical",
    layout_config = {
      height = 0.99,
      width = 0.99,
      preview_cutoff = 1,
      preview_height = 0.7,
    },

    entry_maker = custom_entry(),

    search = '',
    -- sorter = require("telescope.sorters").get_fzy_sorter,
    -- sorter = conf.generic_sorter(opts),
    -- sorter = sorters.get_fzy_sorter(),
    -- sorter = sorters.get_generic_fuzzy_sorter(),

    attach_mappings = function(prompt_bufnr, map)
      map("i", "<ESC>", restore_hl)
      return true
    end,

  }
end

function M.find_files()
  require("telescope.builtin").find_files {

    layout_strategy = "vertical",
    layout_config = {
      height = 0.99,
      width = 0.99,
      preview_cutoff = 1,
      preview_height = 0.7,
    },


  }
end

local function highlight(cmd)
  return {
    {0, #cmd, 'Constant'}
  }
end

local function ask(message)
  vim.fn.inputsave()

  local table = {
    prompt = message,
    highlight = highlight,
  }

  local input = vim.fn.input(table)

  vim.fn.inputrestore()
  return input
end

function M.grep_nvim_config(opts)
  local opts = opts or {}

  local input = ask("Grep: ")
  opts.entry_maker = opts.entry_maker or make_entry.gen_from_vimgrep(opts)

  opts.layout_strategy = 'vertical'
  opts.layout_config = {
    height = 0.99,
    width = 0.99,
    preview_cutoff = 1,
    preview_height = 0.7,
  }

  pickers.new(opts, {

    prompt_title = "Seaching \"" .. input .. "\"",

    -- separate the command from the options
    -- each options should also be seprated!
    finder = finders.new_oneshot_job({
          "rg",
          "--color=never",
          "--no-heading",
          "--with-filename",
          "--line-number",
          "--column",
          "--smart-case",
          "--",
          input,  -- initial search string required even if it is empty 
                  -- otherwise it thinks the search-dirs as the search string
          vim.fn.expand("~/.config/nvim"),    -- current directory
    }, opts),
    -- sorter = sorters.get_generic_fuzzy_sorter(opts),
    -- sorter = require("telescope.sorters").get_fzy_sorter(opts),
    previewer = conf.grep_previewer(opts),
    sorter = conf.generic_sorter(opts),
  }):find()

end




function M.grep_string(opts)
  local opts = opts or {}

  local input = ask("Grep: ")
  opts.entry_maker = opts.entry_maker or make_entry.gen_from_vimgrep(opts)

  opts.layout_strategy = 'vertical'
  opts.layout_config = {
    height = 0.99,
    width = 0.99,
    preview_cutoff = 1,
    preview_height = 0.7,
  }

  pickers.new(opts, {

    prompt_title = "Seaching \"" .. input .. "\"",

    -- separate the command from the options
    -- each options should also be seprated!
    finder = finders.new_oneshot_job({
          "rg",
          "--color=never",
          "--no-heading",
          "--with-filename",
          "--line-number",
          "--column",
          "--smart-case",
          "--",
          input,  -- initial search string required even if it is empty 
                  -- otherwise it thinks the search-dirs as the search string
          ".",    -- current directory
    }, opts),
    -- sorter = sorters.get_generic_fuzzy_sorter(opts),
    -- sorter = require("telescope.sorters").get_fzy_sorter(opts),
    previewer = conf.grep_previewer(opts),
    sorter = conf.generic_sorter(opts),
  }):find()

end

function M._grep_string(opts)
  -- TODO: This should probably check your visual selection as well, if you've got one

  local opts = opts or {}

  local vimgrep_arguments = opts.vimgrep_arguments or conf.vimgrep_arguments
  local search_dirs = opts.search_dirs
  local word = opts.search or vim.fn.expand "<cword>"
  local search = ""
  local word_match = opts.word_match
  opts.entry_maker = opts.entry_maker or make_entry.gen_from_vimgrep(opts)

  local additional_args = {}
  if opts.additional_args ~= nil and type(opts.additional_args) == "function" then
    additional_args = opts.additional_args(opts)
  end

  local args = vim.tbl_flatten {
    vimgrep_arguments,
    additional_args,
    word_match,
    "--",
    search,
  }

  if search_dirs then
    for _, path in ipairs(search_dirs) do
      table.insert(args, vim.fn.expand(path))
    end
  else
    table.insert(args, ".")
  end

  pickers.new(opts, {
    prompt_title = "Find Word (" .. word .. ")",
    finder = finders.new_oneshot_job(args, opts),
    previewer = conf.grep_previewer(opts),
    sorter = conf.generic_sorter(opts),
  }):find()
end

return M
