{
  config,
  pkgs,
  inputs,
  ...
}: {
  # Nix Package Manager
  nix = {
    optimise.automatic = true;
    gc = {
      automatic = true;
      dates = "weekly";
      options = "--delete-older-than 30d";
    };

    settings.experimental-features = [
      "nix-command"
      "flakes"
    ];
  };
  nixpkgs.config.allowUnfree = true;

  # Bootloader
  boot.loader = {
    systemd-boot.enable = true;
    efi.canTouchEfiVariables = true;
  };

  # Networking and Locale

  networking = {
    hostName = "nixos"; # Define your hostname.
    networkmanager.enable = true;
  };

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
    xserver = {
      enable = true;
      xkb = {
        layout = "us";
        variant = "";
      };
    };
    udisks2.enable = true;
    upower.enable = true;
    displayManager.gdm.enable = true;
    printing.enable = true;
    pulseaudio.enable = false;
    pipewire = {
      enable = true;
      alsa = {
        enable = true;
        support32Bit = true;
      };
      pulse.enable = true;
    };
  };
  security.rtkit.enable = true;

  # Hardware
  services.xserver.videoDrivers = ["nvidia"];
  hardware = {
    graphics = {
      enable = true;
      enable32Bit = true;
    };
    cpu.intel.updateMicrocode = true;
    logitech = {
      enable = true;
      enableGraphical = true;
    };
    bluetooth = {
      enable = true;
      powerOnBoot = true;
    };
    nvidia = {
      enabled = true;
      open = true;
      modesetting.enable = true;
      powerManagement = {
        enable = true;
        finegrained = true;
      };
      prime = {
        sync.enable = true;
        intelBusId = "PCI:0:2:0";
        nvidiaBusId = "PCI:1:0:0";
      };
    };
  };

  # System
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
}
