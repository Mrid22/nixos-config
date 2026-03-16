{
  flake.nixosModules.homelab = {
    pkgs,
    inputs,
    lib,
    ...
  }: {
    services = {
      jellyfin.enable = true;
    };
  };
}
