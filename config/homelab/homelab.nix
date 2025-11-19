{
  config,
  pkgs,
  inputs,
  ...
}: {
  imorts = [
    inputs.selfhostblocks.nixosModules.default
    inputs.sops-nix.nixosModules.default
  ];

  sops = {
    defaultSopsFile = ./secrets.yaml;
    defaultSopsFormat = "yaml";
    age.keyFile = "/home/mridula/.config/sops/age/keys.txt";
  };

  shb = {
    sops.secrets = {
      "jellyfin/password".request = config.shb.jellyfin.admin.password.request;
    };
    jellyfin = {
      enable = true;
      subdomain = "jellyfin";
      domain = "shmanju.org";

      admin = {
        username = "mridula";
        password.result = config.shb.sops.secret.jellyfinAdminPassword.result;
      };
    };
  };
}
