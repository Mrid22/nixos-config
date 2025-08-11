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

  virtualisation = {
    docker = {
      enable = true;
      enableOnBoot = true;
      autoStart = true;
      autoPrune.enable = true;
    };
    oci-containers = {
      enable = true;
      backend = "docker";
      containers = {
        "open-webui" = {
          image = "ghcr.io/open-webui/open-webui:main";

          environment = {
            OPEN_WEBUI_OLLAMA_BASE_URL = "http://localhost:11434";
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
          ];
        };
      };
    };
  };

  services = {
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
                href = "login.tailscale.com";
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
    };
  };
}
