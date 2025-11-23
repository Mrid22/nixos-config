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
  };

  fileSystems."/media" = {
    device = "/dev/sda1";
    fsType = "ntfs";
    options = [
      "users"
      "nofail"
      "exec"
    ];
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
            "jellyseerr.shmanju.org" = "http://localhost:5055";
          };
        };
      };
    };
    jellyfin = {
      enable = true;
      openFirewall = true;
    };
    jellyseerr = {
      enable = true;
      openFirewall = true;
    };
    sonarr = {
      enable = true;
      openFirewall = true;
    };
    radarr = {
      enable = true;
      openFirewall = true;
    };
    prowlarr = {
      enable = true;
      openFirewall = true;
    };
    flaresolverr = {
      enable = true;
      openFirewall = true;
    };
    transmission = {
      enable = true;
      openFirewall = true;
      package = pkgs.transmission_4;
      settings = {
        download-dir = "/media/downloads/incomplete";
        incomplete-dir = "/media/downloads/incomplete";
        incomplete-dir-enabled = true;
      };
    };
    # immich = {
    #   enable = true;
    #   openFirewall = true;
    #   mediaLocation = "/media/photos/";
    #   machine-learning.enable = true;
    # };
  };
}
