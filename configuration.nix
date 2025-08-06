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
    # Include the results of the hardware scan.
    ./system.nix
    ./server.nix
    inputs.home-manager.nixosModules.default
  ];

  users = {
    defaultUserShell = pkgs.zsh;
    users.mridula = {
      isNormalUser = true;
      description = "Mridul Agarwal";
      extraGroups = ["networkmanager" "wheel"];
      packages = with pkgs; [
      ];
    };
  };

  programs = {
    hyprland.enable = true;
    zsh.enable = true;
    gnome-disks.enable = true;
  };

  environment.systemPackages = with pkgs; [
    blueberry
    kdePackages.dolphin
    brightnessctl
    playerctl
    hyprshot
    nodejs
    pnpm
    lunar-client
  ];

  fonts.packages = with pkgs; [
    noto-fonts
    noto-fonts-cjk-sans
    noto-fonts-emoji
    nerd-fonts.fira-code
  ];

  home-manager = {
    extraSpecialArgs = {inherit inputs;};
    users = {
      "mridula" = import ./home.nix;
    };
  };
}
