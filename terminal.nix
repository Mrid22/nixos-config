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

    git = {
      enable = true;
      userName = "Mrid22";
      userEmail = "mridulaga@outlook.com";
      delta.enable = true;
      extraConfig = {
        init.defaultBranch = "main";
      };
    };

    lazygit = {
      enable = true;
    };

    kitty = {
      enable = true;
      shellIntegration.enableZshIntegration = true;
      enableGitIntegration = true;
      settings = {
        background_opacity = 0.5;
      };
    };

    zsh = {
      enable = true;
      enableCompletion = true;
      syntaxHighlighting.enable = true;
      autosuggestion.enable = true;
      oh-my-zsh = {
        enable = true;
        plugins = ["git" "sudo"];
      };
      shellAliases = {
        r = "rebuild";
      };
      initContent = lib.mkOrder 1200 ''
        fastfetch
      '';
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
      flake = "/etc/nixos/nixos-backup/";
    };

    yazi.enable = true;

    fastfetch = {
      enable = true;
      settings = {
        modules = [
          "title"
          "os"
          "localip"
          "packages"
          "WM"
          "WMTheme"
        ];
      };
    };
  };
}
