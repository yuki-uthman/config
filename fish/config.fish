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
set -g SPACEFISH_PROMPT_SEPARATE_LINE false
set -g SPACEFISH_GIT_PREFIX ""

# Alias
alias tx='tmuxinator'
alias anonymous='tx anonymous'
alias gstatus='nvim -c Gstatus'
alias v='vifm .'
alias now='nvim ~/.zettel/now.md'
