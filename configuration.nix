{
  flake.nixosModules.config = {
    pkgs,
    inputs,
    ...
  }: {
    imports = [
      ./hardware-configuration.nix
      inputs.home-manager.nixosModules.default
      inputs.stylix.nixosModules.stylix
    ];
    boot.loader = {
      systemd-boot.enable = true;
      efi.canTouchEfiVariables = true;
    };

    time.timeZone = "Europe/Nicosia";

    nix.settings = {
      experimental-features = ["nix-command" "flakes"];
      substituters = ["https://hyprland.cachix.org"];
      trusted-substituters = ["https://hyprland.cachix.org"];
      trusted-public-keys = ["hyprland.cachix.org-1:a7pgxzMz7+chwVL3/pzj6jIBMioiJM7ypFP8PwtkuGc="];
    };

    hardware.bluetooth = {
      enable = true;
      powerOnBoot = true;
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
    };

    home-manager = {
      extraSpecialArgs = {inherit inputs;};
      users = {
        "mridula" = import ./home.nix;
      };
      useUserPackages = true;
      useGlobalPkgs = true;
    };

    stylix = {
      enable = true;
      base16Scheme = "${pkgs.base16-schemes}/share/themes/tokyo-night-dark.yaml";
      image = ./Wallpaper.jpg;
      opacity = {
        desktop = 0.5;
        terminal = 0.5;
      };
    };
    users = {
      defaultUserShell = pkgs.zsh;
      users.mridula = {
        isNormalUser = true;
        extraGroups = ["wheel"];
      };
    };

    programs = {
      zsh.enable = true;
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

    fonts.packages = with pkgs; [
      nerd-fonts.fira-code
      nerd-fonts.droid-sans-mono
    ];

    environment.systemPackages = with pkgs; [
      inputs.self.packages.${pkgs.stdenv.hostPlatform.system}.kitty
      inputs.self.packages.${pkgs.stdenv.hostPlatform.system}.git
    ];

    system.stateVersion = "26.05";
  };
}
