{ config, pkgs, ... }:
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
    mkdir -p /media/downloads/incomplete
    mkdir -p /media/tv
    mkdir -p /media/photos
  '';
  services = {
    sonarr = {
      enable = true;
      openFirewall = true;
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
    declarative-jellyfin = {
      enable = true;
    };
  };
}
