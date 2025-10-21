{
  config,
  pkgs,
  inputs,
  ...
}:
{
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
    mkdir -p /media/home/config
  '';
  services = {
    sonarr = {
      enable = true;
      openFirewall = true;
    };
    radarr = {
      enable = true;
      openFirewall = true;
    };
    home-assistant = {
      enable = true;
      openFirewall = true;
      configDir = "/media/home/config";
    };
    prowlarr = {
      enable = true;
      openFirewall = true;
    };
    flaresolverr = {
      enable = true;
      openFirewall = true;
    };
    jellyfin = {
      enable = true;
      openFirewall = true;
    };
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
      package = pkgs.transmission_4;
      settings = {
        download-dir = "/media/downloads/downloads";
        incomplete-dir = "/media/downloads/incomplete";
        incomplete-dir-enabled = true;
      };
    };
  };
}
