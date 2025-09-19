{ pkgs, ... }:
{
  imports = [
    ./hardware-configuration.nix
  ];

  # Etc.
  system.stateVersion = "25.05";
  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;
  time.timeZone = "America/Los_Angeles";
  i18n.defaultLocale = "en_US.UTF-8";
  i18n.extraLocaleSettings = {
    LC_ADDRESS = "en_US.UTF-8";
    LC_IDENTIFICATION = "en_US.UTF-8";
    LC_MEASUREMENT = "en_US.UTF-8";
    LC_MONETARY = "en_US.UTF-8";
    LC_NAME = "en_US.UTF-8";
    LC_NUMERIC = "en_US.UTF-8";
    LC_PAPER = "en_US.UTF-8";
    LC_TELEPHONE = "en_US.UTF-8";
    LC_TIME = "en_US.UTF-8";
  };

  # Sets user and system identity.
  networking.hostName = "uwu";
  users.users.vanillin = {
    isNormalUser = true;
    description = "Vanillin Starskater";
    extraGroups = [
      "networkmanager"
      "wheel"
      "plugdev"
    ];
  };

  # Get's nvidia's stupid proprietary drivers working.
  hardware.graphics = {
    enable = true;
  };
  services.xserver.videoDrivers = [ "nvidia" ];
  hardware.nvidia = {
    modesetting.enable = true;
    open = true;
  };

  # Enables flakes, automates store optimization and garbage collection.
  nix.settings = {
    experimental-features = [
      "nix-command"
      "flakes"
    ];
    auto-optimise-store = true;
  };
  nix.gc = {
    automatic = true;
    dates = "daily";
    options = "--delete-older-than 2d";
  };

  # Sets up daemons.
  security.rtkit.enable = true;
  networking.networkmanager.enable = true;
  services.printing.enable = true;
  services.pipewire = {
    enable = true;
    alsa.enable = true;
    alsa.support32Bit = true;
    pulse.enable = true;
    jack.enable = true;
  };

  # Sets up programs.
  nixpkgs.config.allowUnfree = true;
  programs = {
    neovim.enable = true;
    waybar.enable = true;
    hyprland.enable = true;
    git.enable = true;
  };
  environment.systemPackages = with pkgs; [
    nixfmt-rfc-style
    polychromatic
    home-manager
    prismlauncher
    alacritty
    fastfetch
    librewolf
    keepassxc
    wayclip
    swaybg
    tofi
    nil
  ];
  fonts.packages = with pkgs; [
    nerd-fonts.hack
  ];
}
