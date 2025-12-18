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

  virtualisation.oci-containers.containers.docker = {
    image = "homeassistant/home-assistant:stable";
    autoStart = true;
    extraOptions = [
      "--pull=newer"
    ];
    volumes = [
      "/media/home/config/:/config"
    ];
    ports = [
      "127.0.0.1:8123:8123"
      "127.0.0.1:8124:80"
    ];
    environment = {
      TZ = "Europe/Amsterdam";
      PUID = 1000;
      PGID = 1000;
    };
  };

  services = {
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
        "f2b0a7d3-c143-493f-b7d8-93c76bf852df" = {
          credentialsFile = "/etc/cloudflared/f2b0a7d3-c143-493f-b7d8-93c76bf852df.json";
          default = "http_status:404";
          ingress = {
            "jellyfin.shmanju.org" = "http://localhost:8096";
            "jellyseerr.shmanju.org" = "http://localhost:5055";
            "photos.shmanju.org" = "http://localhost:2283";
          };
        };
      };
    };

    immich = {
      enable = true;
      openFirewall = true;
      host = "0.0.0.0";
      machine-learning.enable = true;
      mediaLocation = "/media/photos/";
    };

    ollama = {
      enable = true;
      host = "0.0.0.0";
      package = pkgs.ollama-cuda;
      loadModels = ["llama3.2:1b"];
      models = "/media/models/";
    };
  };
}
