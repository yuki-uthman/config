#!/usr/bin/env bash

get_tmux_option() {
  local option=$1
  local default_value=$2
  local option_value=$(tmux show-option -gqv "$option")
  if [ -z $option_value ]; then
    echo $default_value
  else
    echo $option_value
  fi
}

main()
{
  # set current directory variable
  current_dir="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"

  # Dracula Color Pallette
  white='#f8f8f2'
  gray='#44475a'
  dark_gray='#282a36'
  light_purple='#bd93f9'
  dark_purple='#6272a4'
  cyan='#8be9fd'
  green='#50fa7b'
  orange='#ffb86c'
  pink='#ff79c6'
  yellow='#f1fa8c'

  black="#000000"
  red='#ff5555'
  red="#cd5c5c"
  gray='#444444'
  white='#ffffff'
  purple="#8600ff"
  dark_purple="#5f00ff"
  dracula_purple='#bb52fd'
  light_purple='#bd93f9'
  plum="#ffafff"
  fuchsia="#ff00ff"

  theme_color=$(get_tmux_option "@theme-color" $purple)
  status_left_color=$(get_tmux_option "@status-left-color" $dracula_purple)
  current_window_color=$(get_tmux_option "@current-window-color" $light_purple)
  last_window_color=$(get_tmux_option "@last-window-color" $cyan)
  zoom_window_color=$(get_tmux_option "@zoom-window-color" $red)


  ## Status Bar
  tmux set-option -g status-position bottom
  tmux set-option -g status-justify left
  tmux set-option -g status-bg "${gray}"
  tmux set-option -g status-fg "${white}"

  # Status left
  tmux set-option -g status-left-length 50
  tmux set-option -g status-left "#[bg=${theme_color}]#[fg=default] #S #[default]"

  # Status right
  tmux set-option -g status-right-length 100
  tmux set-option -g  status-right "#[fg=${dark_gray},bg=${pink}] #($current_dir/battery.rb) "
	tmux set-option -ga status-right "#[fg=${dark_gray},bg=${cyan}] #($current_dir/ram_info.sh) "
	tmux set-option -ga status-right "#[fg=${dark_gray},bg=${orange}] #($current_dir/cpu_info.sh) "
  tmux set-option -ga status-right "#[bg=${theme_color}]#[fg=default] #($current_dir/quran.sh) #($current_dir/ramadhan.sh) #(date '+%a %d %b %I:%M') #($current_dir/day_or_night.sh) "

  # Window
  tmux setw -g window-status-separator ""
  tmux setw -g window-status-current-style "fg=${black},bg=${current_window_color}"
  tmux setw -g window-status-current-format "#{?window_zoomed_flag,#[bg=${zoom_window_color}],#[fg=${black}]} #I:#W "
  tmux setw -g window-status-format "#{?window_last_flag,#[fg=${last_window_color}],#[fg=default]} #I:#W "

  # Pane style
  tmux set-option -g pane-active-border-style "fg=${light_purple}"
  tmux set-option -g pane-border-style "fg=${gray}"

  # Message styling
  tmux set-option -g message-style "bg=${theme_color},fg=${white}"

}

# run main function
main
