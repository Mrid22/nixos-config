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
  virtualisation = {
    docker = {
      enable = true;
      enableOnBoot = true;
    };
    oci-containers = {
      backend = "docker";
      containers = {
        open-web-ui = {
          image = "ghcr.io/open-webui/open-webui:main";
          environment = {
            "TZ" = "Europe/Amsterdam";
            #        "OLLAMA_API_BASE_URL" = "http://<ollama IP address>:11434/api";
            #        "OLLAMA_BASE_URL" = "http://<ollama IP address>:11434";
          };
          volumes = [
            "/media/open-web-ui/data:/app/backend/data"
          ];
          extraOptions = [
            "--pull=newer"
          ];
        };
      };
    };
  };
  services = {
    jellyfin = {
      enable = true;
      openFirewall = true;
    };
    tailscale = {
      enable = true;
      openFirewall = true;
    };
    prowlarr = {
      enable = true;
      openFirewall = true;
    };
    sonarr = {
      enable = true;
      openFirewall = true;
    };
    flaresolverr = {
      enable = true;
      openFirewall = true;
    };
    immich = {
      enable = true;
      openFirewall = true;
      machine-learning.enable = true;
      mediaLocation = "/media/photos";
    };
    ollama = {
      enable = true;
      openFirewall = true;
      loadModels = ["llama3.2:3b"];
      acceleration = "cuda";
    };
    transmission = {
      enable = true;
      openFirewall = true;
      settings = {
        download-dir = "/media/downloads";
        incomplete-dir = "/media/incomplete";
        incomplete-dir-enabled = true;
      };
    };
  };
}
