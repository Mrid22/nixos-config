{
  flake.nixosModules.config = {
    pkgs,
    inputs,
    lib,
    ...
  }: let
    wrappedpkgs = inputs.self.packages.${pkgs.stdenv.hostPlatform.system};
  in {
    imports = with inputs; [
      stylix.nixosModules.stylix
      musnix.nixosModules.musnix
    ];
    nix = {
      optimise = {
        automatic = true;
        dates = ["03:45"];
      };
      settings = {
        experimental-features = ["nix-command" "flakes"];
        substituters = ["https://hyprland.cachix.org" "https://vicinae.cachix.org"];
        trusted-substituters = ["https://hyprland.cachix.org"];
        trusted-public-keys = [
          "hyprland.cachix.org-1:a7pgxzMz7+chwVL3/pzj6jIBMioiJM7ypFP8PwtkuGc="
          "vicinae.cachix.org-1:1kDrfienkGHPYbkpNj1mWTr7Fm1+zcenzgTizIcI3oc="
        ];
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
    };
    networking = {
      networkmanager.enable = true;
      firewall.checkReversePath = false;
    };

    musnix = {
      enable = true;
      soundcardPciId = "00:1f.3";
      rtirq.enable = true;
    };

    services = {
      ntp.servers = ["1.cy.pool.ntp.org"];
      fwupd.enable = true;
      nohang.enable = true;
      logiops = {
        enable = true;
        config.devices = [
          {
            name = "MX Master 3S";
            dpi = 10000;
            hiresscroll = {
              hires = true;
            };
          }
        ];
      };
      syncthing = {
        enable = true;
        user = "mridula";
        dataDir = "/home/mridula/.config/syncthing";
        configDir = "/home/mridula/.config/syncthing";
        openDefaultPorts = true;
      };
      hypridle = {
        enable = true;
        package = wrappedpkgs.hypridle;
      };
      pipewire = {
        enable = true;
        alsa = {
          enable = true;
          support32Bit = true;
        };
        pulse.enable = true;
        jack.enable = true;
      };
      udisks2.enable = true;
      upower.enable = true;
      power-profiles-daemon.enable = true;
      playerctld.enable = true;
      gnome.gnome-keyring.enable = true;

      xserver.enable = true;

      keyd = {
        enable = true;
        keyboards.default = {
          ids = ["*"];
          settings.main.capslock = "overload(control,escape)";
        };
      };
      displayManager.sddm.enable = true;
    };

    stylix = {
      enable = true;
      base16Scheme = "${pkgs.base16-schemes}/share/themes/tokyo-night-dark.yaml";
      image = ./Wallpaper.jpg;
      polarity = "dark";
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
        extraGroups = ["wheel" "audio" "networkmanager"];
      };
    };

    xdg.mime.defaultApplications = {
      "application/pdf" = "zen-twilight.desktop";
    };

    programs = {
      bat.enable = true;
      localsend.enable = true;
      nix-ld.enable = true;
      gamemode.enable = true;
      nh = {
        enable = true;
        flake = "/home/mridula/nixos-config";
        clean = {
          enable = true;
          extraArgs = "--keep 3";
        };
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
    nixpkgs = {
      config.allowUnfreePredicate = pkg:
        builtins.elem (lib.getName pkg) [
          "steam"
          "steam-unwrapped"
          "nvidia-x11"
          "nvidia-settings"
          "unityhub"
          "corefonts"
          "obsidian"
          "code"
          "vscode"
          "vscode-extension-VisualStudioToolsForUnity-vstuc"
        ];
    };

    environment.systemPackages = with pkgs; [
      wrappedpkgs.kitty
      wrappedpkgs.default # Neovim
      wrappedpkgs.git
      prismlauncher
      cliamp
      eza
      blender
      ffmpeg
      itch
      kdePackages.kdenlive
      alsa-utils
      alsa-tools
      pavucontrol
      openvino
      audacity
      qjackctl
      godot
      calf
      helm
      tap-plugins
      lmms
      x42-plugins
      nodejs
      pnpm
      finamp
      picard
      vlc
      unityhub
      wl-clipboard
      android-tools
      proton-vpn
      wireguard-tools
      dotnet-sdk
      orca
      speechd
    ];
    system = {
      autoUpgrade = {
        enable = true;
        flake = inputs.self.outPath;
        flags = [
          "--print-build-logs"
          "--commit-lock-file"
        ];
        dates = "02:00";
        randomizedDelaySec = "45min";
        allowReboot = false; # Set to true if you want automatic reboots
      };
      stateVersion = "26.05";
    };
  };
}
