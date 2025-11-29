{
  config,
  pkgs,
  inputs,
  ...
}: {
  imports = [
    ./hardware-configuration.nix
    ./config/homelab/homelab.nix
    ./config/system.nix
    inputs.stylix.nixosModules.stylix
  ];

  stylix = {
    enable = true;
    base16Scheme = "${pkgs.base16-schemes}/share/themes/tokyo-night-storm.yaml";
    overlays.enable = true;
    image = ./Wallpaper.jpg;
    polarity = "dark";
    opacity = {
      terminal = 0.5;
    };
  };

  fonts.packages = with pkgs; [
    nerd-fonts.droid-sans-mono
  ];

  services.keyd = {
    enable = true;
    keyboards = {
      default = {
        ids = ["*"];
        settings = {
          main = {
            capslock = "overload(control,escape)";
          };
        };
      };
    };
  };

  users = {
    defaultUserShell = pkgs.zsh;
    users.mridula = {
      isNormalUser = true;
      description = "Mridul Agarwal";
      extraGroups = ["networkmanager" "wheel"];
    };
  };

  home-manager = {
    extraSpecialArgs = {inherit inputs;};
    users = {
      "mridula" = import ./home.nix;
    };
    backupFileExtension = ".bak";
  };

  programs = {
    gpu-screen-recorder.enable = true;

    firefox.enable = true;
    hyprland.enable = true;
    zsh.enable = true;
    gnome-disks.enable = true;
    neovim = {
      enable = true;
      defaultEditor = true;
    };
    steam = {
      enable = true;
      gamescopeSession.enable = true;
      protontricks.enable = true;
    };
    gamemode.enable = true;
  };

  environment.systemPackages = with pkgs; [
    wl-clipboard
    sops
    netbeans
    cloudflared
    ntfs3g
    spotdl
    playerctl
    brightnessctl
  ];
}
