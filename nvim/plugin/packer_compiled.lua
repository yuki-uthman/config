-- Automatically generated packer.nvim plugin loader code

if vim.api.nvim_call_function('has', {'nvim-0.5'}) ~= 1 then
  vim.api.nvim_command('echohl WarningMsg | echom "Invalid Neovim version for packer.nvim! | echohl None"')
  return
end

vim.api.nvim_command('packadd packer.nvim')

local no_errors, error_msg = pcall(function()

  local time
  local profile_info
  local should_profile = false
  if should_profile then
    local hrtime = vim.loop.hrtime
    profile_info = {}
    time = function(chunk, start)
      if start then
        profile_info[chunk] = hrtime()
      else
        profile_info[chunk] = (hrtime() - profile_info[chunk]) / 1e6
      end
    end
  else
    time = function(chunk, start) end
  end
  
local function save_profiles(threshold)
  local sorted_times = {}
  for chunk_name, time_taken in pairs(profile_info) do
    sorted_times[#sorted_times + 1] = {chunk_name, time_taken}
  end
  table.sort(sorted_times, function(a, b) return a[2] > b[2] end)
  local results = {}
  for i, elem in ipairs(sorted_times) do
    if not threshold or threshold and elem[2] > threshold then
      results[i] = elem[1] .. ' took ' .. elem[2] .. 'ms'
    end
  end

  _G._packer = _G._packer or {}
  _G._packer.profile_output = results
end

time([[Luarocks path setup]], true)
local package_path_str = "/Users/Yuki/.cache/nvim/packer_hererocks/2.1.0-beta3/share/lua/5.1/?.lua;/Users/Yuki/.cache/nvim/packer_hererocks/2.1.0-beta3/share/lua/5.1/?/init.lua;/Users/Yuki/.cache/nvim/packer_hererocks/2.1.0-beta3/lib/luarocks/rocks-5.1/?.lua;/Users/Yuki/.cache/nvim/packer_hererocks/2.1.0-beta3/lib/luarocks/rocks-5.1/?/init.lua"
local install_cpath_pattern = "/Users/Yuki/.cache/nvim/packer_hererocks/2.1.0-beta3/lib/lua/5.1/?.so"
if not string.find(package.path, package_path_str, 1, true) then
  package.path = package.path .. ';' .. package_path_str
end

if not string.find(package.cpath, install_cpath_pattern, 1, true) then
  package.cpath = package.cpath .. ';' .. install_cpath_pattern
end

time([[Luarocks path setup]], false)
time([[try_loadstring definition]], true)
local function try_loadstring(s, component, name)
  local success, result = pcall(loadstring(s))
  if not success then
    vim.schedule(function()
      vim.api.nvim_notify('packer.nvim: Error running ' .. component .. ' for ' .. name .. ': ' .. result, vim.log.levels.ERROR, {})
    end)
  end
  return result
end

time([[try_loadstring definition]], false)
time([[Defining packer_plugins]], true)
_G.packer_plugins = {
  Colorizer = {
    loaded = false,
    needs_bufread = false,
    path = "/Users/Yuki/.local/share/nvim/site/pack/packer/opt/Colorizer"
  },
  Decho = {
    loaded = false,
    needs_bufread = false,
    path = "/Users/Yuki/.local/share/nvim/site/pack/packer/opt/Decho"
  },
  ale = {
    loaded = false,
    needs_bufread = true,
    path = "/Users/Yuki/.local/share/nvim/site/pack/packer/opt/ale"
  },
  ["any-jump.vim"] = {
    loaded = false,
    needs_bufread = false,
    path = "/Users/Yuki/.local/share/nvim/site/pack/packer/opt/any-jump.vim"
  },
  ["cmp-buffer"] = {
    after_files = { "/Users/Yuki/.local/share/nvim/site/pack/packer/opt/cmp-buffer/after/plugin/cmp_buffer.lua" },
    load_after = {
      ["nvim-cmp"] = true
    },
    loaded = false,
    needs_bufread = false,
    path = "/Users/Yuki/.local/share/nvim/site/pack/packer/opt/cmp-buffer"
  },
  ["cmp-calc"] = {
    after_files = { "/Users/Yuki/.local/share/nvim/site/pack/packer/opt/cmp-calc/after/plugin/cmp_calc.lua" },
    load_after = {
      ["nvim-cmp"] = true
    },
    loaded = false,
    needs_bufread = false,
    path = "/Users/Yuki/.local/share/nvim/site/pack/packer/opt/cmp-calc"
  },
  ["cmp-emoji"] = {
    after_files = { "/Users/Yuki/.local/share/nvim/site/pack/packer/opt/cmp-emoji/after/plugin/cmp_emoji.lua" },
    load_after = {
      ["nvim-cmp"] = true
    },
    loaded = false,
    needs_bufread = false,
    path = "/Users/Yuki/.local/share/nvim/site/pack/packer/opt/cmp-emoji"
  },
  ["cmp-look"] = {
    after_files = { "/Users/Yuki/.local/share/nvim/site/pack/packer/opt/cmp-look/after/plugin/cmp_look.lua" },
    load_after = {
      ["nvim-cmp"] = true
    },
    loaded = false,
    needs_bufread = false,
    path = "/Users/Yuki/.local/share/nvim/site/pack/packer/opt/cmp-look"
  },
  ["cmp-nvim-lsp"] = {
    after_files = { "/Users/Yuki/.local/share/nvim/site/pack/packer/opt/cmp-nvim-lsp/after/plugin/cmp_nvim_lsp.lua" },
    load_after = {
      ["nvim-cmp"] = true
    },
    loaded = false,
    needs_bufread = false,
    path = "/Users/Yuki/.local/share/nvim/site/pack/packer/opt/cmp-nvim-lsp"
  },
  ["cmp-nvim-lua"] = {
    after_files = { "/Users/Yuki/.local/share/nvim/site/pack/packer/opt/cmp-nvim-lua/after/plugin/cmp_nvim_lua.lua" },
    load_after = {
      ["nvim-cmp"] = true
    },
    loaded = false,
    needs_bufread = false,
    path = "/Users/Yuki/.local/share/nvim/site/pack/packer/opt/cmp-nvim-lua"
  },
  ["cmp-path"] = {
    after_files = { "/Users/Yuki/.local/share/nvim/site/pack/packer/opt/cmp-path/after/plugin/cmp_path.lua" },
    load_after = {
      ["nvim-cmp"] = true
    },
    loaded = false,
    needs_bufread = false,
    path = "/Users/Yuki/.local/share/nvim/site/pack/packer/opt/cmp-path"
  },
  ["cmp-spell"] = {
    after_files = { "/Users/Yuki/.local/share/nvim/site/pack/packer/opt/cmp-spell/after/plugin/cmp-spell.lua" },
    load_after = {
      ["nvim-cmp"] = true
    },
    loaded = false,
    needs_bufread = false,
    path = "/Users/Yuki/.local/share/nvim/site/pack/packer/opt/cmp-spell"
  },
  ["cmp-vsnip"] = {
    after_files = { "/Users/Yuki/.local/share/nvim/site/pack/packer/opt/cmp-vsnip/after/plugin/cmp_vsnip.vim" },
    load_after = {
      ["nvim-cmp"] = true
    },
    loaded = false,
    needs_bufread = false,
    path = "/Users/Yuki/.local/share/nvim/site/pack/packer/opt/cmp-vsnip"
  },
  ["coc.nvim"] = {
    loaded = false,
    needs_bufread = false,
    path = "/Users/Yuki/.local/share/nvim/site/pack/packer/opt/coc.nvim"
  },
  ["codi.vim"] = {
    loaded = false,
    needs_bufread = false,
    path = "/Users/Yuki/.local/share/nvim/site/pack/packer/opt/codi.vim"
  },
  ["ctrlp.vim"] = {
    loaded = false,
    needs_bufread = false,
    path = "/Users/Yuki/.local/share/nvim/site/pack/packer/opt/ctrlp.vim"
  },
  ["denite.nvim"] = {
    loaded = false,
    needs_bufread = false,
    path = "/Users/Yuki/.local/share/nvim/site/pack/packer/opt/denite.nvim"
  },
  ["emmet-vim"] = {
    loaded = false,
    needs_bufread = false,
    path = "/Users/Yuki/.local/share/nvim/site/pack/packer/opt/emmet-vim"
  },
  everforest = {
    loaded = false,
    needs_bufread = false,
    path = "/Users/Yuki/.local/share/nvim/site/pack/packer/opt/everforest"
  },
  ["fzf.vim"] = {
    loaded = false,
    needs_bufread = false,
    path = "/Users/Yuki/.local/share/nvim/site/pack/packer/opt/fzf.vim"
  },
  ["github-nvim-theme"] = {
    loaded = false,
    needs_bufread = false,
    path = "/Users/Yuki/.local/share/nvim/site/pack/packer/opt/github-nvim-theme"
  },
  ["goyo.vim"] = {
    loaded = false,
    needs_bufread = false,
    path = "/Users/Yuki/.local/share/nvim/site/pack/packer/opt/goyo.vim"
  },
  ["lh-brackets"] = {
    loaded = false,
    needs_bufread = true,
    path = "/Users/Yuki/.local/share/nvim/site/pack/packer/opt/lh-brackets"
  },
  ["lh-vim-lib"] = {
    after_files = { "/Users/Yuki/.local/share/nvim/site/pack/packer/opt/lh-vim-lib/after/plugin/lh-project-delayed-events.vim" },
    loaded = false,
    needs_bufread = false,
    path = "/Users/Yuki/.local/share/nvim/site/pack/packer/opt/lh-vim-lib"
  },
  ["lightspeed.nvim"] = {
    loaded = false,
    needs_bufread = false,
    path = "/Users/Yuki/.local/share/nvim/site/pack/packer/opt/lightspeed.nvim"
  },
  ["lua-dev.nvim"] = {
    loaded = false,
    needs_bufread = false,
    path = "/Users/Yuki/.local/share/nvim/site/pack/packer/opt/lua-dev.nvim"
  },
  ["nvim-cmp"] = {
    after = { "cmp-buffer", "cmp-emoji", "cmp-nvim-lsp", "cmp-path", "cmp-spell", "cmp-vsnip", "cmp-look", "cmp-nvim-lua", "cmp-calc" },
    loaded = false,
    needs_bufread = false,
    path = "/Users/Yuki/.local/share/nvim/site/pack/packer/opt/nvim-cmp"
  },
  ["nvim-lspconfig"] = {
    loaded = false,
    needs_bufread = false,
    path = "/Users/Yuki/.local/share/nvim/site/pack/packer/opt/nvim-lspconfig"
  },
  ["nvim-luapad"] = {
    loaded = false,
    needs_bufread = false,
    path = "/Users/Yuki/.local/share/nvim/site/pack/packer/opt/nvim-luapad"
  },
  ["packer.nvim"] = {
    loaded = true,
    path = "/Users/Yuki/.local/share/nvim/site/pack/packer/start/packer.nvim"
  },
  ["rust.vim"] = {
    loaded = false,
    needs_bufread = true,
    path = "/Users/Yuki/.local/share/nvim/site/pack/packer/opt/rust.vim"
  },
  tagbar = {
    loaded = false,
    needs_bufread = false,
    path = "/Users/Yuki/.local/share/nvim/site/pack/packer/opt/tagbar"
  },
  ["targets.vim"] = {
    loaded = false,
    needs_bufread = false,
    path = "/Users/Yuki/.local/share/nvim/site/pack/packer/opt/targets.vim"
  },
  tselectbuffer_vim = {
    loaded = false,
    needs_bufread = false,
    path = "/Users/Yuki/.local/share/nvim/site/pack/packer/opt/tselectbuffer_vim"
  },
  ["vader.vim"] = {
    loaded = false,
    needs_bufread = true,
    path = "/Users/Yuki/.local/share/nvim/site/pack/packer/opt/vader.vim"
  },
  ["vim-ReplaceWithRegister"] = {
    loaded = false,
    needs_bufread = false,
    path = "/Users/Yuki/.local/share/nvim/site/pack/packer/opt/vim-ReplaceWithRegister"
  },
  ["vim-async"] = {
    loaded = false,
    needs_bufread = false,
    path = "/Users/Yuki/.local/share/nvim/site/pack/packer/opt/vim-async"
  },
  ["vim-commentary"] = {
    loaded = false,
    needs_bufread = false,
    path = "/Users/Yuki/.local/share/nvim/site/pack/packer/opt/vim-commentary"
  },
  ["vim-cool"] = {
    loaded = false,
    needs_bufread = false,
    path = "/Users/Yuki/.local/share/nvim/site/pack/packer/opt/vim-cool"
  },
  ["vim-cutlass"] = {
    loaded = false,
    needs_bufread = false,
    path = "/Users/Yuki/.local/share/nvim/site/pack/packer/opt/vim-cutlass"
  },
  ["vim-easy-align"] = {
    loaded = false,
    needs_bufread = false,
    path = "/Users/Yuki/.local/share/nvim/site/pack/packer/opt/vim-easy-align"
  },
  ["vim-easymotion"] = {
    loaded = false,
    needs_bufread = false,
    path = "/Users/Yuki/.local/share/nvim/site/pack/packer/opt/vim-easymotion"
  },
  ["vim-endwise"] = {
    loaded = false,
    needs_bufread = false,
    path = "/Users/Yuki/.local/share/nvim/site/pack/packer/opt/vim-endwise"
  },
  ["vim-floaterm"] = {
    loaded = false,
    needs_bufread = false,
    path = "/Users/Yuki/.local/share/nvim/site/pack/packer/opt/vim-floaterm"
  },
  ["vim-fugitive"] = {
    loaded = false,
    needs_bufread = true,
    path = "/Users/Yuki/.local/share/nvim/site/pack/packer/opt/vim-fugitive"
  },
  ["vim-highlightedyank"] = {
    loaded = false,
    needs_bufread = false,
    path = "/Users/Yuki/.local/share/nvim/site/pack/packer/opt/vim-highlightedyank"
  },
  ["vim-ingo-library"] = {
    loaded = false,
    needs_bufread = false,
    path = "/Users/Yuki/.local/share/nvim/site/pack/packer/opt/vim-ingo-library"
  },
  ["vim-js"] = {
    loaded = false,
    needs_bufread = true,
    path = "/Users/Yuki/.local/share/nvim/site/pack/packer/opt/vim-js"
  },
  ["vim-lookup"] = {
    loaded = false,
    needs_bufread = false,
    path = "/Users/Yuki/.local/share/nvim/site/pack/packer/opt/vim-lookup"
  },
  ["vim-maktaba"] = {
    loaded = false,
    needs_bufread = false,
    path = "/Users/Yuki/.local/share/nvim/site/pack/packer/opt/vim-maktaba"
  },
  ["vim-maximizer"] = {
    loaded = false,
    needs_bufread = false,
    path = "/Users/Yuki/.local/share/nvim/site/pack/packer/opt/vim-maximizer"
  },
  ["vim-medieval"] = {
    loaded = false,
    needs_bufread = true,
    path = "/Users/Yuki/.local/share/nvim/site/pack/packer/opt/vim-medieval"
  },
  ["vim-peekaboo"] = {
    loaded = false,
    needs_bufread = false,
    path = "/Users/Yuki/.local/share/nvim/site/pack/packer/opt/vim-peekaboo"
  },
  ["vim-rails"] = {
    loaded = false,
    needs_bufread = true,
    path = "/Users/Yuki/.local/share/nvim/site/pack/packer/opt/vim-rails"
  },
  ["vim-repeat"] = {
    loaded = false,
    needs_bufread = false,
    path = "/Users/Yuki/.local/share/nvim/site/pack/packer/opt/vim-repeat"
  },
  ["vim-ruby"] = {
    loaded = false,
    needs_bufread = true,
    path = "/Users/Yuki/.local/share/nvim/site/pack/packer/opt/vim-ruby"
  },
  ["vim-scriptease"] = {
    loaded = false,
    needs_bufread = false,
    path = "/Users/Yuki/.local/share/nvim/site/pack/packer/opt/vim-scriptease"
  },
  ["vim-surround"] = {
    loaded = false,
    needs_bufread = false,
    path = "/Users/Yuki/.local/share/nvim/site/pack/packer/opt/vim-surround"
  },
  ["vim-swap"] = {
    loaded = false,
    needs_bufread = false,
    path = "/Users/Yuki/.local/share/nvim/site/pack/packer/opt/vim-swap"
  },
  ["vim-test"] = {
    loaded = false,
    needs_bufread = false,
    path = "/Users/Yuki/.local/share/nvim/site/pack/packer/opt/vim-test"
  },
  ["vim-textobj-rubyblock"] = {
    loaded = false,
    needs_bufread = false,
    path = "/Users/Yuki/.local/share/nvim/site/pack/packer/opt/vim-textobj-rubyblock"
  },
  ["vim-textobj-url"] = {
    loaded = false,
    needs_bufread = false,
    path = "/Users/Yuki/.local/share/nvim/site/pack/packer/opt/vim-textobj-url"
  },
  ["vim-textobj-user"] = {
    loaded = false,
    needs_bufread = false,
    path = "/Users/Yuki/.local/share/nvim/site/pack/packer/opt/vim-textobj-user"
  },
  ["vim-tmux-navigator"] = {
    loaded = false,
    needs_bufread = false,
    path = "/Users/Yuki/.local/share/nvim/site/pack/packer/opt/vim-tmux-navigator"
  },
  ["vim-tmux-runner"] = {
    loaded = false,
    needs_bufread = false,
    path = "/Users/Yuki/.local/share/nvim/site/pack/packer/opt/vim-tmux-runner"
  },
  ["vim-unimpaired"] = {
    loaded = false,
    needs_bufread = false,
    path = "/Users/Yuki/.local/share/nvim/site/pack/packer/opt/vim-unimpaired"
  },
  ["vim-vsnip"] = {
    loaded = false,
    needs_bufread = false,
    path = "/Users/Yuki/.local/share/nvim/site/pack/packer/opt/vim-vsnip"
  },
  ["vim-vsnip-integ"] = {
    after_files = { "/Users/Yuki/.local/share/nvim/site/pack/packer/opt/vim-vsnip-integ/after/plugin/vsnip_integ.vim" },
    loaded = false,
    needs_bufread = false,
    path = "/Users/Yuki/.local/share/nvim/site/pack/packer/opt/vim-vsnip-integ"
  },
  ["vital.vim"] = {
    loaded = false,
    needs_bufread = false,
    path = "/Users/Yuki/.local/share/nvim/site/pack/packer/opt/vital.vim"
  },
  ["webapi-vim"] = {
    loaded = false,
    needs_bufread = false,
    path = "/Users/Yuki/.local/share/nvim/site/pack/packer/opt/webapi-vim"
  },
  ["wilder.nvim"] = {
    loaded = false,
    needs_bufread = false,
    path = "/Users/Yuki/.local/share/nvim/site/pack/packer/opt/wilder.nvim"
  }
}

time([[Defining packer_plugins]], false)
if should_profile then save_profiles() end

end)

if not no_errors then
  vim.api.nvim_command('echohl ErrorMsg | echom "Error in packer_compiled: '..error_msg..'" | echom "Please check your config for correctness" | echohl None')
end
