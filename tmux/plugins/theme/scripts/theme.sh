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

  # show_left_icon=$(get_tmux_option "@dracula-show-left-icon" smiley)
  # Handle left icon configuration
  # case $show_left_icon in
  #     smiley)
  #         left_icon="☺";;
  #     session)
  #         left_icon="#S";;
  #     window)
  #         left_icon="#W";;
  #     *)
  #         left_icon=$show_left_icon;;
  # esac
  # tmux set-option -g status-left "#[bg=${green},fg=${dark_gray}]#{?client_prefix,#[bg=${yellow}],} ${left_icon}"

  # show_left_sep=$(get_tmux_option "@dracula-show-left-sep" )
  # show_right_sep=$(get_tmux_option "@dracula-show-right-sep" )
  # show_powerline=$(get_tmux_option "@dracula-show-powerline" false)
  # # Handle powerline option
  # if $show_powerline; then
  #     right_sep="$show_right_sep"
  #     left_sep="$show_left_sep"
  # fi


  # Dracula Color Pallette
  white='#f8f8f2'
  gray='#44475a'
  dark_gray='#282a36'
  light_purple='#bd93f9'
  cyan='#8be9fd'
  green='#50fa7b'
  orange='#ffb86c'
  pink='#ff79c6'
  yellow='#f1fa8c'

  status_left_color=$(get_tmux_option "@status_left_color" "colour57")
  current_window_color=$()
  last_window_color=$()


  # set length
  # tmux set-option -g status-left-length 100
  # tmux set-option -g status-right-length 100

  # pane border styling
  # if $show_border_contrast; then
  #   tmux set-option -g pane-active-border-style "fg=${light_purple}"
  # else
    # tmux set-option -g pane-active-border-style "fg=${dark_purple}"
  # fi
  # tmux set-option -g pane-border-style "fg=${gray}"

  # message styling
  # tmux set-option -g message-style "bg=${gray},fg=${white}"

  # status bar
  # tmux set-option -g status-style "bg=${gray},fg=${white}"

  # tmux set-window-option -g window-status-format "#[fg=${white}]#[bg=${gray}] #I #W${flags}"
  # tmux set-window-option -g window-status-activity-style "bold"
  # tmux set-window-option -g window-status-bell-style "bold"

  black="black"
  red='#ff5555'
  red="#cd5c5c"
  gray='#444444'
  white='#ffffff'
  purple="#8700ff"
  dark_purple="#5f00ff"
  light_purple='#bd93f9'
  plum="#ffafff"
  fuchsia="#ff00ff"

  status_left_color=$(get_tmux_option "@status-left-color" $dark_purple)
  current_window_color=$(get_tmux_option "@current-window-color" $light_purple)
  last_window_color=$(get_tmux_option "@last-window-color" $light_purple)
  zoom_window_color=$(get_tmux_option "@zoom-window-color" $red)


  ## Status Bar
  tmux set-option -g status-position bottom
  tmux set-option -g status-justify left
  tmux set-option -g status-bg "${gray}"
  tmux set-option -g status-fg "${white}"

  # Status left
  tmux set-option -g status-left-length 50
  tmux set-option -g status-left "#[bg=${status_left_color}]#[fg=default] #S 🍎 #{=/-10/~∕...:pane_current_path} #[default] "

  # Status right
  tmux set-option -g status-right " #[fg=${light_purple}]#($current_dir/quran.sh)#[default] #[fg=${red}]#($current_dir/ramadhan.sh)#[default] #(date '+%a %d %b %I:%M') #($current_dir/day_or_night.sh) "

  # Window
  tmux setw -g window-status-current-style "fg=${black},bg=${current_window_color}"
  tmux setw -g window-status-current-format "#{?window_zoomed_flag,#[bg=${zoom_window_color}],#[fg=${black}]} #I:#W "
  tmux setw -g window-status-format "#{?window_last_flag,#[fg=${last_window_color}],#[fg=default]}#I:#W"

  # Pane style
  tmux set-option -g pane-active-border-style "fg=${light_purple}"
  tmux set-option -g pane-border-style "fg=${gray}"

  # Message styling
  tmux set-option -g message-style "bg=${dark_purple},fg=${white}"

}

# run main function
main
