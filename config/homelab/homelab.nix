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
    secrets."cloudflared/cert".path = "/home/mridula/.cloudflared/cert.pem";
  };

  services = {
    cloudflared = {
      enable = true;
      tunnels = {
        "4093605a-51ec-4dca-a803-5c128b905a8a" = {
          credentialsFile = "/etc/cloudflared/4093605a-51ec-4dca-a803-5c128b905a8a.json";
          default = "http_status:404";
          ingress = {
            "jellyfin.shmanju.org" = "http://localhost:8096";
          };
        };
      };
    };
    jellyfin = {
      enable = true;
      openFirewall = true;
    };
  };
}
