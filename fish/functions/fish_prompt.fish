# Defined interactively
function fish_prompt
    set -l __last_command_exit_status $status

    if not set -q -g __fish_robbyrussell_functions_defined
        set -g __fish_robbyrussell_functions_defined
        function _git_branch_name
            set -l branch (git symbolic-ref --quiet HEAD 2>/dev/null)
            if set -q branch[1]
                echo (string replace -r '^refs/heads/' '' $branch)
            else
                echo (git rev-parse --short HEAD 2>/dev/null)
            end
        end

        function _is_git_dirty
            echo (git status -s --ignore-submodules=dirty 2>/dev/null)
        end

        function _is_git_repo
            type -q git
            or return 1
            git rev-parse --git-dir >/dev/null 2>&1
        end

        function _hg_branch_name
            echo (hg branch 2>/dev/null)
        end

        function _is_hg_dirty
            echo (hg status -mard 2>/dev/null)
        end

        function _is_hg_repo
            fish_print_hg_root >/dev/null
        end

        function _repo_branch_name
            _$argv[1]_branch_name
        end

        function _is_repo_dirty
            _is_$argv[1]_dirty
        end

        function _repo_type
            if _is_hg_repo
                echo hg
                return 0
            else if _is_git_repo
                echo git
                return 0
            end
            return 1
        end
    end

    set -l cyan (set_color -o cyan)
    set -l brcyan (set_color -o brcyan)
    set -l yellow (set_color -o yellow)
    set -l red (set_color -o red)
    set -l green (set_color -o green)
    set -l brgreen (set_color -u brgreen)
    set -l magenta (set_color -o magenta)
    set -l brmagenta (set_color -u brmagenta)
    set -l blue (set_color -o blue)
    set -l normal (set_color normal)

    set -l arrow_color "$green"
    if test $__last_command_exit_status != 0
        set arrow_color "$red"
    end

    set -l cwd $magenta(basename (prompt_pwd))

    set -l arrow "$arrow_color➜ "
    if test "$USER" = root
        set arrow "$arrow_color# "
    end

    set -l repo_info
    if set -l repo_type (_repo_type)
        set -l repo_branch $green(_repo_branch_name $repo_type)
        set repo_info "$magenta ($repo_branch $green✓$magenta)"

        set -l dirty (_is_repo_dirty $repo_type)
        if test -n "$dirty"
            set -l repo_branch $red(_repo_branch_name $repo_type)
            set repo_info "$magenta ($repo_branch $red✗$magenta)"
        end
    end

    echo -n -s  $cwd $repo_info $normal ' ' $arrow $normal
end
