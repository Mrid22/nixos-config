{
  flake.nixosModules.lenovo-laptop-config = {
    pkgs,
    lib,
    ...
  }: {
    nixpkgs.config.allowUnfreePredicate = pkg:
      builtins.elem (lib.getName pkg) [
        "nvidia-x11"
      ];
    boot.loader = {
      systemd-boot.enable = true;
      efi.canTouchEfiVariables = true;
    };
    networking.hostName = "lenovo-laptop";
    time.timeZone = "Europe/Nicosia";

    hardware.nvidia.open = true;
    services.xserver.videoDrivers = ["nvidia"];
  };
}
