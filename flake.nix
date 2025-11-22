{
  description = "Nixos config flake";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";

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
      inputs = {
        nixpkgs.follows = "nixpkgs";
        home-manager.follows = "home-manager";
      };
    };

    firefox-addons = {
      url = "gitlab:rycee/nur-expressions?dir=pkgs/firefox-addons";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    vicinae = {
      url = "github:vicinaehq/vicinae";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    selfhostblocks = {
      url = "github:ibizaman/selfhostblocks";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs = {
    self,
    nixpkgs,
    nvf,
    vicinae,
    selfhostblocks,
    ...
  } @ inputs: let
    system = "x86_64-linux";
    lib = selfhostblocks.lib.${system};

    nixpkgs' = lib.shb.patchedNixpkgs;

    nixosSystem' = import "${nixpkgs'}/nixos/lib/eval-config.nix";
  in {
    nixosConfigurations.nixos = nixosSystem' {
      inherit system;
      specialArgs = {inherit inputs;};
      modules = [
        ./configuration.nix
        inputs.home-manager.nixosModules.default
        selfhostblocks.nixosModules.default
      ];
    };
  };
}
