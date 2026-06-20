{
  flake.nixosModules.homelab = {
    pkgs,
    inputs,
    lib,
    ...
  }: {
    imports = with inputs; [
      jellyfin-flake.nixosModules.default
    ];
    fileSystems."/media" = {
      device = "/dev/sda1";
      fsType = "ntfs";
      options = [
        "users" # Allows any user to mount and unmount
        "nofail" # Prevent system from failing if this drive doesn't mount
        "exec" # Permit execution of binaries and other executable files
      ];
    };

    virtualisation.oci-containers = {
      backend = "podman";
      containers = {
        homeassistant = {
          volumes = ["home-assistant:/config"];
          environment.TZ = "Asia/Nicosia";
          # Note: The image will not be updated on rebuilds, unless the version label changes
          image = "ghcr.io/home-assistant/home-assistant:latest";
          extraOptions = [
            # Use the host network namespace for all sockets
            "--network=host"
          ];
        };
      };
    };

    services = {
      #Arr
      jellyfin = {
        enable = true;
        dataDir = "/var/lib/jellyfin/data";
        settings = {
          system = {
            serverName = "MridulJelly";
            quickConnectAvailable = false;
            isStartupWizardCompleted = true;
            enableExternalContentInSuggestions = true;
            pluginRepositories = [
              {
                name = "Apple Music Metadata";
                url = "https://repo.xkrivo.net/jellyfin/manifest.json";
              }
              {
                name = "Jellyfin Stable";
                url = "https://repo.jellyfin.org/files/plugin/manifest.json";
              }
              {
                name = "Intro Skipper";
                url = "https://intro-skipper.org/manifest.json";
              }
              {
                name = "I Am Paradox";
                url = "https://www.iamparadox.dev/jellyfin/plugins/manifest.json";
              }
              {
                name = "Editor's Choice";
                url = "https://github.com/lachlandcp/jellyfin-editors-choice-plugin/raw/main/manifest.json";
              }
              {
                name = "Jellyfin Enhanced";
                url = "https://raw.githubusercontent.com/n00bcodr/jellyfin-plugins/main/10.11/manifest.json";
              }
            ];
          };
          branding.customCss = ''@import url("https://cdn.jsdelivr.net/gh/lscambo13/ElegantFin@main/Theme/ElegantFin-jellyfin-theme-build-latest-minified.css");'';
          encoding.hardwareAccelerationType = "nvenc";
        };
        hardwareAcceleration = {
          enable = true;
          type = "nvenc";
          device = "/dev/dri/renderD128";
        };
      };

      sonarr.enable = true;
      prowlarr.enable = true;
      radarr.enable = true;
      bazarr.enable = true;
      flaresolverr.enable = true;
      seerr.enable = true;

      transmission = {
        enable = true;
        openRPCPort = true;
        settings = {
          download-dir = "/media/downloads/complete/";
          incomplete-dir = "/media/downloads/incomplete/";
          incomplete-dir-enabled = true;
        };
      };

      immich.enable = true;

      cloudflared = {
        enable = true;
        tunnels = {
          "917c719c-abbf-4959-b32d-c0bb6d9b9939" = {
            credentialsFile = "/etc/cloudflared/917c719c-abbf-4959-b32d-c0bb6d9b9939.json";
            default = "http_status:404";
            ingress = {
              "jf.shmanju.org" = "http://localhost:8096";
              "js.shmanju.org" = "http://localhost:5055";
              "pg.shmanju.org" = "http://localhost:2283";
            };
          };
        };
      };
    };
  };
}
