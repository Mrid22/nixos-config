{
  config,
  pkgs,
  inputs,
  ...
}: {
  imports = [
    ./hardware-configuration.nix
    ./config/homelab.nix
    ./config/hardware.nix
  ];

  services = {
    xserver = {
      enable = true;
      videoDrivers = ["nvidia"];
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
          ids = ["*"];
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
    extraSpecialArgs = {inherit inputs;};
    useGlobalPkgs = true;
    sharedModules = with inputs; [
      nvf.homeManagerModules.default
      vicinae.homeManagerModules.default
    ];
    users = {
      "mridula" = import ./home.nix;
    };
  };
  stylix = {
    enable = true;
    image = ./Wallpaper.jpg;
    base16Scheme = "${pkgs.base16-schemes}/share/themes/tokyo-night-dark.yaml";
    opacity = {
      desktop = 0.5;
      terminal = 0.5;
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
      beeper
      playerctl
      brightnessctl
      pnpm
      nodejs
      netbeans
      kdePackages.dolphin
    ];
    sessionVariables = {
      STEAM_EXTRA_COMPAT_TOOLS_PATHS = "\${HOME}/.steam/root/compatibilitytools.d";
    };
  };
  system = {
    stateVersion = "25.05";
    autoUpgrade = {
      enable = true;
      flake = inputs.self.outPath;
      flags = [
        "-L"
      ];
      dates = "02:00";
      randomizedDelaySec = "45min";
    };
  };
}
