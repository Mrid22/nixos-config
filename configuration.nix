{
  pkgs,
  inputs,
  ...
}: {
  imports = [
    ./hardware-configuration.nix
  ];
  boot.loader = {
    systemd-boot.enable = true;
    efi.canTouchEfiVariables = true;
  };

  nix.settings = {
    experimental-features = ["nix-command" "flakes"];
    substituters = ["https://hyprland.cachix.org"];
    trusted-substituters = ["https://hyprland.cachix.org"];
    trusted-public-keys = ["hyprland.cachix.org-1:a7pgxzMz7+chwVL3/pzj6jIBMioiJM7ypFP8PwtkuGc="];
  };
  networking = {
    hostName = "nixos";
    networkmanager.enable = true;
  };
  services = {
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
    desktopManager.gnome.enable = true;
  };

  home-manager = {
    extraSpecialArgs = {inherit inputs;};
    users = {
      "mridula" = import ./home.nix;
    };
    useUserPackages = true;
    useGlobalPkgs = true;
  };

  users.users.mridula = {
    isNormalUser = true;
    extraGroups = ["wheel"];
  };

  programs = {
    nh = {
      enable = true;
      flake = "/home/mridula/nixos-config";
    };
    neovim = {
      enable = true;
      defaultEditor = true;
    };
    hyprland = {
      enable = true;
      package = inputs.hyprland.packages."${pkgs.stdenv.hostPlatform.system}".hyprland;
    };
  };
  environment.systemPackages = with pkgs; [
    kitty
  ];

  system.stateVersion = "26.05";
}
