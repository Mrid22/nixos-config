{
  config,
  pkgs,
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

  networking.nameservers = [ "1.1.1.1" ];

  virtualisation = {
    docker = {
      enable = true;
      enableOnBoot = true;
      autoPrune.enable = true;
    };
    oci-containers = {
      backend = "docker";
      containers = {
        "open-webui" = {
          image = "ghcr.io/open-webui/open-webui:main";

          environment = {
            OLLAMA_BASE_URL = "http://nixos:11434";
            TZ = "Europe/Amsterdam";
            OLLAMA_API_BASE_URL = "http://nixos:11434/api";
          };

          ports = [
            "8080:8080"
          ];

          volumes = [
            "/var/lib/open-webui:/app/backend/data"
          ];

          autoStart = true;

          extraOptions = [
            "--pull=always"
            "--network=host"
          ];
        };
      };
    };
  };

  services = {
    xserver.desktopManager.kodi.enable = true;
    displayManager.autoLogin.user = "kodi";
    homepage-dashboard = {
      enable = true;
      openFirewall = true;
      services = [
        {
          "Media/Arr" = [
            {
              "Jellyfin" = {
                href = "http://nixos:8096";
              };
            }
            {
              "Sonarr" = {
                href = "http://nixos:8989";
              };
            }
          ];
        }
        {
          "AI" = [
            {
              "Ollama" = {
                description = "Ollama";
                href = "http://localhost:8080";
              };
            }
          ];
        }
        {
          "Other" = [
            {
              "Tailscale" = {
                href = "https://login.tailscale.com";
              };
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
    transmission = {
      enable = true;
      openFirewall = true;
      downloadDirPermissions = "770";
      settings = {
        download-dir = "/media/downloads";
      };
    };
    jellyfin = {
      enable = true;
      openFirewall = true;
    };
    tailscale = {
      enable = true;
      openFirewall = true;
      disableTaildrop = true;
    };
    ollama = {
      enable = true;
      openFirewall = true;
      acceleration = "cuda";
      loadModels = ["llama3.1:8b"];
      host = "nixos";
    };
  };
}
