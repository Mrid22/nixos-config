{inputs, ...}: {
  flake.nixosConfigurations.nixos =
    inputs.nixpkgs.lib.nixosSystem
    {
      specialArgs = {inherit inputs;};
      modules = [
        inputs.self.nixosModules.config
        inputs.self.nixosModules.hardware-config
      ];
    };
}
