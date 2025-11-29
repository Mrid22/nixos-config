{
  config,
  pkgs,
  inputs,
  ...
}: {
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
    meilisearch.enable = true;
    cloudflared = {
      enable = true;
      tunnels = {
        "8b89a63e-98eb-4227-ae74-035deb51496d" = {
          credentialsFile = "/etc/cloudflared/8b89a63e-98eb-4227-ae74-035deb51496d.json";
          default = "http_status:404";
          ingress = {
            "jellyfin.shmanju.org" = "http://localhost:8096";
            "jellyseerr.shmanju.org" = "http://localhost:5055";
            "photos.shmanju.org" = "http://localhost:2283";
          };
        };
      };
    };
    jellyfin = {
      enable = true;
      openFirewall = true;
    };

    ollama = {
      enable = true;
      host = "0.0.0.0";
      acceleration = "cuda";
      loadModels = ["gpt-oss:20b"];
      models = "/media/models/";
    };

    open-webui.enable = true;

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
  };
}
