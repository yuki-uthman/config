" Name: Desert Night
" Thanks: Based on Desert Night from Sainnhepark (https://github.com/sainnhe/vim-color-desert-night/).

" Background: dark
" Color: black         #24221c           235               Black
" Color: grey          #473f31           233               Grey
" Color: lightgrey     #87765d           240               LightGrey
" Color: golden        #d4b07b           250               White
" Color: red           #e56b55           203               Red
" Color: orange        #e18245           208               DarkYellow
" Color: yellow        #e5a440           214               Yellow
" Color: lemon         #bfab36           192               LightGreen
" Color: green         #99b05f           120               Green
" Color: brown         #bd975f           248               Brown
" Color: blue          #949fb4           81                Blue
" Color: magenta       #d261a5           139               Magenta
" Color: darkorange    #512c13           136               Black
" Color: darkred       #562022           124               Black
" Color: darkgreen     #303a1a           64                Black
" Color: darkblue      #1e2c3e           24                Black
" Term colors: grey red green orange blue magenta lemon golden
" Term colors: grey red green yellow
" Term colors: blue magenta lemon golden
" Color: unused #000000 0 0
" vim: et ts=2 sw=2

set background=dark

hi clear
if exists('syntax_on')
  syntax reset
endif

let g:colors_name = 'desert-night'

let s:t_Co = exists('&t_Co') && !empty(&t_Co) && &t_Co > 1 ? &t_Co : 2
let s:italics = (((&t_ZH != '' && &t_ZH != '[7m') || has('gui_running')) && !has('iOS')) || has('nvim')

hi! link QuickFixLine Search
hi! link StatusLineTerm StatusLine
hi! link StatusLineTermNC StatusLineNC
hi! link Structure Type
hi! link Define PreProc
hi! link Debug Special
hi! link Include PreProc
hi! link Macro PreProc
hi! link lCursor Cursor

if (has('termguicolors') && &termguicolors) || has('gui_running')
  let g:terminal_ansi_colors = ['#473f31', '#e56b55', '#99b05f', '#e18245',
        \ '#949fb4', '#d261a5', '#bfab36', '#d4b07b', '#473f31', '#e56b55',
        \ '#99b05f', '#e5a440', '#949fb4', '#d261a5', '#bfab36', '#d4b07b']
  if has('nvim')
    let g:terminal_color_0 = '#473f31'
    let g:terminal_color_1 = '#e56b55'
    let g:terminal_color_2 = '#99b05f'
    let g:terminal_color_3 = '#e18245'
    let g:terminal_color_4 = '#949fb4'
    let g:terminal_color_5 = '#d261a5'
    let g:terminal_color_6 = '#bfab36'
    let g:terminal_color_7 = '#d4b07b'
    let g:terminal_color_8 = '#473f31'
    let g:terminal_color_9 = '#e56b55'
    let g:terminal_color_10 = '#99b05f'
    let g:terminal_color_11 = '#e5a440'
    let g:terminal_color_12 = '#949fb4'
    let g:terminal_color_13 = '#d261a5'
    let g:terminal_color_14 = '#bfab36'
    let g:terminal_color_15 = '#d4b07b'
  endif
  if get(g:, 'dark_transp_bg', 0) && !has('gui_running')
    hi Normal guifg=#d4b07b guibg=NONE guisp=NONE gui=NONE cterm=NONE
    hi Terminal guifg=#d4b07b guibg=NONE guisp=NONE gui=NONE cterm=NONE
  else
    " hi Normal guifg=#d4b07b guibg=#24221c guisp=NONE gui=NONE cterm=NONE
    hi Normal guifg=#d4b07b guibg=#042327 guisp=NONE gui=NONE cterm=NONE
    hi Terminal guifg=#d4b07b guibg=#24221c guisp=NONE gui=NONE cterm=NONE
  endif
  hi ColorColumn guifg=fg guibg=#24221c guisp=NONE gui=NONE cterm=NONE
  hi Conceal guifg=#87765d guibg=NONE guisp=NONE gui=NONE cterm=NONE
  hi Cursor guifg=NONE guibg=NONE guisp=NONE gui=reverse ctermfg=NONE ctermbg=NONE cterm=reverse
  hi CursorColumn guifg=NONE guibg=#473f31 guisp=NONE gui=NONE cterm=NONE
  hi CursorLine guifg=NONE guibg=#473f31 guisp=NONE gui=NONE cterm=NONE
  hi CursorLineNr guifg=#d4b07b guibg=#473f31 guisp=NONE gui=NONE cterm=NONE
  hi LineNr guifg=#665c54 guibg=NONE guisp=NONE gui=NONE cterm=NONE
  hi DiffAdd guifg=NONE guibg=#303a1a guisp=NONE gui=NONE cterm=NONE
  hi DiffChange guifg=NONE guibg=#1e2c3e guisp=NONE gui=NONE cterm=NONE
  hi DiffDelete guifg=NONE guibg=#562022 guisp=NONE gui=NONE cterm=NONE
  hi DiffText guifg=NONE guibg=#512c13 guisp=NONE gui=NONE cterm=NONE
  hi Directory guifg=#99b05f guibg=NONE guisp=NONE gui=NONE cterm=NONE
  hi EndOfBuffer guifg=#24221c guibg=NONE guisp=NONE gui=NONE cterm=NONE
  hi ErrorMsg guifg=#e56b55 guibg=NONE guisp=NONE gui=NONE cterm=NONE
  hi WarningMsg guifg=#e18245 guibg=NONE guisp=NONE gui=NONE cterm=NONE
  hi ModeMsg guifg=#24221c guibg=#87765d guisp=NONE gui=bold cterm=bold
  hi MoreMsg guifg=#d4b07b guibg=#473f31 guisp=NONE gui=NONE cterm=NONE
  hi FoldColumn guifg=#87765d guibg=#473f31 guisp=NONE gui=NONE cterm=NONE
  hi Folded guifg=#87765d guibg=#473f31 guisp=NONE gui=NONE cterm=NONE
  hi IncSearch guifg=NONE guibg=#473f31 guisp=NONE gui=underline cterm=underline
  hi MatchParen guifg=NONE guibg=NONE guisp=NONE gui=bold ctermfg=NONE ctermbg=NONE cterm=bold
  hi NonText guifg=#473f31 guibg=NONE guisp=NONE gui=NONE cterm=NONE
  hi Pmenu guifg=#d4b07b guibg=#473f31 guisp=NONE gui=NONE cterm=NONE
  hi PmenuSbar guifg=NONE guibg=#473f31 guisp=NONE gui=NONE cterm=NONE
  hi PmenuSel guifg=#24221c guibg=#99b05f guisp=NONE gui=NONE cterm=NONE
  hi PmenuThumb guifg=#24221c guibg=#d4b07b guisp=NONE gui=NONE cterm=NONE
  hi Question guifg=#949fb4 guibg=NONE guisp=NONE gui=NONE cterm=NONE
  hi Search guifg=NONE guibg=#473f31 guisp=NONE gui=underline cterm=underline
  hi SignColumn guifg=#665c54  guibg=NONE guisp=NONE gui=NONE cterm=NONE
  hi SpellBad guifg=#e56b55 guibg=NONE guisp=#e56b55 gui=NONE cterm=NONE
  hi SpellCap guifg=#e18245 guibg=NONE guisp=#e18245 gui=NONE cterm=NONE
  hi SpellLocal guifg=#949fb4 guibg=NONE guisp=#949fb4 gui=NONE cterm=NONE
  hi SpellRare guifg=#d261a5 guibg=NONE guisp=#d261a5 gui=NONE cterm=NONE
  hi WildMenu guifg=#24221c guibg=#87765d guisp=NONE gui=NONE cterm=NONE
  hi StatusLine guifg=#d4b07b guibg=#473f31 guisp=NONE gui=NONE cterm=NONE
  hi StatusLineNC guifg=#d4b07b guibg=#24221c guisp=NONE gui=NONE cterm=NONE
  hi TabLine guifg=#d4b07b guibg=#473f31 guisp=NONE gui=NONE cterm=NONE
  hi TabLineFill guifg=#d4b07b guibg=#24221c guisp=NONE gui=NONE cterm=NONE
  hi TabLineSel guifg=#24221c guibg=#87765d guisp=NONE gui=NONE cterm=NONE
  " hi VertSplit guifg=#473f31 guibg=#24221c guisp=NONE gui=NONE cterm=NONE
  hi VertSplit guifg=#473f31 guibg=#042327 guisp=NONE gui=NONE cterm=NONE
  hi Visual guifg=NONE guibg=#473f31 guisp=NONE gui=NONE cterm=NONE
  hi VisualNOS guifg=NONE guibg=#473f31 guisp=NONE gui=italic cterm=italic
  hi PreCondit guifg=#e18245 guibg=NONE guisp=NONE gui=NONE cterm=NONE
  hi Title guifg=#e56b55 guibg=NONE guisp=NONE gui=NONE cterm=NONE
  hi PreProc guifg=#e56b55 guibg=NONE guisp=NONE gui=NONE cterm=NONE
  hi Exception guifg=#e56b55 guibg=NONE guisp=NONE gui=NONE cterm=NONE
  hi Error guifg=#e56b55 guibg=NONE guisp=NONE gui=NONE cterm=NONE
  hi Typedef guifg=#e56b55 guibg=NONE guisp=NONE gui=NONE cterm=NONE
  hi Conditional guifg=#e56b55 guibg=NONE guisp=NONE gui=NONE cterm=NONE
  hi Repeat guifg=#e56b55 guibg=NONE guisp=NONE gui=NONE cterm=NONE
  hi SpecialKey guifg=#e56b55 guibg=NONE guisp=NONE gui=NONE cterm=NONE
  hi Label guifg=#e18245 guibg=NONE guisp=NONE gui=NONE cterm=NONE
  hi Todo guifg=#e18245 guibg=NONE guisp=NONE gui=NONE cterm=NONE
  hi Keyword guifg=#e18245 guibg=NONE guisp=NONE gui=NONE cterm=NONE
  hi StorageClass guifg=#e18245 guibg=NONE guisp=NONE gui=NONE cterm=NONE
  hi Operator guifg=#e18245 guibg=NONE guisp=NONE gui=NONE cterm=NONE
  hi Statement guifg=#e18245 guibg=NONE guisp=NONE gui=NONE cterm=NONE
  hi Type guifg=#e5a440 guibg=NONE guisp=NONE gui=NONE cterm=NONE
  hi Function guifg=#99b05f guibg=NONE guisp=NONE gui=NONE cterm=NONE
  hi Special guifg=#99b05f guibg=NONE guisp=NONE gui=NONE cterm=NONE
  hi Identifier guifg=#99b05f guibg=NONE guisp=NONE gui=NONE cterm=NONE
  hi Constant guifg=#99b05f guibg=NONE guisp=NONE gui=NONE cterm=NONE
  hi Delimiter guifg=#99b05f guibg=NONE guisp=NONE gui=NONE cterm=NONE
  hi Tag guifg=#99b05f guibg=NONE guisp=NONE gui=NONE cterm=NONE
  hi String guifg=#bfab36 guibg=NONE guisp=NONE gui=NONE cterm=NONE
  hi Character guifg=#bfab36 guibg=NONE guisp=NONE gui=NONE cterm=NONE
  hi Number guifg=#bfab36 guibg=NONE guisp=NONE gui=NONE cterm=NONE
  hi Float guifg=#bfab36 guibg=NONE guisp=NONE gui=NONE cterm=NONE
  hi Boolean guifg=#99b05f guibg=NONE guisp=NONE gui=NONE cterm=NONE
  hi SpecialChar guifg=#99b05f guibg=NONE guisp=NONE gui=NONE cterm=NONE
  hi Comment guifg=#87765d guibg=NONE guisp=NONE gui=italic cterm=italic
  hi SpecialComment guifg=#87765d guibg=NONE guisp=NONE gui=italic cterm=italic
  hi Ignore guifg=#87765d guibg=NONE guisp=NONE gui=NONE cterm=NONE
  hi Underlined guifg=NONE guibg=NONE guisp=NONE gui=underline ctermfg=NONE ctermbg=NONE cterm=underline
  hi CursorIM guifg=NONE guibg=fg guisp=NONE gui=NONE cterm=NONE
  hi ToolbarLine guifg=NONE guibg=#24221c guisp=NONE gui=NONE cterm=NONE
  hi ToolbarButton guifg=#d4b07b guibg=#24221c guisp=NONE gui=bold cterm=bold
  hi markdownLinkText guifg=#e18245 guibg=NONE guisp=NONE gui=NONE cterm=NONE
  hi markdownUrl guifg=#bfab36 guibg=NONE guisp=NONE gui=underline cterm=underline
  hi markdownListMarker guifg=#e5a440 guibg=NONE guisp=NONE gui=NONE cterm=NONE
  hi markdownCode guifg=#99b05f guibg=NONE guisp=NONE gui=NONE cterm=NONE
  hi markdownCodeDelimiter guifg=#bfab36 guibg=NONE guisp=NONE gui=NONE cterm=NONE
  hi markdownId guifg=#e5a440 guibg=NONE guisp=NONE gui=NONE cterm=NONE
  hi markdownIdDeclaration guifg=#e18245 guibg=NONE guisp=NONE gui=NONE cterm=NONE
  hi! link markdownBoldDelimiter Comment
  hi! link markdownItalicDelimiter Comment
  hi markdownBold guifg=NONE guibg=NONE guisp=NONE gui=bold ctermfg=NONE ctermbg=NONE cterm=bold
  hi markdownItalic guifg=NONE guibg=NONE guisp=NONE gui=italic ctermfg=NONE ctermbg=NONE cterm=italic
  hi markdownRule guifg=#e56b55 guibg=NONE guisp=NONE gui=NONE cterm=NONE
  hi markdownHeadingDelimiter guifg=#e18245 guibg=NONE guisp=NONE gui=NONE cterm=NONE
  hi mkdListItem guifg=#e5a440 guibg=NONE guisp=NONE gui=NONE cterm=NONE
  hi mkdInlineURL guifg=#e5a440 guibg=NONE guisp=NONE gui=underline cterm=underline
  hi mkdLink guifg=#e18245 guibg=NONE guisp=NONE gui=NONE cterm=NONE
  hi mkdURL guifg=#bfab36 guibg=NONE guisp=NONE gui=underline cterm=underline
  hi mkdCodeDelimiter guifg=#bfab36 guibg=NONE guisp=NONE gui=NONE cterm=NONE
  hi mkdID guifg=#e5a440 guibg=NONE guisp=NONE gui=NONE cterm=NONE
  hi! link mkdBold Comment
  hi! link mkdItalic Comment
  hi mkdRule guifg=#e56b55 guibg=NONE guisp=NONE gui=NONE cterm=NONE
  hi mkdCode guifg=#99b05f guibg=NONE guisp=NONE gui=NONE cterm=NONE
  hi mkdHeading guifg=#e18245 guibg=NONE guisp=NONE gui=NONE cterm=NONE
  hi rstInlineLiteral guifg=#99b05f guibg=NONE guisp=NONE gui=NONE cterm=NONE
  hi rstTableLines guifg=#bfab36 guibg=NONE guisp=NONE gui=NONE cterm=NONE
  hi texOnlyMath guifg=#e18245 guibg=NONE guisp=NONE gui=NONE cterm=NONE
  hi texSection guifg=#e18245 guibg=NONE guisp=NONE gui=NONE cterm=NONE
  hi texBeginEndName guifg=#e56b55 guibg=NONE guisp=NONE gui=NONE cterm=NONE
  hi htmlArg guifg=#e18245 guibg=NONE guisp=NONE gui=NONE cterm=NONE
  hi htmlTag guifg=#99b05f guibg=NONE guisp=NONE gui=NONE cterm=NONE
  hi htmlEndTag guifg=#bfab36 guibg=NONE guisp=NONE gui=NONE cterm=NONE
  hi htmlLink guifg=NONE guibg=NONE guisp=NONE gui=underline ctermfg=NONE ctermbg=NONE cterm=underline
  hi htmlBold guifg=NONE guibg=NONE guisp=NONE gui=bold ctermfg=NONE ctermbg=NONE cterm=bold
  hi htmlItalic guifg=NONE guibg=NONE guisp=NONE gui=italic ctermfg=NONE ctermbg=NONE cterm=italic
  hi xmlEndTag guifg=#bfab36 guibg=NONE guisp=NONE gui=NONE cterm=NONE
  hi xmlAttrib guifg=#e18245 guibg=NONE guisp=NONE gui=NONE cterm=NONE
  hi cssUnitDecorators guifg=#99b05f guibg=NONE guisp=NONE gui=NONE cterm=NONE
  hi cssFunctionName guifg=#e5a440 guibg=NONE guisp=NONE gui=NONE cterm=NONE
  hi cssAttr guifg=#bfab36 guibg=NONE guisp=NONE gui=NONE cterm=NONE
  hi cssColor guifg=#bfab36 guibg=NONE guisp=NONE gui=NONE cterm=NONE
  hi cssImportant guifg=#e56b55 guibg=NONE guisp=NONE gui=NONE cterm=NONE
  hi cssTagName guifg=#e5a440 guibg=NONE guisp=NONE gui=NONE cterm=NONE
  hi! link cssBraces Delimiter
  hi! link cssSelectorOp Delimiter
  hi! link cssSelectorOp2 Delimiter
  hi sassClassChar guifg=#e18245 guibg=NONE guisp=NONE gui=NONE cterm=NONE
  hi sassMixinName guifg=#e56b55 guibg=NONE guisp=NONE gui=NONE cterm=NONE
  hi scssForKeyword guifg=#e56b55 guibg=NONE guisp=NONE gui=NONE cterm=NONE
  hi scssInterpolationDelimiter guifg=#bfab36 guibg=NONE guisp=NONE gui=NONE cterm=NONE
  hi scssFunctionName guifg=#e5a440 guibg=NONE guisp=NONE gui=NONE cterm=NONE
  hi scssDefault guifg=#e56b55 guibg=NONE guisp=NONE gui=NONE cterm=NONE
  hi scssMixinName guifg=#e56b55 guibg=NONE guisp=NONE gui=NONE cterm=NONE
  hi lessClass guifg=#e5a440 guibg=NONE guisp=NONE gui=NONE cterm=NONE
  hi lessMixinChar guifg=#e18245 guibg=NONE guisp=NONE gui=NONE cterm=NONE
  hi! link javaScriptBraces Delimiter
  hi! link javaScriptParens Delimiter
  hi javaScriptFunction guifg=#e18245 guibg=NONE guisp=NONE gui=NONE cterm=NONE
  hi javaScriptGlobal guifg=#e5a440 guibg=NONE guisp=NONE gui=NONE cterm=NONE
  hi javaScriptNull guifg=#e5a440 guibg=NONE guisp=NONE gui=NONE cterm=NONE
  hi javaScriptOperator guifg=#e56b55 guibg=NONE guisp=NONE gui=NONE cterm=NONE
  hi jsOperatorKeyword guifg=#e56b55 guibg=NONE guisp=NONE gui=NONE cterm=NONE
  hi jsGlobalNodeObjects guifg=#e5a440 guibg=NONE guisp=NONE gui=NONE cterm=NONE
  hi jsFunction guifg=#e18245 guibg=NONE guisp=NONE gui=NONE cterm=NONE
  hi jsArrowFunction guifg=#e56b55 guibg=NONE guisp=NONE gui=NONE cterm=NONE
  hi! link jsParens Delimiter
  hi! link jsBraces Delimiter
  hi! link jsBrackets Delimiter
  hi! link jsFuncBraces Delimiter
  hi! link jsFuncParens Delimiter
  hi! link jsObjectBraces Delimiter
  hi! link jsObjectParens Delimiter
  hi! link jsExceptions Exception
  hi typescriptLabel guifg=#e56b55 guibg=NONE guisp=NONE gui=NONE cterm=NONE
  hi! link typescriptExceptions Exception
  hi! link typescriptParens Delimiter
  hi! link typescriptBraces Delimiter
  hi! link typescriptEndColons typescriptBraces
  hi typescriptGlobalObjects guifg=#e5a440 guibg=NONE guisp=NONE gui=NONE cterm=NONE
  hi typescriptLogicSymbols guifg=#e56b55 guibg=NONE guisp=NONE gui=NONE cterm=NONE
  hi! link typescriptOpSymbols Operator
  hi typescriptOperator guifg=#e56b55 guibg=NONE guisp=NONE gui=NONE cterm=NONE
  hi typescriptInterpolationDelimiter guifg=#bfab36 guibg=NONE guisp=NONE gui=NONE cterm=NONE
  hi typescriptBranch guifg=#e18245 guibg=NONE guisp=NONE gui=NONE cterm=NONE
  hi dartTypedef guifg=#e56b55 guibg=NONE guisp=NONE gui=NONE cterm=NONE
  hi dartInterpolation guifg=#99b05f guibg=NONE guisp=NONE gui=NONE cterm=NONE
  hi dartBranch guifg=#e18245 guibg=NONE guisp=NONE gui=NONE cterm=NONE
  hi dartCoreClasses guifg=#99b05f guibg=NONE guisp=NONE gui=NONE cterm=NONE
  hi dartConstant guifg=#e5a440 guibg=NONE guisp=NONE gui=NONE cterm=NONE
  hi! link coffeeParen Delimiter
  hi! link coffeeCurly Delimiter
  hi! link coffeeBracket Delimiter
  hi coffeeSpecialVar guifg=#99b05f guibg=NONE guisp=NONE gui=NONE cterm=NONE
  hi coffeeSpecialIdent guifg=#e5a440 guibg=NONE guisp=NONE gui=NONE cterm=NONE
  hi coffeeInterp guifg=#99b05f guibg=NONE guisp=NONE gui=NONE cterm=NONE
  hi coffeeInterpDelim guifg=#bfab36 guibg=NONE guisp=NONE gui=NONE cterm=NONE
  hi purescriptModuleParams guifg=#99b05f guibg=NONE guisp=NONE gui=NONE cterm=NONE
  hi purescriptOperatorTypeSig guifg=#e56b55 guibg=NONE guisp=NONE gui=NONE cterm=NONE
  hi purescriptOperatorFunction guifg=#99b05f guibg=NONE guisp=NONE gui=NONE cterm=NONE
  hi javaScopeDecl guifg=#e56b55 guibg=NONE guisp=NONE gui=NONE cterm=NONE
  hi! link javaParen Delimiter
  hi javaVarArg guifg=#99b05f guibg=NONE guisp=NONE gui=NONE cterm=NONE
  hi javaStatement guifg=#99b05f guibg=NONE guisp=NONE gui=NONE cterm=NONE
  hi javaTypedef guifg=#e18245 guibg=NONE guisp=NONE gui=NONE cterm=NONE
  hi javaAnnotation guifg=#99b05f guibg=NONE guisp=NONE gui=NONE cterm=NONE
  hi ktModifier guifg=#e56b55 guibg=NONE guisp=NONE gui=NONE cterm=NONE
  hi ktStructure guifg=#e18245 guibg=NONE guisp=NONE gui=NONE cterm=NONE
  hi ktStatement guifg=#99b05f guibg=NONE guisp=NONE gui=NONE cterm=NONE
  hi pythonBuiltinFunc guifg=#e5a440 guibg=NONE guisp=NONE gui=NONE cterm=NONE
  hi pythonDecorator guifg=#bfab36 guibg=NONE guisp=NONE gui=NONE cterm=NONE
  hi pythonNone guifg=#e5a440 guibg=NONE guisp=NONE gui=NONE cterm=NONE
  hi goPackage guifg=#e56b55 guibg=NONE guisp=NONE gui=NONE cterm=NONE
  hi goImport guifg=#e56b55 guibg=NONE guisp=NONE gui=NONE cterm=NONE
  hi goStatement guifg=#99b05f guibg=NONE guisp=NONE gui=NONE cterm=NONE
  hi rustKeyword guifg=#e18245 guibg=NONE guisp=NONE gui=NONE cterm=NONE
  hi rustExternCrate guifg=#e56b55 guibg=NONE guisp=NONE gui=NONE cterm=NONE
  hi rustModPath guifg=#99b05f guibg=NONE guisp=NONE gui=NONE cterm=NONE
  hi rustModPathSep guifg=#bfab36 guibg=NONE guisp=NONE gui=NONE cterm=NONE
  hi rustSelf guifg=#e5a440 guibg=NONE guisp=NONE gui=NONE cterm=NONE
  hi rustLifetime guifg=#e5a440 guibg=NONE guisp=NONE gui=NONE cterm=NONE
  hi rustAssert guifg=#e56b55 guibg=NONE guisp=NONE gui=NONE cterm=NONE
  hi phpVarSelector guifg=#bfab36 guibg=NONE guisp=NONE gui=NONE cterm=NONE
  hi phpMethod guifg=#e5a440 guibg=NONE guisp=NONE gui=NONE cterm=NONE
  hi phpMethodsVar guifg=#e5a440 guibg=NONE guisp=NONE gui=NONE cterm=NONE
  hi phpMemberSelector guifg=#e18245 guibg=NONE guisp=NONE gui=NONE cterm=NONE
  hi phpUseClass guifg=#99b05f guibg=NONE guisp=NONE gui=NONE cterm=NONE
  hi phpUseAlias guifg=#e5a440 guibg=NONE guisp=NONE gui=NONE cterm=NONE
  hi phpFunction guifg=#e5a440 guibg=NONE guisp=NONE gui=NONE cterm=NONE
  hi phpFunctions guifg=#e5a440 guibg=NONE guisp=NONE gui=NONE cterm=NONE
  hi phpClass guifg=#e5a440 guibg=NONE guisp=NONE gui=NONE cterm=NONE
  hi phpClassExtends guifg=#99b05f guibg=NONE guisp=NONE gui=NONE cterm=NONE
  hi phpType guifg=#e56b55 guibg=NONE guisp=NONE gui=NONE cterm=NONE
  hi phpNullValue guifg=#bfab36 guibg=NONE guisp=NONE gui=NONE cterm=NONE
  hi phpClassImplements guifg=#99b05f guibg=NONE guisp=NONE gui=NONE cterm=NONE
  hi! link phpParent Delimiter
  hi csUnspecifiedStatement guifg=#e18245 guibg=NONE guisp=NONE gui=NONE cterm=NONE
  hi csModifier guifg=#e56b55 guibg=NONE guisp=NONE gui=NONE cterm=NONE
  hi csUnsupportedStatement guifg=#99b05f guibg=NONE guisp=NONE gui=NONE cterm=NONE
  hi csLogicSymbols guifg=#e56b55 guibg=NONE guisp=NONE gui=NONE cterm=NONE
  hi csContextualStatement guifg=#99b05f guibg=NONE guisp=NONE gui=NONE cterm=NONE
  hi csNewType guifg=#99b05f guibg=NONE guisp=NONE gui=NONE cterm=NONE
  hi csConstant guifg=#e5a440 guibg=NONE guisp=NONE gui=NONE cterm=NONE
  hi csAsync guifg=#e18245 guibg=NONE guisp=NONE gui=NONE cterm=NONE
  hi! link csBraces Delimiter
  hi! link csParens Delimiter
  hi fsharpModifier guifg=#e56b55 guibg=NONE guisp=NONE gui=NONE cterm=NONE
  hi fsharpKeyChar guifg=#bfab36 guibg=NONE guisp=NONE gui=NONE cterm=NONE
  hi fsharpLinq guifg=#e56b55 guibg=NONE guisp=NONE gui=NONE cterm=NONE
  hi fsharpCoreClass guifg=#e56b55 guibg=NONE guisp=NONE gui=NONE cterm=NONE
  hi fsharpAttribute guifg=#e18245 guibg=NONE guisp=NONE gui=NONE cterm=NONE
  hi fsharpOption guifg=#e5a440 guibg=NONE guisp=NONE gui=NONE cterm=NONE
  hi swiftInterpolatedString guifg=#99b05f guibg=NONE guisp=NONE gui=NONE cterm=NONE
  hi swiftTypeDeclaration guifg=#e56b55 guibg=NONE guisp=NONE gui=NONE cterm=NONE
  hi rubyModuleName guifg=#e18245 guibg=NONE guisp=NONE gui=NONE cterm=NONE
  hi rubyClass guifg=#e18245 guibg=NONE guisp=NONE gui=NONE cterm=NONE
  hi rubyPseudoVariable guifg=#99b05f guibg=NONE guisp=NONE gui=NONE cterm=NONE
  hi rubyDefine guifg=#e18245 guibg=NONE guisp=NONE gui=NONE cterm=NONE
  hi rubyModule guifg=#e56b55 guibg=NONE guisp=NONE gui=NONE cterm=NONE
  hi rubyConstant guifg=#99b05f guibg=NONE guisp=NONE gui=NONE cterm=NONE
  hi rubyMethodName guifg=#e5a440 guibg=NONE guisp=NONE gui=NONE cterm=NONE
  hi rubyControl guifg=#e56b55 guibg=NONE guisp=NONE gui=NONE cterm=NONE
  hi rubyInterpolation guifg=#99b05f guibg=NONE guisp=NONE gui=NONE cterm=NONE
  hi rubyInterpolationDelimiter guifg=#bfab36 guibg=NONE guisp=NONE gui=NONE cterm=NONE
  hi rubyBoolean guifg=#bfab36 guibg=NONE guisp=NONE gui=NONE cterm=NONE
  hi rubyCurlyBlockDelimiter guifg=#99b05f guibg=NONE guisp=NONE gui=NONE cterm=NONE
  hi rubyBlockParameterList guifg=#e5a440 guibg=NONE guisp=NONE gui=NONE cterm=NONE
  hi! link rubySymbol Identifier
  hi perlStatementPackage guifg=#e56b55 guibg=NONE guisp=NONE gui=NONE cterm=NONE
  hi! link perlStringStartEnd Delimiter
  hi perlMethod guifg=#e5a440 guibg=NONE guisp=NONE gui=NONE cterm=NONE
  hi perlStatementList guifg=#e5a440 guibg=NONE guisp=NONE gui=NONE cterm=NONE
  hi perlFunction guifg=#e56b55 guibg=NONE guisp=NONE gui=NONE cterm=NONE
  hi perlSubName guifg=#e18245 guibg=NONE guisp=NONE gui=NONE cterm=NONE
  hi haskellDeclKeyword guifg=#e18245 guibg=NONE guisp=NONE gui=NONE cterm=NONE
  hi haskellDecl guifg=#e18245 guibg=NONE guisp=NONE gui=NONE cterm=NONE
  hi HaskellDerive guifg=#e56b55 guibg=NONE guisp=NONE gui=NONE cterm=NONE
  hi haskellWhere guifg=#e56b55 guibg=NONE guisp=NONE gui=NONE cterm=NONE
  hi haskellLet guifg=#e18245 guibg=NONE guisp=NONE gui=NONE cterm=NONE
  hi! link luaBraces Delimiter
  hi luaLocal guifg=#e18245 guibg=NONE guisp=NONE gui=NONE cterm=NONE
  hi luaFuncCall guifg=#99b05f guibg=NONE guisp=NONE gui=NONE cterm=NONE
  hi luaSpecialTable guifg=#e5a440 guibg=NONE guisp=NONE gui=NONE cterm=NONE
  hi luaFuncKeyword guifg=#e18245 guibg=NONE guisp=NONE gui=NONE cterm=NONE
  hi luaSpecialValue guifg=#e5a440 guibg=NONE guisp=NONE gui=NONE cterm=NONE
  hi moonInterpDelim guifg=#bfab36 guibg=NONE guisp=NONE gui=NONE cterm=NONE
  hi moonInterp guifg=#99b05f guibg=NONE guisp=NONE gui=NONE cterm=NONE
  hi moonSpecialOp guifg=#bfab36 guibg=NONE guisp=NONE gui=NONE cterm=NONE
  hi dScopeDecl guifg=#e56b55 guibg=NONE guisp=NONE gui=NONE cterm=NONE
  hi dImport guifg=#99b05f guibg=NONE guisp=NONE gui=NONE cterm=NONE
  hi paramlist guifg=#99b05f guibg=NONE guisp=NONE gui=NONE cterm=NONE
  hi dEnum guifg=#e56b55 guibg=NONE guisp=NONE gui=NONE cterm=NONE
  hi dConstant guifg=#e5a440 guibg=NONE guisp=NONE gui=NONE cterm=NONE
  hi dTypedef guifg=#e18245 guibg=NONE guisp=NONE gui=NONE cterm=NONE
  hi dBranch guifg=#e18245 guibg=NONE guisp=NONE gui=NONE cterm=NONE
  hi scalaKeywordModifier guifg=#e56b55 guibg=NONE guisp=NONE gui=NONE cterm=NONE
  hi scalaSpecial guifg=#e18245 guibg=NONE guisp=NONE gui=NONE cterm=NONE
  hi! link scalaSquareBracketsBrackets Delimiter
  hi elixirBoolean guifg=#bfab36 guibg=NONE guisp=NONE gui=NONE cterm=NONE
  hi! link elixirTupleDelimiter Delimiter
  hi elixirPrivateDefine guifg=#e18245 guibg=NONE guisp=NONE gui=NONE cterm=NONE
  hi elixirAtom guifg=#99b05f guibg=NONE guisp=NONE gui=NONE cterm=NONE
  hi elixirKeyword guifg=#e18245 guibg=NONE guisp=NONE gui=NONE cterm=NONE
  hi ocamlSigEncl guifg=#e5a440 guibg=NONE guisp=NONE gui=NONE cterm=NONE
  hi ocamlKeyChar guifg=#bfab36 guibg=NONE guisp=NONE gui=NONE cterm=NONE
  hi ocamlArrow guifg=#bfab36 guibg=NONE guisp=NONE gui=NONE cterm=NONE
  hi ocamlModule guifg=#99b05f guibg=NONE guisp=NONE gui=NONE cterm=NONE
  hi ocamlModParam guifg=#99b05f guibg=NONE guisp=NONE gui=NONE cterm=NONE
  hi ocamlModParam1 guifg=#e5a440 guibg=NONE guisp=NONE gui=NONE cterm=NONE
  hi ocamlStructEncl guifg=#e18245 guibg=NONE guisp=NONE gui=NONE cterm=NONE
  hi ocamlFullMod guifg=#e5a440 guibg=NONE guisp=NONE gui=NONE cterm=NONE
  hi ocamlFuncWith guifg=#99b05f guibg=NONE guisp=NONE gui=NONE cterm=NONE
  hi ocamlConstructor guifg=#e56b55 guibg=NONE guisp=NONE gui=NONE cterm=NONE
  hi ocamlModPath guifg=#99b05f guibg=NONE guisp=NONE gui=NONE cterm=NONE
  hi fortranStructure guifg=#99b05f guibg=NONE guisp=NONE gui=NONE cterm=NONE
  hi fortranUnitHeader guifg=#e56b55 guibg=NONE guisp=NONE gui=NONE cterm=NONE
  hi fortranCall guifg=#e18245 guibg=NONE guisp=NONE gui=NONE cterm=NONE
  hi fortranReadWrite guifg=#99b05f guibg=NONE guisp=NONE gui=NONE cterm=NONE
  hi fortranIO guifg=#e5a440 guibg=NONE guisp=NONE gui=NONE cterm=NONE
  hi clojureDefine guifg=#e18245 guibg=NONE guisp=NONE gui=NONE cterm=NONE
  hi clojureSpecial guifg=#e5a440 guibg=NONE guisp=NONE gui=NONE cterm=NONE
  hi clojureDispatch guifg=#bfab36 guibg=NONE guisp=NONE gui=NONE cterm=NONE
  hi erlangAtom guifg=#99b05f guibg=NONE guisp=NONE gui=NONE cterm=NONE
  hi erlangLocalFuncRef guifg=#e5a440 guibg=NONE guisp=NONE gui=NONE cterm=NONE
  hi erlangType guifg=#e56b55 guibg=NONE guisp=NONE gui=NONE cterm=NONE
  hi erlangLocalFuncCall guifg=#99b05f guibg=NONE guisp=NONE gui=NONE cterm=NONE
  hi erlangGlobalFuncCall guifg=#e5a440 guibg=NONE guisp=NONE gui=NONE cterm=NONE
  hi erlangMap guifg=#bfab36 guibg=NONE guisp=NONE gui=NONE cterm=NONE
  hi erlangVariable guifg=#d4b07b guibg=NONE guisp=NONE gui=NONE cterm=NONE
  hi lispFunc guifg=#e18245 guibg=NONE guisp=NONE gui=NONE cterm=NONE
  hi lispKey guifg=#e5a440 guibg=NONE guisp=NONE gui=NONE cterm=NONE
  hi lispDecl guifg=#e56b55 guibg=NONE guisp=NONE gui=NONE cterm=NONE
  hi lispVar guifg=#99b05f guibg=NONE guisp=NONE gui=NONE cterm=NONE
  hi lispEscapeSpecial guifg=#99b05f guibg=NONE guisp=NONE gui=NONE cterm=NONE
  hi shFunction guifg=#e56b55 guibg=NONE guisp=NONE gui=NONE cterm=NONE
  hi shDerefSimple guifg=#99b05f guibg=NONE guisp=NONE gui=NONE cterm=NONE
  hi shTestOpr guifg=#e18245 guibg=NONE guisp=NONE gui=NONE cterm=NONE
  hi shFunctionOne guifg=#e5a440 guibg=NONE guisp=NONE gui=NONE cterm=NONE
  hi shCommandSub guifg=#e18245 guibg=NONE guisp=NONE gui=NONE cterm=NONE
  hi! link shQuote Delimiter
  hi! link shCmdSubRegion Delimiter
  hi! link shRange Delimiter
  hi zshSubst guifg=#e5a440 guibg=NONE guisp=NONE gui=NONE cterm=NONE
  hi zshDeref guifg=#99b05f guibg=NONE guisp=NONE gui=NONE cterm=NONE
  hi zshOptStart guifg=#e56b55 guibg=NONE guisp=NONE gui=NONE cterm=NONE
  hi zshOption guifg=#e18245 guibg=NONE guisp=NONE gui=NONE cterm=NONE
  hi zshVariableDef guifg=#99b05f guibg=NONE guisp=NONE gui=NONE cterm=NONE
  hi zshFunction guifg=#e56b55 guibg=NONE guisp=NONE gui=NONE cterm=NONE
  hi zshShortDeref guifg=#99b05f guibg=NONE guisp=NONE gui=NONE cterm=NONE
  hi! link zshSubstDelim Delimiter
  hi fishKeyword guifg=#e56b55 guibg=NONE guisp=NONE gui=NONE cterm=NONE
  hi vimMap guifg=#e56b55 guibg=NONE guisp=NONE gui=NONE cterm=NONE
  hi vimFuncName guifg=#e5a440 guibg=NONE guisp=NONE gui=NONE cterm=NONE
  hi vimFunction guifg=#e5a440 guibg=NONE guisp=NONE gui=NONE cterm=NONE
  hi vimOperParen guifg=#99b05f guibg=NONE guisp=NONE gui=NONE cterm=NONE
  hi vimOption guifg=#e5a440 guibg=NONE guisp=NONE gui=NONE cterm=NONE
  hi vimLet guifg=#e56b55 guibg=NONE guisp=NONE gui=NONE cterm=NONE
  hi vimOption guifg=#e5a440 guibg=NONE guisp=NONE gui=NONE cterm=NONE
  hi vimSetEqual guifg=#99b05f guibg=NONE guisp=NONE gui=NONE cterm=NONE
  hi vimAutoCmd guifg=#e56b55 guibg=NONE guisp=NONE gui=NONE cterm=NONE
  hi tomlTable guifg=#e18245 guibg=NONE guisp=NONE gui=NONE cterm=NONE
  hi diffAdded guifg=#99b05f guibg=NONE guisp=NONE gui=NONE cterm=NONE
  hi diffRemoved guifg=#e56b55 guibg=NONE guisp=NONE gui=NONE cterm=NONE
  hi diffChanged guifg=#e18245 guibg=NONE guisp=NONE gui=NONE cterm=NONE
  hi diffOldFile guifg=#bfab36 guibg=NONE guisp=NONE gui=NONE cterm=NONE
  hi diffNewFile guifg=#e5a440 guibg=NONE guisp=NONE gui=NONE cterm=NONE
  hi diffFile guifg=#99b05f guibg=NONE guisp=NONE gui=NONE cterm=NONE
  hi! link diffLine Comment
  hi helpHyperTextEntry guifg=#e56b55 guibg=NONE guisp=NONE gui=NONE cterm=NONE
  hi! link helpSectionDelim Comment
  hi helpNote guifg=#949fb4 guibg=NONE guisp=NONE gui=NONE cterm=NONE
  hi helpURL guifg=#bfab36 guibg=NONE guisp=NONE gui=underline cterm=underline
  hi helpCommand guifg=#e18245 guibg=NONE guisp=NONE gui=NONE cterm=NONE
  hi helpExample guifg=#bfab36 guibg=NONE guisp=NONE gui=NONE cterm=NONE
  hi ALEWarningSign guifg=#e18245 guibg=#473f31 guisp=NONE gui=NONE cterm=NONE
  hi ALEErrorSign guifg=#e56b55 guibg=#473f31 guisp=NONE gui=NONE cterm=NONE
  hi ALEInfoSign guifg=#949fb4 guibg=#473f31 guisp=NONE gui=NONE cterm=NONE
  hi ALEError guifg=NONE guibg=#562022 guisp=NONE gui=NONE cterm=NONE
  hi ALEWarning guifg=NONE guibg=#512c13 guisp=NONE gui=NONE cterm=NONE
  hi ALEVirtualTextError guifg=#87765d guibg=NONE guisp=NONE gui=NONE cterm=NONE
  hi ALEVirtualTextWarning guifg=#87765d guibg=NONE guisp=NONE gui=NONE cterm=NONE
  hi ALEVirtualTextInfo guifg=#87765d guibg=NONE guisp=NONE gui=NONE cterm=NONE
  hi! link ALEVirtualTextStyleError ALEVirtualTextError
  hi! link ALEVirtualTextStyleWarning ALEVirtualTextWarning
  hi CocHighlightText guifg=NONE guibg=NONE guisp=NONE gui=bold ctermfg=NONE ctermbg=NONE cterm=bold
  hi CocCodeLens guifg=#87765d guibg=NONE guisp=NONE gui=NONE cterm=NONE
  hi! link CocErrorSign ALEErrorSign
  hi! link CocWarningSign ALEWarningSign
  hi! link CocInfoSign ALEInfoSign
  hi! link CocHintSign Label
  hi! link CocErrorHighlight ALEError
  hi! link CocWarningHighlight ALEWarning
  hi! link CocInfoHighlight ALEInfo
  hi! link CocWarningVirtualText ALEVirtualTextWarning
  hi! link CocErrorVirtualText ALEVirtualTextError
  hi! link CocInfoVirtualText ALEVirtualTextInfo
  hi! link CocHintVirtualText ALEVirtualTextInfo
  hi! link CocCodeLens ALEVirtualTextInfo
  hi NERDTreeDirSlash guifg=#bfab36 guibg=NONE guisp=NONE gui=NONE cterm=NONE
  hi! link NERDTreeLinkFile Comment
  hi NERDTreeLinkTarget guifg=#99b05f guibg=NONE guisp=NONE gui=NONE cterm=NONE
  hi MatchParenCur guifg=NONE guibg=NONE guisp=NONE gui=bold ctermfg=NONE ctermbg=NONE cterm=bold
  hi MatchWord guifg=NONE guibg=NONE guisp=NONE gui=underline ctermfg=NONE ctermbg=NONE cterm=underline
  hi MatchWordCur guifg=NONE guibg=NONE guisp=NONE gui=underline ctermfg=NONE ctermbg=NONE cterm=underline
  hi StartifyNumber guifg=#e5a440 guibg=NONE guisp=NONE gui=NONE cterm=NONE
  hi StartifyFile guifg=#d4b07b guibg=NONE guisp=NONE gui=NONE cterm=NONE
  hi StartifySlash guifg=#bfab36 guibg=NONE guisp=NONE gui=NONE cterm=NONE
  hi StartifySpecial guifg=#bfab36 guibg=NONE guisp=NONE gui=NONE cterm=NONE
  hi Sneak guifg=NONE guibg=#303a1a guisp=NONE gui=NONE cterm=NONE
  if !s:italics
    hi VisualNOS gui=NONE cterm=NONE
    hi Comment gui=NONE cterm=NONE
    hi SpecialComment gui=NONE cterm=NONE
    hi markdownItalic gui=NONE cterm=NONE
    hi htmlItalic gui=NONE cterm=NONE
  endif
  unlet s:t_Co s:italics
  finish
endif

