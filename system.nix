{inputs, ...}: {
  flake = {
    nixosConfigurations.nixos = inputs.nixpkgs.lib.nixosSystem {
      specialArgs = {inherit inputs;};
      modules = [
        inputs.disko.nixosModules.default
        ./disk-config.nix

        ./configuration.nix
        inputs.stylix.nixosModules.stylix

        inputs.home-manager.nixosModules.default
        {
          home-manager = {
            useGlobalPkgs = true;
            useUserPackages = true;
            backupFileExtension = "bak";
            users.mridula = ./home.nix;

            extraSpecialArgs = {inherit inputs;};
          };
        }
      ];
    };
  };
}
