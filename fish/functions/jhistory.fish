function jhistory
  set dir ( cat ~/.local/share/fish/fish_cd_history | fzf +m )
  if test -n "$dir"
    cd $dir
  end
end
