# Path
fish_add_path ~/.local/bin
fish_add_path ~/.fzf/bin
fish_add_path ~/.flutter/bin
fish_add_path ~/.config/fish/bin

# use curl from Homebrew
fish_add_path /usr/local/opt/curl/bin

# asdf
source /usr/local/opt/asdf/asdf.fish


# Global variables
set -x BAT_THEME gruvbox
set -x FZF_DEFAULT_OPTS '--height 40% --layout=reverse'
set -gx EDITOR nvim
set -gx PYTHONPATH '/Users/Yuki/Programming/python/dsa'

# Alias
alias tx='tmuxinator'
alias anonymous='tx anonymous'
alias today='tx today'
alias scratch='nvim -c "ZetNew "'(date +%d/%B/%Y)'" :scratchpad"'

alias gstatus='nvim -c Git'
alias v='vifm'
alias mv_screenshots='v ~/.zettel ~/Desktop'
alias now='nvim ~/.zettel/now.md'
alias edit_deadlines='nvim ~/.zettel/deadlines.txt'


# initalize zoxide
zoxide init fish | source
