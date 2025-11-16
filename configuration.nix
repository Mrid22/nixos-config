# Edit this configuration file to define what should be installed on
# your system.  Help is available in the configuration.nix(5) man page
# and in the NixOS manual (accessible by running ‘nixos-help’).

{
  config,
  pkgs,
  inputs,
  ...
}:

{
  imports = [
    # Include the results of the hardware scan.
    ./hardware-configuration.nix
    ./gaming.nix
  ];
  nix.settings.experimental-features = [
    "nix-command"
    "flakes"
  ];
  boot.loader = {
    # Bootloader.
    systemd-boot.enable = true;
    efi.canTouchEfiVariables = true;
  };

  networking.hostName = "nixos";
  services = {
    # Define your hostname.
    # networking.wireless.enable = true;  # Enables wireless support via wpa_supplicant.
    jellyfin.enable = true;

    keyd = {
      enable = true;
      keyboards = {
        # The name is just the name of the configuration file, it does not really matter
        default = {
          ids = [ "*" ]; # what goes into the [id] section, here we select all keyboards
          # Everything but the ID section:
          settings = {
            # The main layer, if you choose to declare it in Nix
            main = {
              capslock = "overload(control,escape)"; # you might need to also enclose the key in quotes if it contains non-alphabetical symbols
            };
          };
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
