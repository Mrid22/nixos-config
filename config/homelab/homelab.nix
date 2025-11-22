{
  config,
  pkgs,
  inputs,
  ...
}: {
  imports = with inputs; [
    selfhostblocks.nixosModules.default
    sops-nix.nixosModules.default
    selfhostblocks.nixosModules.sops
  ];
  sops = {
    defaultSopsFile = ./secrets.yaml;
    defaultSopsFormat = "yaml";
    age.keyFile = "/home/mridula/.config/sops/age/keys.txt";
  };
  services = {
    cloudflared = {
      enable = true;
    };
  };
  shb = {
    sops.secret.jellyfinAdminPassword.request = config.shb.jellyfin.admin.password.request;
    jellyfin = {
      enable = true;
      subdomain = "jellyfin";
      domain = "shmanju.org";

      admin = {
        username = "admin";
        password.result = config.shb.sops.secret.jellyfinAdminPassword.result;
      };
    };
  };
}
