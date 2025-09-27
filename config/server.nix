{
  config,
  pkgs,
  inputs,
  ...
}: {
  networking.firewall.checkReversePath = "loose";
  fileSystems."/media" = {
    device = "/dev/sda1";
    fsType = "ntfs";
    options = [
      "users"
      "nofail"
    ];
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
    lidarr = {
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
