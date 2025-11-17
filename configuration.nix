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
  };
in {
  imports = [
    ./hardware-configuration.nix
    builtins.attrValues
    files
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
