{ config, pkgs, inputs, ... }:

{
  imports = [inputs.nvf.homeManagerModules.default];
  home.username = "mridula";
  home.homeDirectory = "/home/mridula";
  home.stateVersion = "25.05";

  programs.git = {
    enable = true;
    settings = {
      user = {
        email = "mridulaga@Outlook.com";
	name = "Mrid22";
      };
      init.defaultBranch = "main";
      push.autoSetupRemote = true;
    };
  };

  programs.nvf = {
    enable = true;
    settings.vim = {
      viAlias = true;
      vimAlias = true;
      lsp.enable = true;
    };
  };

  home.sessionVariables = {
  };

  programs.home-manager.enable = true;
}
