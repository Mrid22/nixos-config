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
  services = {
    jellyfin = {
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
    netbird = {
      enable = true;
    };
    immich = {
      enable = true;
      openFirewall = true;
      machine-learning.enable = true;
      mediaLocation = "/media/photos";
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
