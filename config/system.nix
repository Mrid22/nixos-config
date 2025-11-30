{inputs, ...}: {
  time.timeZone = "Europe/Amsterdam";
  security.rtkit.enable = true;
  nixpkgs.config.allowUnfree = true;

  networking = {
    hostName = "nixos";
    networkmanager.enable = true;
  };

  nix.settings = {
    experimental-features = [
      "nix-command"
      "flakes"
    ];
    trusted-users = [
      "root"
      "mridula"
    ];
  };

  boot.loader = {
    systemd-boot.enable = true;
    efi.canTouchEfiVariables = true;
  };

  hardware = {
    graphics = {
      enable = true;
      enable32Bit = true;
    };
    bluetooth = {
      enable = true;
      powerOnBoot = true;
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
    upower.enable = true;
    udisks2.enable = true;
    power-profiles-daemon.enable = true;
    displayManager.gdm.enable = true;
    printing.enable = true;
    pulseaudio.enable = false;

    xserver = {
      enable = true;
      videoDrivers = ["nvidia"];

      xkb = {
        layout = "us";
        variant = "";
      };
    };

    pipewire = {
      enable = true;
      alsa = {
        enable = true;
        support32Bit = true;
      };
      pulse.enable = true;
    };
  };
}
