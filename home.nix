{ config, pkgs, ... }:

{
  home.username = "mridula";
  home.homeDirectory = "/home/mridula";
  home.stateVersion = "25.05"; # Please read the comment before changing.
  home.packages = [
  ];
  programs.git = {
   enable = true;
   settings = {
     init.defaultBranch = "main";
     push.autoSetupRemote = true;
     user = {
       email = "mridulaga@outlook.com";
       name = "Mrid22";
     };
   };
  };
  programs.delta = {
    enable = true;
    enableGitIntegration = true;
  };
  home.file = {
  };

  home.sessionVariables = {
  };

  programs.home-manager.enable = true;
}
