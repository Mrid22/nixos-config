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
    ./server.nix
  ];
  nix.settings.experimental-features = [
    "nix-command"
    "flakes"
  ];
  boot.loader = {
    systemd-boot.enable = true;
    efi.canTouchEfiVariables = true;
  };

  networking = {
    hostName = "nixos"; # Define your hostname.
    networkmanager.enable = true;
  };

  time.timeZone = "Europe/Amsterdam";

  i18n = {
    defaultLocale = "en_US.UTF-8";
    extraLocaleSettings = {
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
  };

  services = {
    xserver = {
      enable = true;
      videoDrivers = [ "nvidia" ];
      xkb = {
        layout = "us";
        variant = "";
      };
    };
    udisks2.enable = true;
    upower.enable = true;
    displayManager.gdm.enable = true;
    printing.enable = true;
    keyd = {
      enable = true;
      keyboards = {
        default = {
          ids = [ "*" ];
          settings = {
            main = {
              capslock = "overload(control,esc)";
            };
          };
        };
      };
    };
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

  hardware = {
    bluetooth = {
      enable = true;
      powerOnBoot = true;
    };
    graphics = {
      enable = true;
      enable32Bit = true;
    };
    nvidia = {
      open = true;
      modesetting.enable = true;
      prime = {
        sync.enable = true;
        intelBusId = "PCI:0:2:0";
        nvidiaBusId = "PCI:1:0:0";
      };
    };
  };

  home-manager = {
    extraSpecialArgs = { inherit inputs; };
    useGlobalPkgs = true;
    sharedModules = [ inputs.nvf.homeManagerModules.default ];
    users = {
      "mridula" = import ./home.nix;
    };
  };
  security.rtkit.enable = true;

  fonts.packages = with pkgs.nerd-fonts; [
    fira-code
  ];

  users = {
    defaultUserShell = pkgs.zsh;
    users.mridula = {
      isNormalUser = true;
      description = "Mridul Agarwal";
      extraGroups = [
        "networkmanager"
        "wheel"
      ];
    };
  };

  programs = {
    hyprland.enable = true;
    gnome-disks.enable = true;
    zsh.enable = true;
    gamemode.enable = true;
    neovim = {
      enable = true;
      defaultEditor = true;
    };
    steam = {
      enable = true;
      gamescopeSession.enable = true;
    };
  };

  nixpkgs.config.allowUnfree = true;
  environment = {
    systemPackages = with pkgs; [
      kitty
      blueberry
      protonvpn-gui
      wireguard-tools
      mangohud
      protonup
    ];
    sessionVariables = {
      STEAM_EXTRA_COMPAT_TOOLS_PATHS = "\${HOME}/.steam/root/compatibilitytools.d";
    };
  };

  system.stateVersion = "25.05"; # Did you read the comment?

}
