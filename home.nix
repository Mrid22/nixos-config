{
  config,
  pkgs,
  inputs,
  ...
}: {
  imports = [
    inputs.zen-browser.homeModules.twilight
    inputs.gauntlet.homeManagerModules.default
    ./terminal.nix
    ./de.nix
  ];

  home = {
    username = "mridula";
    homeDirectory = "/home/mridula";
    stateVersion = "25.05";
    packages = with pkgs; [
      spotdl
    ];
  };

  programs = {
    gauntlet = {
      enable = true;
      service.enable = true;
      config = {};
    };

    zen-browser = {
      enable = true;
      policies = {};
    };

    home-manager.enable = true;
  };
}
