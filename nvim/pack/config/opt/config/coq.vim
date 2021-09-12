
packadd coq_nvim

lua << EOF
local lsp = require "lspconfig"
local coq = require "coq" -- add this

lsp.vimls.setup(coq.lsp_ensure_capabilities()) -- after
EOF
