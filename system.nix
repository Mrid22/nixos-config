{
  config,
  pkgs,
  ...
}: {
  # Bootloader
  boot = {
    loader = {
      systemd-boot.enable = true;
      efi.canTouchEfiVariables = true;
    };
    kernelParams = ["snd_hda_intel.power_save=0"];
  };
}
