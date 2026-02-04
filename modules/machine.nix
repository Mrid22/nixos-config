{
  inputs,
  self,
  ...
}: {
  flake = {
    nixosConfigurations.myMachine = inputs.nixpkgs.lib.nixosSystem {
      modules = [
        self.nixosModules.myFirstModule
        self.nixosModules.myMachineModule
        self.nixosModules.myFirstHardwareModule

        inputs.disko.nixosModules.default
        self.nixosModules.myFirstDisk
      ];
    };
    nixosModules.myMachineModule = {pkgs, ...}: {
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
  };
}
