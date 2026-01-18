if status is-interactive
  # Commands to run in interactive sessions can go here
  starship init fish | source

  # Remove greeting message
  function fish_greeting
  end
  
  # Yazi alias
  function y
    set tmp (mktemp -t "yazi-cwd.XXXXXX")
    command yazi $argv --cwd-file="$tmp"
    if read -z cwd < "$tmp"; and [ "$cwd" != "$PWD" ]; and test -d "$cwd"
      builtin cd -- "$cwd"
    end
    rm -f -- "$tmp"
  end

  # Set neovim as default editor 
  set -gx EDITOR nvim
  set -gx VISUAL nvim
end
