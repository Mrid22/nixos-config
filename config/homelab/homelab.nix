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
  services = {
    cloudflared = {
      enable = true;
      tunnels = {
        "Mridul Agarwal" = {
          credentialsFile = "${config.sops.secrets.cf-token.path}";
          ingress = {
            "jellyfin.shmanju.org" = {
              service = "http://localhost:8096";
            };
            "*.domain2.com" = "http://localhost:80";
          };
          default = "http_status:404";
        };
      };
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
