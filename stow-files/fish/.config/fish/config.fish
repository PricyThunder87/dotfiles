if status is-interactive
    # Commands to run in interactive sessions can go here
    starship init fish | source

    # Remove greeting message
    function fish_greeting
    end

    # Start SSH agent
    eval (ssh-agent -c) >/dev/null 2>&1
    ssh-add ~/.ssh/personal-github-key >/dev/null 2>&1
    ssh-add ~/.ssh/school-gitlab-key >/dev/null 2>&1

    # Yazi alias
    function y
        set tmp (mktemp -t "yazi-cwd.XXXXXX")
        command yazi $argv --cwd-file="$tmp"
        if read -z cwd <"$tmp"; and [ "$cwd" != "$PWD" ]; and test -d "$cwd"
            builtin cd -- "$cwd"
        end
        rm -f -- "$tmp"
    end

    # Aliases
    alias su "su -m"
    alias cat bat

    # Set neovim as default editor 
    set -gx EDITOR nvim
    set -gx VISUAL nvim
end
