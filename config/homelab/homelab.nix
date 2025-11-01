{
  config,
  pkgs,
  inputs,
  lib,
  ...
}: {
  imports = [
    inputs.sops-nix.nixosModules.default
    inputs.selfhostblocks.nixosModules.sops
  ];
  sops = {
    defaultSopsFile = ./secrets.yaml;
    defaultSopsFormat = "yaml";
    sops.age.keyFile = "/home/mridula/.config/sops/age/keys.txt";
  };
}
