{ config, pkgs, ... }:

{
  home = {
    username = "mridula";
    homeDirectory = "/home/mridula";
    stateVersion = "25.05"; # Please read the comment before changing.
  };

  programs = {
    git = {
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

    delta = {
      enable = true;
      enableGitIntegration = true;
    };

    home-manager.enable = true;
  };

  wayland.windowManager.hyprland = {
    enable = true;
  };
}
