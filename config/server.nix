{
  config,
  pkgs,
  inputs,
  ...
}: {
  # System
  networking.firewall.checkReversePath = "loose";
  fileSystems."/media" = {
    device = "/dev/sda1";
    fsType = "ntfs";
    options = [
      "users"
      "nofail"
    ];
  };
  hardware.nvidia-container-toolkit.enable = true;
  # Services
  virtualisation = {
    docker = {
      enable = true;
      rootless.enable = true;
      enableOnBoot = true;
    };
    oci-containers = {
      backend = "docker";
      containers = {
        open-webui = {
          image = "ghcr.io/open-webui/open-webui:main";
          ports = [
            "3000:8080"
          ];
          volumes = [
            "open-webui:/app/backend/data"
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
      disableTaildrop = true;
      useRoutingFeatures = "both";
    };
    prowlarr = {
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
    flaresolverr = {
      enable = true;
      openFirewall = true;
    };
    immich = {
      enable = true;
      openFirewall = true;
      machine-learning.enable = true;
      mediaLocation = "/media/photos";
      host = "0.0.0.0";
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
