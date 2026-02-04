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

  networking = {
    hostName = "nixos";
    networkmanager.enable = true;
  };

  time.timeZone = "Asia/Famagusta";

  nix.settings = {
    experimental-features = ["nix-command" "flakes"];
    substituters = ["https://hyprland.cachix.org"];
    trusted-substituters = ["https://hyprland.cachix.org"];
    trusted-public-keys = ["hyprland.cachix.org-1:a7pgxzMz7+chwVL3/pzj6jIBMioiJM7ypFP8PwtkuGc="];
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

      keyboards.default = {
        ids = ["*"];
        settings.main.capslock = "overload(control,escape)";
      };
    };
  };

  hardware.nvidia = {
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

  users.users.mridula = {
    isNormalUser = true;
    extraGroups = ["wheel"];
  };

  programs = {
    firefox.enable = true;
    hyprland = {
      enable = true;
      package = inputs.hyprland.packages.${pkgs.stdenv.hostPlatform.system}.hyprland;
      portalPackage = inputs.hyprland.packages.${pkgs.stdenv.hostPlatform.system}.xdg-desktop-portal-hyprland;
    };
    nh = {
      enable = true;
      flake = "/home/mridula/nixos-config";
    };
    neovim = {
      enable = true;
      defaultEditor = true;
    };
  };
  environment.systemPackages = with pkgs; [
    wget
    git
    eza
  ];

  system.stateVersion = "25.11";
}
