{inputs, ...}: {
  flake = {
    nixosConfigurations.nixos = inputs.nixpkgs.lib.nixosSystem {
      specialArgs = {inherit inputs;};
      modules = [
        inputs.disko.nixosModules.default
        ./disk-config.nix

        ./configuration.nix

        inputs.home-manager.nixosModules.default
        {
          home-manager = {
            extraSpecialArgs = {inherit inputs;};
            users.mridula = import ./home.nix;
          };
        }
      ];
    };
  };
}
