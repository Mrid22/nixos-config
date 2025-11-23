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

  services = {
    cloudflared = {
      enable = true;
      tunnels = {
        "d730b790-900f-4664-a8de-fdbaac137fee" = {
          credentialsFile = "/home/mridula/.cloudflared/cert.pem";
          default = "http_status:404";
        };
      };
    };
    jellyfin = {
      enable = true;
      openFirewall = true;
    };
  };
}
