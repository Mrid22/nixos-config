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
  environment.etc."nextcloud-admin-pass".text = "PWD";
  services = {
    nextcloud = {
      enable = true;
      package = pkgs.nextcloud31;
      hostName = "localhost";
      config = {
        adminpassFile = "/etc/nextcloud-admin-pass";
        dbtype = "sqlite";
      };
      settings.trusted_domains = ["nixos"];
    };

    jellyfin = {
      enable = true;
      openFirewall = true;
    };
    headscale = {
      enable = true;
      port = 8081;
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
      host = "0.0.0.0";
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
            "127.0.0.1:3000:8080"
          ];
          volumes = [
            "open-webui:/app/backend/data"
          ];
          extraOptions = [
            "--network=host"
          ];
        };
      };
    };
  };
}
