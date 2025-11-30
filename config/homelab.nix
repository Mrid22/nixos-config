{pkgs, ...}: {
  programs.gnome-disks.enable = true;

  environment.systemPackages = with pkgs; [
    ntfs3g
    spotdl
  ];

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
    open-webui.enable = true;

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

    nextcloud = {
      enable = true;
      autoUpdateApps.enable = true;
      hostName = "mridcloud";
      package = pkgs.nextcloud32;
      settings.trusted_domains = ["cloud.shmanju.org"];
      config = {
        adminpassFile = "/etc/nextcloud/pass.txt";
        dbtype = "sqlite";
      };
    };

    ollama = {
      enable = true;
      host = "0.0.0.0";
      acceleration = "cuda";
      loadModels = ["llama3.2:1b"];
      models = "/media/models/";
    };
  };
}
