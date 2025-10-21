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
  '';
  services = {
    sonarr = {
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
    jellyfin = {
      enable = true;
      openFirewall = true;
    };
    tailscale = {
      enable = true;
      openFirewall = true;
      useRoutingFeatures = "both";
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
