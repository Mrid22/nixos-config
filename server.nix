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
      autoPrune.enable = true;
    };
    oci-containers = {
      backend = "docker";
      containers = {
        openwebui = {
          image = "ghcr.io/open-webui/open-webui:cuda";
          volumes = [
            "open-webui:/app/backend/data"
          ];
          autoStart = true;
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
                href = "http://localhost/";
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
      loadModels = ["lamma3.1:8b"];
    };
  };
}
