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
    ];
  };
  system.activationScripts.setupFolders = ''
    mkdir -p /media/downloads/downloads
    mkdir -p /media/downloads/downloads/tv-sonarr
    mkdir -p /media/downloads/incomplete
    mkdir -p /media/tv
    mkdir -p /media/photos
    mkdir -p /media/home
    mkdir -p /media/models
  '';
  virtualisation.oci-containers = {
    backend = "docker";
    containers = {
      homeassistant = {
        image = "ghcr.io/home-assistant/home-assistant:stable";
        volumes = [
          "/media/home:/config"
          "/var/run/dbus:/run/dbus:ro"
          "/media/tv:/media"
        ];
        environment = {
          TZ = "Europe/Amsterdam";
        };
        ports = [
          "127.0.0.1:8123:8123"
          "127.0.0.1:8124:80"
        ];
        capabilities = {
          NET_ADMIN = true;
          NET_RAW = true;
        };
        extraOptions = [
          "--network=host"
        ];
      };
    };
  };

  nixarr = {
    enable = true;
    mediaDir = "/media";
    stateDir = "/media/.state/nixarr";
    jellyfin = {
      enable = true;
      expose.https = {
        enable = true;
        domainName = "jellyfin.mridulagarwal.duckdns.org";
        acmeMail = "mridulaga@outlook.com"; # Required for ACME-bot
      };
    };
  };
  services = {
    homepage-dashboard = {
      enable = true;
      bookmarks = [
        {
          AI = [
            {
              Ollama = [
                {
                  href = "http://nixos:11434";
                }
              ];
            }
            {
              "Open Web UI" = [
                {
                  href = "http://nixos:8080";
                }
              ];
            }
          ];
        }
        {
          Media = [
            {
              Jellyfin = [
                {
                  href = "http://nixos:8096";
                }
              ];
            }
            {
              Sonarr = [
                {
                  href = "http://nixos:8989";
                }
              ];
            }
          ];
        }
      ];
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
    # jellyfin = {
    #   enable = true;
    #   openFirewall = true;
    # };
    jellyseerr = {
      enable = true;
      openFirewall = true;
    };
    tailscale = {
      enable = true;
      openFirewall = true;
      disableTaildrop = true;
      useRoutingFeatures = "both";
    };
    immich = {
      enable = true;
      openFirewall = true;
      host = "0.0.0.0";
      mediaLocation = "/media/photos";
      machine-learning.enable = true;
    };
    transmission = {
      enable = true;
      openRPCPort = true;
      package = pkgs.transmission_4;
      settings = {
        download-dir = "/media/downloads/downloads";
        incomplete-dir = "/media/downloads/incomplete";
        incomplete-dir-enabled = true;
      };
    };
    ollama = {
      enable = true;
      openFirewall = true;
      acceleration = "cuda";
      loadModels = ["llama3.2:3b"];
      host = "0.0.0.0";
      models = "/media/models";
    };
    open-webui = {
      enable = true;
      openFirewall = true;
      host = "0.0.0.0";
    };
  };
}
