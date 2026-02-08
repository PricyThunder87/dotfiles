if status is-interactive
    # Use starship
    starship init fish | source

    # Enable Vi bindings
    set -g fish_key_bindings fish_vi_key_bindings
    set -g fish_cursor_insert block
    bind --mode insert j,k 'set fish_bind_mode default; commandline -f repaint'

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

    # Auto-start tmux
    if test -z "$TMUX"
        tmux attach; or tmux new-session
    end
end
