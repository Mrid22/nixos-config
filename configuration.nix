{
  config,
  pkgs,
  inputs,
  ...
}:

{
  imports = [
    ./hardware-configuration.nix
    ./gaming.nix
  ];
  nix.settings.experimental-features = [
    "nix-command"
    "flakes"
  ];
  boot.loader = {
    systemd-boot.enable = true;
    efi.canTouchEfiVariables = true;
  };

  networking.hostName = "nixos";
  services = {
    jellyfin.enable = true;
    keyd = {
      enable = true;
      keyboards.default = {
        ids = [ "*" ];
        settings.main = {
          capslock = "overload(control,escape)";
        };
      };
    };

    # Enable the X11 windowing system.
    xserver.enable = true;

    # Enable the GNOME Desktop Environment.
    displayManager.gdm.enable = true;
    desktopManager.gnome.enable = true;

    # Configure keymap in X11
    xserver.xkb = {
      layout = "us";
      variant = "";
    };

    # Enable CUPS to print documents.
    printing.enable = true;

    # Enable sound with pipewire.
    pulseaudio.enable = false;
    pipewire = {
      enable = true;
      alsa = {
        enable = true;
        support32Bit = true;
      };
      pulse.enable = true;
    };
  };

  gaming = {
    enable = true;
    nvidia = true;
    xbox-controller = true;
  };

  hardware.bluetooth = {
    enable = true;
    powerOnBoot = true;
  };
  # Enable networking

  home-manager = {
    extraSpecialArgs = { inherit inputs; };
    users = {
      "mridula" = import ./home.nix;
    };
  };

  networking.networkmanager.enable = true;

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
  security.rtkit.enable = true;

  users.users.mridula = {
    isNormalUser = true;
    description = "Mridul Agarwal";
    extraGroups = [
      "networkmanager"
      "wheel"
    ];
  };

  programs = {
    hyprland.enable = true;
    neovim = {
      enable = true;
      defaultEditor = true;
    };
    firefox.enable = true;
  };
  nixpkgs.config.allowUnfree = true;

  environment.systemPackages = with pkgs; [
    playerctl
    wl-clipboard
    kitty
  ];
  system.stateVersion = "25.05";
}
