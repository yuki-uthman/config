function zh
    set -l __zoxide_result (command zoxide query -i -- $argv)
    and z $__zoxide_result
end
