{
  config,
  pkgs,
  lib,
  ...
}: {
  options = {
    homelab.enable = lib.mkEnableOption;
  };
  config = {
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
      open-webui.enable = lib.mkIf config.homelab.enable;

      jellyfin = {
        enable = lib.mkIf config.homelab.enable;
        openFirewall = true;
      };

      jellyseerr = {
        enable = lib.mkIf config.homelab.enable;
        openFirewall = true;
      };

      sonarr = {
        enable = lib.mkIf config.homelab.enable;
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
        enable = lib.mkIf config.homelab.enable;
        openFirewall = true;
      };

      transmission = {
        enable = lib.mkIf config.homelab.enable;
        openFirewall = true;
        package = pkgs.transmission_4;
        settings = {
          download-dir = "/media/downloads/incomplete";
          incomplete-dir = "/media/downloads/incomplete";
          incomplete-dir-enabled = true;
        };
      };

      cloudflared = {
        enable = lib.mkIf config.homelab.enable;
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
        enable = lib.mkIf config.homelab.enable;
        openFirewall = true;
        host = "0.0.0.0";
        machine-learning.enable = true;
        mediaLocation = "/media/photos/";
      };

      ollama = {
        enable = config.homelab.enable;
        host = "0.0.0.0";
        package = pkgs.ollama-cuda;
        loadModels = ["llama3.2:1b" "gpt-oss:20b" "codellama:34b"];
        models = "/media/models/";
      };
    };
  };
}
