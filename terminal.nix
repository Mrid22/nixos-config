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
      shellIntegration.enableZshIntegration = true;
      enableGitIntegration = true;
      settings = {
        background_opacity = 0.5;
      };
    };

    ghostty = {
      enable = true;
      enableZshIntegration = true;
      installVimSyntax = true;
    };

    fish = {
      enable = true;
      plugins = [
        {
          name = "plugin-git";
          src = pkgs.fishPlugins.plugin-git.src;
        }
      ];
    };

    oh-my-posh = {
      enable = true;
      enableZshIntegration = true;
    };

    zoxide = {
      enable = true;
      enableZshIntegration = true;
      options = [
        "--cmd cd"
      ];
    };
    fzf = {
      enable = true;
      enableZshIntegration = true;
    };

    nh = {
      enable = true;
      flake = "/etc/nixos/nixos-config/";
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
