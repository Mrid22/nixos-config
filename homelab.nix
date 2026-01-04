{
  config,
  pkgs,
  lib,
  ...
}: {
  options = {
    homelab.enable = lib.mkEnableOption "homelab";
  };
  config = lib.mkIf config.homelab.enable {
    programs.gnome-disks.enable = true;

    environment.systemPackages = with pkgs; [
      ntfs3g
      spotdl
    ];

    fileSystems."/media" = lib.mkIf config.homelab.enable {
      device = "/dev/sda1";
      fsType = "ntfs";
      options = [
        "users"
        "nofail"
        "exec"
      ];
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
        loadModels = ["gpt-oss:20b"];
        models = "/media/models/";
      };
    };
  };
}
