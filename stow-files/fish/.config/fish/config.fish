if status is-interactive
    # Use starship
    starship init fish | source

    # Enable Vi bindings
    set -g fish_key_bindings fish_vi_key_bindings
    bind --mode insert j,j 'set fish_bind_mode default; commandline -f repaint'
    bind --mode insert j,k 'set fish_bind_mode default; commandline -f repaint'
    bind H beginning-of-line
    bind L end-of-line

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

    # Render markdown to PDF using pandoc and weasyprint. Supports mermaid.js.
    # Dependencies: pandoc, weasyprint (via python), mermaid-cli (via npm),
    #   chrome-headless-shell (npx puppeteer@23.11.1 browsers install chrome-headless-shell)
    function mdpdf
	if test (count $argv) -eq 0
	    echo "Usage: mdpdf <input.md>"
	    return 1
	end

	set input $argv[1]
	set output (string replace -r '\.md$' '.pdf' $input)
	set tmphtml (mktemp -t "mdpdf.XXXXXX.html")

	pandoc $input \
	    -f markdown+lists_without_preceding_blankline \
	    -o $tmphtml \
	    --standalone \
	    --embed-resources \
	    --css ~/.dotfiles/github-markdown.css \
	    --template ~/.dotfiles/github-markdown.html \
	    --lua-filter ~/.dotfiles/mermaid.lua

	weasyprint $tmphtml $output

	rm -f $tmphtml
	echo "Created $output"
    end

    # =============================================================================
    #
    # Utility functions for zoxide.
    #

    # pwd based on the value of _ZO_RESOLVE_SYMLINKS.
    function __zoxide_pwd
	builtin pwd -L
    end

    # A copy of fish's internal cd function. This makes it possible to use
    # `alias cd=z` without causing an infinite loop.
    if ! builtin functions --query __zoxide_cd_internal
	if status list-files functions/cd.fish &>/dev/null
	    status get-file functions/cd.fish | string replace --regex -- '^function cd\s' 'function __zoxide_cd_internal ' | source
	else
	    string replace --regex -- '^function cd\s' 'function __zoxide_cd_internal ' <$__fish_data_dir/functions/cd.fish | source
	end
    end

    # cd + custom logic based on the value of _ZO_ECHO.
    function __zoxide_cd
	if set -q __zoxide_loop
	    builtin echo "zoxide: infinite loop detected"
	    builtin echo "Avoid aliasing `cd` to `z` directly, use `zoxide init --cmd=cd fish` instead"
	    return 1
	end
	__zoxide_loop=1 __zoxide_cd_internal $argv
    end

    # =============================================================================
    #
    # Hook configuration for zoxide.
    #

    # Initialize hook to add new entries to the database.
    function __zoxide_hook --on-variable PWD
	test -z "$fish_private_mode"
	and command zoxide add -- (__zoxide_pwd)
    end

    # =============================================================================
    #
    # When using zoxide with --no-cmd, alias these internal functions as desired.
    #

    # Jump to a directory using only keywords.
    function __zoxide_z
	set -l argc (builtin count $argv)
	if test $argc -eq 0
	    __zoxide_cd $HOME
	else if test "$argv" = -
	    __zoxide_cd -
	else if test $argc -eq 1 -a -d $argv[1]
	    __zoxide_cd $argv[1]
	else if test $argc -eq 2 -a $argv[1] = --
	    __zoxide_cd -- $argv[2]
	else
	    set -l result (command zoxide query --exclude (__zoxide_pwd) -- $argv)
	    and __zoxide_cd $result
	end
    end

    # Completions.
    function __zoxide_z_complete
	set -l tokens (builtin commandline --current-process --tokenize)
	set -l curr_tokens (builtin commandline --cut-at-cursor --current-process --tokenize)

	if test (builtin count $tokens) -le 2 -a (builtin count $curr_tokens) -eq 1
	    # If there are < 2 arguments, use `cd` completions.
	    complete --do-complete "'' "(builtin commandline --cut-at-cursor --current-token) | string match --regex -- '.*/$'
	else if test (builtin count $tokens) -eq (builtin count $curr_tokens)
	    # If the last argument is empty, use interactive selection.
	    set -l query $tokens[2..-1]
	    set -l result (command zoxide query --exclude (__zoxide_pwd) --interactive -- $query)
	    and __zoxide_cd $result
	    and builtin commandline --function cancel-commandline repaint
	end
    end
    complete --command __zoxide_z --no-files --arguments '(__zoxide_z_complete)'

    # Jump to a directory using interactive search.
    function __zoxide_zi
	set -l result (command zoxide query --interactive -- $argv)
	and __zoxide_cd $result
    end

    # =============================================================================
    #
    # Commands for zoxide. Disable these using --no-cmd.
    #

    abbr --erase z &>/dev/null
    complete --erase --command z
    alias z=__zoxide_z

    abbr --erase zi &>/dev/null
    complete --erase --command zi
    alias zi=__zoxide_zi

    zoxide init fish --cmd=cd | source

    # Aliases
    alias gittree "git ls-files | tree --fromfile -a"
    alias nv "nvim"
    alias su "su -m"
    alias cat bat
    alias ga "git add"
    alias gc "git commit"
    alias gcm "git commit -m"
    alias gp "git push"

    # Line counter (ignores empty lines and comments)
    function countlines
	set total 0
	for file in $argv
	    set count (grep -Ev '^\s*((//)|#|$)' $file | wc -l)
	    printf "%s: %d\n" $file $count
	    set total (math $total + $count)
	end
	echo "Total: $total"
    end

    # Set neovim as default editor
    set -gx EDITOR nvim
    set -gx VISUAL nvim

    # Auto-start tmux
    if test -z "$TMUX"
	if tmux has-session -t main 2>/dev/null
	    # Find a window not currently viewed by any attached session
	    set -l all_windows (tmux list-windows -t main -F '#{window_index}')
	    set -l used_windows (tmux list-sessions -f '#{==:#{session_group},main}' -F '#{?session_attached,#{window_index},}' 2>/dev/null | string match -rv '^$')

	    set -l free_window ""
	    for w in $all_windows
		if not contains $w $used_windows
		    set free_window $w
		    break
		end
	    end

	    if test -n "$free_window"
		exec tmux new-session -t main \; select-window -t "$free_window"
	    else
		exec tmux new-session -t main \; new-window
	    end
	else
	    exec tmux new-session -s main
	end
    end

    export MUSIC_HUB_CONNECTION_STRING="Host=localhost;Port=5432;Database=musichub;Username=musichub_user;Password=password"
end
