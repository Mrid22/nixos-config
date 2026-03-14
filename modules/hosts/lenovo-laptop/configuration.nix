{
  flake.nixosModules.lenovo-laptop-config = {pkgs, ...}: {
    boot.loader = {
      systemd-boot.enable = true;
      efi.canTouchEfiVariables = true;
    };
    networking.hostName = "lenovo-laptop";
    time.timeZone = "Europe/Nicosia";
  };
}
