{
  pkgs,
  inputs,
  ...
}: {
  imports = [
    ./hardware-configuration.nix
    ./homelab.nix
  ];

  boot.loader = {
    systemd-boot.enable = false;
    grub = {
      efiSupport = true;
      enable = true;
      devices = ["nodev"];
    };
    efi = {
      canTouchEfiVariables = true;
      efiSysMountPoint = "/boot";
    };
  };

  networking = {
    hostName = "nixos";
    networkmanager.enable = true;
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
      modesetting.enable = true;
      open = true;
      powerManagement.finegrained = true;
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

  specialisation = {
    portable.configuration = {
      homelab.enable = false;
      environment.etc."specialisation".text = "portable";
    };
    homelab.configuration = {
      homelab.enable = true;
      environment.etc."specialisation".text = "homelab";
    };
  };

  # Set your time zone.
  time.timeZone = "Europe/Amsterdam";

  i18n = {
    defaultLocale = "en_US.UTF-8";

    extraLocaleSettings = {
      LC_ADDRESS = "nl_NL.UTF-8";
      LC_IDENTIFICATION = "nl_NL.UTF-8";
      LC_MEASUREMENT = "nl_NL.UTF-8";
      LC_MONETARY = "nl_NL.UTF-8";
      LC_NAME = "nl_NL.UTF-8";
      LC_NUMERIC = "nl_NL.UTF-8";
      LC_PAPER = "nl_NL.UTF-8";
      LC_TELEPHONE = "nl_NL.UTF-8";
      LC_TIME = "nl_NL.UTF-8";
    };
  };
  services = {
    upower = {
      enable = true;
      percentageLow = 20;
      percentageCritical = 5;
    };
    displayManager.gdm.enable = true;
    keyd = {
      enable = true;
      keyboards = {
        default = {
          ids = ["*"];
          settings = {
            main = {
              capslock = "overload(control, esc)";
            };
          };
        };
      };
    };

    xserver = {
      enable = true;
      videoDrivers = ["nvidia"];

      xkb = {
        layout = "us";
        variant = "";
      };
    };
    # Enable CUPS to print documents.
    printing.enable = true;

    # Enable sound with pipewire.
    pulseaudio.enable = false;
    pipewire = {
      enable = true;
      alsa = {
        enable = true;
        support32Bit = true;
      };
      pulse.enable = true;
    };

    openssh.enable = true;
  };
  nix.settings = {
    experimental-features = ["nix-command" "flakes"];
    extra-substituters = ["https://vicinae.cachix.org"];
    extra-trusted-public-keys = ["vicinae.cachix.org-1:1kDrfienkGHPYbkpNj1mWTr7Fm1+zcenzgTizIcI3oc="];
  };
  security.rtkit.enable = true;
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
  };

  catppuccin = {
    enable = true;
    accent = "mauve";
    flavor = "mocha";
    cache.enable = true;
  };

  programs = {
    zsh.enable = true;
    npm.enable = true;
    hyprland = {
      enable = true;
      package = inputs.hyprland.packages.x86_64-linux.hyprland;
    };

    git = {
      enable = true;
      package = inputs.self.packages.x86_64-linux.git;
    };
    neovim = {
      enable = true;
      defaultEditor = true;
    };
  };
  # Allow unfree packages
  nixpkgs.config.allowUnfree = true;

  environment.systemPackages = with pkgs; [
    kitty
    blender
    playerctl
    picard
  ];

  system.stateVersion = "25.11";
}
