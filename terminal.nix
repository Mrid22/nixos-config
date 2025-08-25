{
  config,
  pkgs,
  inputs,
  lib,
  ...
}: {
  home.packages = with pkgs; [
    tree
  ];
  programs = {
    cava.enable = true;
    atuin.enable = true;
    pay-respects.enable = true;
    ripgrep.enable = true;
    lazygit.enable = true;

    git = {
      enable = true;
      userName = "Mrid22";
      userEmail = "mridulaga@outlook.com";
      delta.enable = true;
      extraConfig = {
        init.defaultBranch = "main";
      };
    };

    kitty = {
      enable = true;
      shellIntegration.enableFishIntegration = true;
      enableGitIntegration = true;
      settings = {
        background_opacity = 0.5;
      };
    };

    fish = {
      enable = true;
      shellAbbrs = {
        r = "rebuild";
      };
      plugins = [
        {
          name = "plugin-git";
          src = pkgs.fishPlugins.plugin-git.src;
        }
      ];
      shellInit = ''
        set fish_greeting
      ''
    };

    oh-my-posh = {
      enable = true;
      enableFishIntegration = true;
    };

    zoxide = {
      enable = true;
      enableFishIntegration = true;
      options = [
        "--cmd cd"
      ];
    };
    fzf = {
      enable = true;
      enableFishIntegration = true;
    };

    nh = {
      enable = true;
      flake = "/etc/nixos/nixos-config/";
      clean.enable = true;
    };

    yazi.enable = true;

    fastfetch = {
      enable = true;
      settings = {
        modules = [
          "title"
          "separator"
          "os"
          "kernel"
          "packages"
          "display"
          "de"
          "wm"
          "theme"
          "shell"
          "terminal"
          "cpu"
          "gpu"
          "memory"
          "disk"
          "localip"
          "battery"
        ];
      };
    };
  };
}
