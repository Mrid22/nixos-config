{
  inputs,
  self,
  ...
}: {
  flake.nixosConfigurations.myMachine = inputs.nixpkgs.lib.nixosSystem {
    modules = [
      self.nixosModules.myFirstModule
      self.nixosModules.myMachineModule
      self.nixosModules.myFirstHardwareModule

      inputs.disko.nixosModules.default
      self.nixosModules.myFirstDisk
    ];
  };
}
