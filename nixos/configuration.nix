{ config, pkgs, inputs, ... }:

{
	imports = [
		./hardware-configuration.nix
	];

  # Bootloader
  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;

  networking.hostName = "nixos"; # Define your hostname.

  # Enable networking
  networking.networkmanager.enable = true;

	# Enable Wayland
	programs.xwayland.enable = true;

  # Tell Electron apps to use Wayland
  environment.sessionVariables = {
    NIXOS_OZONE_WL = "1";
  };

	# Enable the Niri Desktop Manager
  programs.niri.enable = true;
  xdg.portal.enable = true;
  xdg.portal.extraPortals = [
    pkgs.xdg-desktop-portal-gtk
  ];

	# Set display manager theme
	services.displayManager.sddm = {
		enable = true;
		wayland.enable = true;
	};

	# Enable keyring (Secrets manager)
	services.gnome.gnome-keyring.enable = true;
	security.pam.services.login.enableGnomeKeyring = true;

	# Enable Polkit (Permissions manager)
	security.polkit.enable = true;

	# Enable bluetooth
	hardware.bluetooth.enable = true;

  # Set your time zone.
  time.timeZone = "Europe/Amsterdam";

  # Select internationalisation properties.
  i18n.defaultLocale = "en_US.UTF-8";
  i18n.extraLocaleSettings = {
    LC_ADDRESS = "nl_NL.UTF-8";
    LC_IDENTIFICATION = "nl_NL.UTF-8";
    LC_MEASUREMENT = "nl_NL.UTF-8";
    LC_MONETARY = "nl_NL.UTF-8";
    LC_NAME = "nl_NL.UTF-8";
    LC_NUMERIC = "nl_NL.UTF-8";
    LC_PAPER = "nl_NL.UTF-8";
    LC_TELEPHONE = "nl_NL.UTF-8";
    LC_TIME = "nl_NL.UTF-8";
  };

  # Configure keymap in X11
  services.xserver.xkb = {
    layout = "au";
    variant = "";
  };

  # Enable CUPS to print documents.
  services.printing.enable = true;

  # Enable sound with pipewire.
  services.pulseaudio.enable = true;
  security.rtkit.enable = true;
  services.pipewire = {
    enable = false;
    alsa.enable = true;
    alsa.support32Bit = true;
    pulse.enable = true;
  };

  # Define a user account. Don't forget to set a password with ‘passwd’.
  users.users.noahsakko = {
    isNormalUser = true;
    description = "Noah Sakko";
    extraGroups = [ "networkmanager" "wheel" ];
  };

	# Remove sudo password from noahsakko
	security.sudo = {
		enable = true;
		extraRules = [
			{
				users = [ "noahsakko" ];
				commands = [
					{
						command = "ALL";
						options = [ "NOPASSWD" ];
					}
				];
			}
		];
	};

  nix.settings.experimental-features = ["nix-command" "flakes"];
  
  environment.systemPackages = with pkgs; [
		neovim
		firefox
		git
		kitty
	];

  fonts.packages = with pkgs; [
		jetbrains-mono
	];	

  nixpkgs.config.allowUnfree = true;

  system.stateVersion = "25.11";
}
