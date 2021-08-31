
runtime OPT general.vim
runtime OPT mapping.vim
runtime OPT abbreviation.vim
runtime OPT colors.vim

" minpac 
runtime OPT minpac.vim

" packer
lua require('plugins')

lua<<EOF
require'lightspeed'.setup { 
    jump_to_first_match = true,
    full_inclusive_prefix_key = '<tab>',
}
EOF

