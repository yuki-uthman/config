
runtime config/general/general.vim
runtime config/general/mapping.vim
runtime config/general/abbreviation.vim
runtime config/general/colors.vim
runtime config/general/tmux.vim

" packages 
runtime config/packs/minpac.vim


lua<<EOF
require'lightspeed'.setup { 
    jump_to_first_match = true,
    full_inclusive_prefix_key = '<tab>',
}
EOF


