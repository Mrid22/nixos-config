{
  flake.nixosModules.myMachineModule = {
    networking.hostName = "nixos";

    hardware.nvidia = {
      modesetting.enable = true;
      open = true;
      powerManagement.finegrained = true;
      prime = {
        intelBusId = "PCI:0:2:0";
        nvidiaBusId = "PCI:1:0:0";
        offload = {
          enable = true;
          enableOffloadCmd = true;
        };
      };
    };
  };
}
