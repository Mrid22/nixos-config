{
  config,
  pkgs,
  inputs,
  ...
}: {
  imports = [
    ./hardware-configuration.nix
    ./config/homelab.nix
    ./config/system.nix
    inputs.sops-nix.nixosModules.sops
    inputs.selfhostblocks.nextcloud
  ];
  services.keyd = {
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

  sops = {
    defaultSopsFile = ./secrets/secrets.yaml;
    defaultSopsFormat = "yaml";
    age.keyFile = "~/.config/sops/age/keys.txt";
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
    adb.enable = true;
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
  fonts.packages = with pkgs.nerd-fonts; [
    fira-code
  ];
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
      sops
    ];
    sessionVariables = {
      STEAM_EXTRA_COMPAT_TOOLS_PATHS = "\${HOME}/.steam/root/compatibilitytools.d";
    };
  };
}
