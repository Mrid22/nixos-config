{
  pkgs,
  inputs,
  ...
}: let
  wrappedpkgs = inputs.self.packages.${pkgs.stdenv.hostPlatform.system};
in {
  imports = [
    ./hardware-configuration.nix
  ];
  boot.loader = {
    systemd-boot.enable = false;
    limine = {
      enable = true;
      efiSupport = true;
      efiInstallAsRemovable = true;
    };
  };

  networking = {
    hostName = "nixos";
    networkmanager.enable = true;
  };

  time.timeZone = "Asia/Famagusta";

  nix.settings = {
    experimental-features = ["nix-command" "flakes"];
    extra-substituters = ["https://vicinae.cachix.org"];
    extra-trusted-public-keys = ["vicinae.cachix.org-1:1kDrfienkGHPYbkpNj1mWTr7Fm1+zcenzgTizIcI3oc="];
  };
  nixpkgs.config.allowUnfree = true;
  hardware = {
    graphics = {
      enable = true;
      enable32Bit = true;
    };
    bluetooth = {
      enable = true;
      powerOnBoot = true;
    };
    nvidia = {
      modesetting.enable = true;
      open = true;
      powerManagement = {
        enable = true;
        finegrained = true;
      };
      prime = {
        intelBusId = "PCI:0:2:0";
        nvidiaBusId = "PCI:1:0:0";
        offload = {
          enable = true;
          enableOffloadCmd = true;
        };
      };
    };
  };

  stylix = {
    enable = true;
    base16Scheme = "${pkgs.base16-schemes}/share/themes/tokyo-night-dark.yaml";
    image = ./Wallpaper.jpg;
    opacity = {
      terminal = 0.5;
      desktop = 0.5;
      applications = 0.5;
      popups = 0.5;
    };
  };

  services = {
    power-profiles-daemon.enable = true;
    btrfs.autoScrub = {
      enable = true;
      interval = "monthly";
      fileSystems = ["/"];
    };

    xserver = {
      enable = true;
      videoDrivers = ["nvidia"];
    };
    displayManager.gdm.enable = true;
    printing.enable = true;
    pipewire = {
      enable = true;
      pulse.enable = true;
    };
    keyd = {
      enable = true;
      keyboards = {
        default = {
          ids = ["*"];
          settings.main.capslock = "overload(control, esc)";
        };
      };
    };
  };

  fonts.packages = with pkgs; [
    nerd-fonts.fira-code
  ];

  users = {
    defaultUserShell = wrappedpkgs.zsh;
    users.mridula = {
      isNormalUser = true;
      extraGroups = ["wheel"];
    };
  };

  programs = {
    nh = {
      enable = true;
      flake = "/home/mridula/nixos-config";
      clean = {
        enable = true;
        extraArgs = "--keep 3 --keep-since 3d";
      };
    };
    neovim = {
      enable = true;
      defaultEditor = true;
    };
    hyprland = {
      enable = true;
      withUWSM = true;
    };
  };
  environment.systemPackages = with pkgs; [
    godot
    blender
    wrappedpkgs.git
    wrappedpkgs.kitty
    wrappedpkgs.starship
    swayosd
  ];
  system.stateVersion = "25.11";
}
