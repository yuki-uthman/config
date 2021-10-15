function zf
  set -l result ( __fzf_dir $argv )
  if test -n $result
    z $result
  end
end
