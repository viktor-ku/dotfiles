{pkgs, ...}: {
  imports = [
    # Include the results of the hardware scan.
    ./hardware-configuration.nix
  ];

  # Bootloader
  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;

  boot.kernelPackages = pkgs.myLinux;
  boot.resumeDevice = "/dev/disk/by-uuid/2e5d42f0-b9c5-43a8-a4f6-e74594b8ede5";

  services.logind.settings = {
    Login = {
      HandlePowerKey = "hibernate";
    };
  };

  networking = {
    hostName = "purrstation";
    networkmanager.enable = true;

    # Let NM handle resolv.conf itself:
    networkmanager.dns = "default";

    # Force these nameservers system-wide
    nameservers = ["8.8.8.8" "8.8.4.4" "1.1.1.1"];
  };

  time.timeZone = "Europe/Tallinn";

  i18n.defaultLocale = "en_US.UTF-8";

  i18n.extraLocaleSettings = {
    LC_ADDRESS = "et_EE.UTF-8";
    LC_IDENTIFICATION = "et_EE.UTF-8";
    LC_MEASUREMENT = "et_EE.UTF-8";
    LC_MONETARY = "et_EE.UTF-8";
    LC_NAME = "et_EE.UTF-8";
    LC_NUMERIC = "et_EE.UTF-8";
    LC_PAPER = "et_EE.UTF-8";
    LC_TELEPHONE = "et_EE.UTF-8";
    LC_TIME = "et_EE.UTF-8";
  };

  users.groups.overlords = {
    gid = 20250;
  };

  users.users.victoria = {
    isNormalUser = true;
    description = "Victoria with C";
    extraGroups = ["networkmanager" "wheel" "video" "audio" "overlords"];
    shell = pkgs.fish;
  };

  systemd.tmpfiles.rules = [
    "Z /etc/nixos  0770 root overlords -"
  ];

  programs.fish.enable = true;
  programs.neovim.enable = true;

  nixpkgs.config.allowUnfree = true;

  environment.systemPackages = with pkgs; [
    # tools
    wget
    curl
    bash
    fish
    git
    gping
    btop
    eza
    tree
    wev
    vim
    pavucontrol
    gcc15
    ffmpeg
    vlc

    # fonts
    font-awesome

    # browsers
    librewolf
    ungoogled-chromium

    # hyprland
    hyprpaper
    hyprlock
    dunst
    fuzzel
    wl-clipboard
    grim
    slurp
    swappy
    xdg-desktop-portal-hyprland
    xdg-desktop-portal-gtk
    xdg-desktop-portal
    dbus
  ];

  security.polkit.enable = true;

  fonts.packages = with pkgs; [
    noto-fonts
    noto-fonts-cjk-sans
    noto-fonts-emoji
    nerd-fonts.fira-code
  ];

  services.dbus.enable = true;
  programs.dconf.enable = true;

  xdg.portal = {
    enable = true;
    extraPortals = [
      pkgs.xdg-desktop-portal-hyprland
      pkgs.xdg-desktop-portal-gtk
    ];
    config = {
      common = {
        default = "*";
      };
    };
  };

  services.pipewire = {
    enable = true;

    alsa.enable = true;
    alsa.support32Bit = true;

    pulse.enable = true;
    wireplumber.enable = true;
  };

  powerManagement.cpuFreqGovernor = "schedutil";

  nix.settings.experimental-features = "nix-command flakes";

  nix.settings.max-jobs = 4;
  nix.settings.cores = 8;

  services.openssh.enable = true;

  services.xserver.enable = false;

  # This value determines the NixOS release from which the default
  # settings for stateful data, like file locations and database versions
  # on your system were taken. It‘s perfectly fine and recommended to leave
  # this value at the release version of the first install of this system.
  # Before changing this value read the documentation for this option
  # (e.g. man configuration.nix or on https://nixos.org/nixos/options.html).
  system.stateVersion = "25.05"; # Did you read the comment?
}
