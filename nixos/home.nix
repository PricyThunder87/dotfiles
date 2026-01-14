{ config, pkgs, inputs, ... }:
let
	dotfiles = "/etc/nixos/config";
	create_symlink = path: config.lib.file.mkOutOfStoreSymlink path;
in
{
  imports = [
    inputs.nix4nvchad.homeManagerModule
  ];

	home.username = "noahsakko";
	home.homeDirectory = "/home/noahsakko";
	home.stateVersion = "25.11";

	fonts.fontconfig.enable = true;

	# Dotfile symlinks
	xdg.configFile."niri" = {
		source = create_symlink "${dotfiles}/niri/";
		recursive = true;
	};
	xdg.configFile."waybar" = 
	{ 
		source = create_symlink "${dotfiles}/waybar/";
		recursive = true;
	};
  
	# Program Configuration
	programs.bash = {
    enable = true;
    enableCompletion = true;
    shellAliases = {
      nrs = "sudo nixos-rebuild switch --flake .#nixos";
      rescan-wifi = "nmcli device wifi rescan";
    };

    # Commands to run on terminal startup
    initExtra = ''
      export EDITOR=nvim
      export VISUAL=nvim
      eval "$(starship init bash)"
      function y() {
				local tmp="$(mktemp -t "yazi-cwd.XXXXXX")" cwd
				command yazi "$@" --cwd-file="$tmp"
				IFS= read -r -d \'\' cwd < "$tmp"
				[ -n "$cwd" ] && [ "$cwd" != "$PWD" ] && builtin cd -- "$cwd"
				rm -f -- "$tmp"
      }
      '';
  };

	programs.kitty = {
    enable = true;
    settings = {
      editor = "neovim";

      strip_trailing_spaces = "smart";
      select_by_word_characters = "@-./_~?&=%+";

      background_opacity = 0.7;
      dynamic_background_opacity = true;
      background_blur = 1;
      confirm_os_window_close = 0;

      font_family = "JetBrains Mono";
      font_size = 11;

      cursor_trail = 1;

      background = "#111111";
      foreground = "#bde1ff";

      window_padding_width = 5;
    };
    keybindings = {
      "ctrl+shift+c" = "copy_or_interrupt";
    };
  };

	programs.starship = {
    enable = true;
    settings = builtins.fromTOML ( builtins.readFile ./config/starship/pastel.toml );
  };
  
  programs.nvchad = {
    enable = true;
    extraConfig = builtins.readFile ./config/nvim/init.lua;
  };

  programs.vim = {
    enable = true;
    extraConfig = ''
      :set number
      :set relativenumber
      :set shiftwidth=4
      :set autoindent
      :colorscheme habamax
    '';
  };

	# Package Declaration
	home.packages = with pkgs; [
		# Desktop
		niri
		swww
		rofi
		mako
		waybar
		hyprlock
		niriswitcher
		bibata-cursors
		
		# Text
		glow
		vscode
		obsidian
		libreoffice

 		# Web
		protonvpn-gui

		# File Management
		yazi
		xfce.thunar
		qbittorrent

		# Terminal
		btop
		starship
		fastfetch

		# Utilities
		bluez
		blueman
		wiremix
		playerctl
		alsa-utils
		pavucontrol
		brightnessctl

		# Media
		mpc-qt
		spotify

		# Social
		discord

    # Programming Languages
    dotnet-sdk_10
    ruby

    # Ruby Gems
    vimgolf

		# Libraries
		wget
		yarn
		ctags
		polkit
		nodejs
		ripgrep
		libnotify
		neovim-gtk
		xdg-desktop-portal-gnome

		# Fonts
		noto-fonts
		nerd-fonts.noto
		nerd-fonts.hack
		noto-fonts-color-emoji
	];
}
