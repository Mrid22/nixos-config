{
  flake.nixosModules.homelab = {
    pkgs,
    inputs,
    lib,
    ...
  }: let
    tunnel-uuid = "6e3140e1-2a88-4614-b632-541ceef037fe";
  in {
    imports = with inputs; [
      declarative-jellyfin.nixosModules.default
    ];

    environment.systemPackages = with pkgs; [
      cloudflared
    ];
    specialisation.homelab.configuration = {
      # Mount the drive
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
        declarative-jellyfin = {
          enable = true;
          branding.customCss = ''@import url("https://cdn.jsdelivr.net/gh/lscambo13/ElegantFin@main/Theme/ElegantFin-jellyfin-theme-build-latest-minified.css");'';
          system = {
            pluginRepositories = [
              {
                content = {
                  Name = "Jellyfin Stable";
                  Url = "https://repo.jellyfin.org/files/plugin/manifest.json";
                };
                tag = "RepositoryInfo"; # Needed to generate the correct XML
              }

              {
                content = {
                  Name = "Intro Skipper";
                  Url = "https://intro-skipper.org/manifest.json";
                };
                tag = "RepositoryInfo"; # Needed to generate the correct XML
              }
              {
                content = {
                  Name = "Apple Music Metadata";
                  Url = "https://repo.xkrivo.net/jellyfin/manifest.json";
                };
                tag = "RepositoryInfo"; # Needed to generate the correct XML
              }
              {
                content = {
                  Name = "IAmParadox";
                  Url = "https://www.iamparadox.dev/jellyfin/plugins/manifest.json";
                };
                tag = "RepositoryInfo"; # Needed to generate the correct XML
              }
              {
                content = {
                  Name = "Jellyfin Enhanced";
                  Url = "https://raw.githubusercontent.com/n00bcodr/jellyfin-plugins/main/10.11/manifest.json";
                };
                tag = "RepositoryInfo"; # Needed to generate the correct XML
              }
            ];
            serverName = "Mridjelly";
            trickplayOptions = {
              enableHwAcceleration = true;
              enableHwEncoding = true;
            };
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

        immich = {
          enable = true;
          port = 2283;
          mediaLocation = "/media/photos";
          machine-learning.enable = true;
        };

        cloudflared = {
          enable = true;

          tunnels."${tunnel-uuid}" = {
            credentialsFile = "/etc/cloudflared/${tunnel-uuid}.json";
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
