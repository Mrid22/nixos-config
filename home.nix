{
  config,
  pkgs,
  inputs,
  lib,
  ...
}: let
  files = lib.fileset.fromDir {
    dir = ./config;
    recursive = true;
    include = ["*.nix"];
    exclude = ["nvim.nix"];
  };
in {
  imports = [
    files
  ];

  home = {
    username = "mridula";
    homeDirectory = "/home/mridula";
    stateVersion = "25.05";
  };
  programs.home-manager.enable = true;
}
