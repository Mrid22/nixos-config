{
  config,
  pkgs,
  inputs,
  lib,
  ...
}: {
  imports = [
    ./hardware-configuration.nix
    ./config/apps.nix
    ./config/user.nix
    ./config/gaming.nix
    ./config/system.nix
  ];

  fonts.packages = with pkgs; [
    nerd-fonts.fira-code
  ];

  gaming = {
    enable = true;
    nvidia = true;
    xbox-controller = true;
  };

  system.stateVersion = "25.05";
}
