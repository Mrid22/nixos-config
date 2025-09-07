# Edit this configuration file to define what should be installed on
# your system.  Help is available in the configuration.nix(5) man page
# and in the NixOS manual (accessible by running ‘nixos-help’).
{
  config,
  pkgs,
  inputs,
  ...
}: {
  imports = [
    ./hardware-configuration.nix
    ./server.nix
    inputs.home-manager.nixosModules.default
  ];

  # Bootloader.
  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;
  hardware.graphics = {
    enable = true;
    enable32Bit = true;
  };
  hardware.bluetooth = {
    enable = true;
    powerOnBoot = true;
  };
  networking.hostName = "nixos";
  networking.networkmanager.enable = true;

  time.timeZone = "Europe/Amsterdam";

  i18n.defaultLocale = "en_US.UTF-8";

  i18n.extraLocaleSettings = {
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

  nix.settings.experimental-features = ["nix-command" "flakes"];
  services = {
    tlp.enable = true;
    blueman.enable = true;
    displayManager.gdm.enable = true;
    keyd = {
      enable = true;
      keyboards = {
        # The name is just the name of the configuration file, it does not really matter
        default = {
          ids = ["*"]; # what goes into the [id] section, here we select all keyboards
          # Everything but the ID section:
          settings = {
            # The main layer, if you choose to declare it in Nix
            main = {
              capslock = "overload(control, esc)"; # you might need to also enclose the key in quotes if it contains non-alphabetical symbols
            };
          };
        };
      };
    };

    # Configure keymap in X11
    xserver.xkb = {
      layout = "us";
      variant = "";
    };
    udisks2.enable = true;

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
      # If you want to use JACK applications, uncomment this
      #jack.enable = true;

      # use the example session manager (no others are packaged yet so this is enabled by default,
      # no need to redefine it in your config for now)
      #media-session.enable = true;
    };
  };
  programs = {
    gnome-disks.enable = true;
    zsh.enable = true;
    hyprland = {
      enable = true;
      withUWSM = true; # recommended for most users
      xwayland.enable = true; # Xwayland can be disabled.
    };

    neovim.defaultEditor = true;

    # Install firefox.
  };

  fonts = {
    fontDir = {
      enable = true;
      decompressFonts = true;
    };
    packages = with pkgs; [
      nerd-fonts.fira-code
    ];
  };

  home-manager = {
    extraSpecialArgs = {inherit inputs;};
    users = {
      "mridula" = import ./home.nix;
    };
  };
  security.rtkit.enable = true;
  users = {
    defaultUserShell = pkgs.zsh;
    users.mridula = {
      isNormalUser = true;
      description = "Mridul Agarwal";
      extraGroups = ["networkmanager" "wheel"];
      packages = with pkgs; [
        playerctl
      ];
    };
  };

  # Allow unfree packages
  nixpkgs.config.allowUnfree = true;

  # List packages installed in system profile. To search, run:
  # $ nix search wget
  environment.systemPackages = with pkgs; [
    #  vim # Do not forget to add an editor to edit configuration.nix! The Nano editor is also installed by default.
    #  wget
    ntfs3g
  ];

  # Some programs need SUID wrappers, can be configured further or are
  # started in user sessions.
  # programs.mtr.enable = true;
  # programs.gnupg.agent = {
  #   enable = true;
  #   enableSSHSupport = true;
  # };

  # List services that you want to enable:

  # Enable the OpenSSH daemon.
  # services.openssh.enable = true;

  # Open ports in the firewall.
  # networking.firewall.allowedTCPPorts = [ ... ];
  # networking.firewall.allowedUDPPorts = [ ... ];
  # Or disable the firewall altogether.
  # networking.firewall.enable = false;

  # This value determines the NixOS release from which the default
  # settings for stateful data, like file locations and database versions
  # on your system were taken. It‘s perfectly fine and recommended to leave
  # this value at the release version of the first install of this system.
  # Before changing this value read the documentation for this option
  # (e.g. man configuration.nix or on https://nixos.org/nixos/options.html).
  system.stateVersion = "25.05"; # Did you read the comment?
}
