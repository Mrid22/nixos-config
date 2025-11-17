{
  description = "Nixos config flake";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";
    selfhostblocks.url = "github:ibizaman/selfhostblocks";

    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    nvf = {
      url = "github:notashelf/nvf";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    zen-browser = {
      url = "github:0xc000022070/zen-browser-flake";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    firefox-addons = {
      url = "gitlab:rycee/nur-expressions?dir=pkgs/firefox-addons";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    vicinae = {
      url = "github:vicinaehq/vicinae";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs = {
    self,
    nixpkgs,
    nvf,
    selfhostblocks,
    ...
  } @ inputs: let
    system = "x86_64-linux";
    shb = selfhostblocks.lib.${system};
  in {
    packages."x86_64-linux".default =
      (nvf.lib.neovimConfiguration {
        pkgs = nixpkgs.legacyPackages."x86_64-linux";
        modules = [./home/apps/nvf.nix];
      }).neovim;

    nixosConfigurations.nixos = shb.pkgs.nixosSystem {
      specialArgs = {inherit inputs;};
      inherit system;
      modules = [
        ./configuration.nix
        inputs.home-manager.nixosModules.default
        selfhostblocks.nixosModules.default
      ];
    };
  };
}
