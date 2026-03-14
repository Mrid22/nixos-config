{
  flake.nixosModules.lenovo-laptop-hardware-config = {
    config,
    lib,
    modulesPath,
    ...
  }: {
    imports = [
      (modulesPath + "/installer/scan/not-detected.nix")
    ];
    boot = {
      initrd = {
        availableKernelModules = ["xhci_pci" "thunderbolt" "nvme" "uas" "sd_mod" "rtsx_pci_sdmmc"];
        kernelModules = [];
      };
      kernelModules = ["kvm-intel"];
      extraModulePackages = [];
    };
    fileSystems = {
      "/" = {
        device = "/dev/disk/by-uuid/c2fa439c-7d12-480a-be10-fe1e8f94e881";
        fsType = "ext4";
      };

      "/boot" = {
        device = "/dev/disk/by-uuid/AC64-5F32";
        fsType = "vfat";
        options = ["fmask=0077" "dmask=0077"];
      };
    };

    swapDevices = [{device = "/dev/disk/by-uuid/ffdd9502-64e8-480c-bf5b-9425e5fef170";}];

    nixpkgs.hostPlatform = lib.mkDefault "x86_64-linux";
    hardware.cpu.intel.updateMicrocode = lib.mkDefault config.hardware.enableRedistributableFirmware;
  };
}
