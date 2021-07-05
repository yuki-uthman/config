function zz
  if test -z $argv

    # if arg is not given use fzf
    set -l result ( __fzf_dir $argv )
    if test -n $result
      z $result
    end

  else 

    # if arg is given use z right away
    z $argv
  end

end
