{inputs, ...}: {
  systems = ["x86_64-linux"];
  flake = {
    nixosConfigurations.lenovo-laptop =
      inputs.nixpkgs.lib.nixosSystem
      {
        specialArgs = {inherit inputs;};
        modules = [
          inputs.self.nixosModules.config
          inputs.self.nixosModules.lenovo-laptop-config
          inputs.self.nixosModules.homelab
          inputs.self.nixosModules.lenovo-laptop-hardware-config
          inputs.home-manager.nixosModules.default
          {
            home-manager = {
              extraSpecialArgs = {inherit inputs;};
              users.mridula = inputs.self.homeModules.home-config;
              useUserPackages = true;
              useGlobalPkgs = true;
            };
          }
        ];
      };
  };
}
