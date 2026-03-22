{
  flake.nixosModules.config = {
    pkgs,
    inputs,
    lib,
    ...
  }: let
    wrappedpkgs = inputs.self.packages.${pkgs.stdenv.hostPlatform.system};
  in {
    imports = [inputs.stylix.nixosModules.stylix];

    nix.settings = {
      experimental-features = ["nix-command" "flakes"];
      substituters = ["https://hyprland.cachix.org" "https://vicinae.cachix.org"];
      trusted-substituters = ["https://hyprland.cachix.org"];
      trusted-public-keys = [
        "hyprland.cachix.org-1:a7pgxzMz7+chwVL3/pzj6jIBMioiJM7ypFP8PwtkuGc="
        "vicinae.cachix.org-1:1kDrfienkGHPYbkpNj1mWTr7Fm1+zcenzgTizIcI3oc="
      ];
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
    };

    networking.networkmanager.enable = true;
    services = {
      udisks2.enable = true;
      gnome.gnome-keyring.enable = true;

      xserver.enable = true;

      keyd = {
        enable = true;
        keyboards.default = {
          ids = ["*"];
          settings.main.capslock = "overload(control,escape)";
        };
      };
      displayManager.gdm.enable = true;
    };

    stylix = {
      enable = true;
      base16Scheme = "${pkgs.base16-schemes}/share/themes/tokyo-night-dark.yaml";
      image = ./Wallpaper.jpg;
      opacity = {
        desktop = 0.5;
        terminal = 0.5;
        applications = 0.5;
        popups = 0.5;
      };
    };
    users = {
      defaultUserShell = wrappedpkgs.zsh;
      users.mridula = {
        isNormalUser = true;
        description = "Mridul Agarwal";
        extraGroups = ["wheel"];
      };
    };

    programs = {
      gamemode.enable = true;
      nh = {
        enable = true;
        flake = "/home/mridula/nixos-config";
      };
      steam = {
        enable = true;
        gamescopeSession.enable = true;
      };
      hyprland = {
        enable = true;
        package = inputs.hyprland.packages."${pkgs.stdenv.hostPlatform.system}".hyprland;
      };
    };

    fonts.packages = with pkgs; [
      nerd-fonts.fira-code
      nerd-fonts.droid-sans-mono
    ];

    nixpkgs.config.allowUnfreePredicate = pkg:
      builtins.elem (lib.getName pkg) [
        "steam"
        "steam-unwrapped"
        "nvidia-x11"
        "nvidia-settings"
        "cuda_cudart"
        "cuda_nvcc"
        "cuda_cccl"
        "libcublas"
      ];

    environment.systemPackages = with pkgs; [
      wrappedpkgs.kitty
      wrappedpkgs.default
      wrappedpkgs.git
      eza
      cloudflared
      wl-clipboard
      android-tools
      protonvpn-gui
      wireguard-tools
      finamp
    ];

    system.stateVersion = "26.05";
  };
}
