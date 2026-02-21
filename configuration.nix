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

  hardware.bluetooth = {
    enable = true;
    powerOnBoot = true;
  };

  stylix = {
    enable = true;
    base16Scheme = "${pkgs.base16-schemes}/share/themes/tokyo-night-dark.yaml";
    image = ./Wallpaper.jpg;
    opacity = {
      terminal = 0.5;
      desktop = 0.5;
    };
  };

  services = {
    xserver.enable = true;
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
    vim
    wget
    zinit
    wrappedpkgs.git
    wrappedpkgs.kitty
    wrappedpkgs.starship
  ];
  system.stateVersion = "25.11";
}
