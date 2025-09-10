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
  services.sonarr = {
    enable = true;
    openFirewall = true;
  };
}
