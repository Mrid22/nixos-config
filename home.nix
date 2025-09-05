{ config, pkgs, inputs, ... }:

{
  imports = [
   ./terminal.nix
   inputs.zen-browser.homeModules.twilight
  # inputs.gauntlet.homeManagerModules.default`
  ];

  programs.zen-browser.enable = true;
 # programs.gauntlet = {
 #   enable = true;
 #   service.enable = true;
 #   config = {};
 # };
  home.username = "mridula";
  home.homeDirectory = "/home/mridula";

  home.stateVersion = "25.05";

  home.packages = [
  ];


  home.sessionVariables = {
  };

  # Let Home Manager install and manage itself.
  programs.home-manager.enable = true;

  programs.nvf = {
    enable = true;
    settings = {
      vim = {
        viAlias = true;
	vimAlias = true;
	lsp.enable = true;
      };
    };
  };
}
