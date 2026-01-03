{
  config,
  pkgs,
  lib,
  ...
}: {
  options = {
    homelab.enable = lib.mkEnableOption;
  };
  config = lib.mkIf config.homelab.enable {
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
        PUID = toString 1000;
        PGID = toString 1000;
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
          "bf02bdab-9d2e-42b8-be31-f37c348ef23e" = {
            credentialsFile = "/etc/cloudflared/bf02bdab-9d2e-42b8-be31-f37c348ef23e.json";
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
        loadModels = ["llama3.2:1b" "gpt-oss:20b" "codellama:34b"];
        models = "/media/models/";
      };
    };
  };
}
