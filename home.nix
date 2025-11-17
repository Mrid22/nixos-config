{
  config,
  pkgs,
  inputs,
  lib,
  ...
}: {
  imports = [
    ./home/apps/nvf.nix
    ./home/apps/zen.nix
    ./home/environments/terminal.nix
    ./home/environments/de.nix
  ];

  home = {
    username = "mridula";
    homeDirectory = "/home/mridula";
    stateVersion = "25.05";
  };
  programs.home-manager.enable = true;
}
