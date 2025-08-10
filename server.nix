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
    open-webui = {
      enable = true;
      openFirewall = true;
      environment = {
        ANONYMIZED_TELEMETRY = "False";
        DO_NOT_TRACK = "True";
        SCARF_NO_ANALYTICS = "True";
        OLLAMA_API_BASE_URL = "http://127.0.0.1:11434";
        WEBUI_AUTH = "False";
      };
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
