{
  config,
  pkgs,
  inputs,
  ...
}: {
  imports = with inputs; [
    selfhostblocks.nixosModules.default
    sops-nix.nixosModules.default
  ];
  sops = {
    defaultSopsFile = ./secrets.yaml;
    defaultSopsFormat = "yaml";
    age.keyFile = "/home/mridula/.config/sops/age/keys.txt";
  };
}
