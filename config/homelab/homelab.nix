{
  config,
  pkgs,
  inputs,
  ...
}: {
  imports = [
    inputs.sops-nix.nixosModules.sops
  ];

  sops = {
    defaultSopsFile = ./secrets.yaml;
    defaultSopsFormat = "yaml";
    age.keyFile = "/home/mridula/.config/sops/age/keys.txt";
    secrets.cloudflare-creds = {};
  };

  services.cloudflared = {
    enable = true;
    tunnels = {
      "0d6acf9b-d6e2-48a6-a4d0-41078c6f8576" = {
        credentialsFile = "${config.sops.secrets.cloudflare-creds.path}";
        default = "http_status:404";
      };
    };
  };
}
