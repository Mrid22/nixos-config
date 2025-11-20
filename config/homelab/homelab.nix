{
  config,
  pkgs,
  inputs,
  ...
}: {
  imports = [
    inputs.selfhostblocks.nixosModules.default
    inputs.sops-nix.nixosModules.default
  ];

  services.cloudflared = {
    enable = true;
    tunnels = {
      "00000000-0000-0000-0000-000000000000" = {
        credentialsFile = "${config.sops.secrets.cloudflared-creds.path}";
        default = "http_status:404";
      };
    };
  };

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
