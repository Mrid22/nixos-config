{
  flake.nixosModules.config = {
    pkgs,
    inputs,
    ...
  }: let
    wrappedpkgs = inputs.self.packages.${pkgs.stdenv.hostPlatform.system};
  in {
    imports = [inputs.stylix.nixosModules.stylix];
    boot.loader = {
      systemd-boot.enable = true;
      efi.canTouchEfiVariables = true;
    };

    time.timeZone = "Europe/Nicosia";

    nix.settings = {
      experimental-features = ["nix-command" "flakes"];
      substituters = ["https://hyprland.cachix.org" "https://vicinae.cachix.org"];
      trusted-substituters = ["https://hyprland.cachix.org"];
      trusted-public-keys = [
        "hyprland.cachix.org-1:a7pgxzMz7+chwVL3/pzj6jIBMioiJM7ypFP8PwtkuGc="
        "vicinae.cachix.org-1:1kDrfienkGHPYbkpNj1mWTr7Fm1+zcenzgTizIcI3oc="
      ];
    };

    hardware.bluetooth = {
      enable = true;
      powerOnBoot = true;
    };

    networking = {
      hostName = "nixos";
      firewall.checkReversePath = false;
      networkmanager.enable = true;
    };
    services = {
      gnome.gnome-keyring.enable = true;
      xserver.enable = true;
      keyd = {
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
        extraGroups = ["wheel"];
      };
    };

    programs = {
      nh = {
        enable = true;
        flake = "/home/mridula/nixos-config";
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

    environment.systemPackages = with pkgs; [
      wrappedpkgs.kitty
      wrappedpkgs.default
      wrappedpkgs.git
      eza
      protonvpn-gui
      wireguard-tools
    ];

    system.stateVersion = "26.05";
  };
}
