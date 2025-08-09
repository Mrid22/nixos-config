{
  config,
  pkgs,
  inputs,
  ...
}: {
  home.packages = with pkgs; [
    tree
  ];
  programs = {
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

    zsh = {
      enable = true;
      enableCompletion = true;
      syntaxHighlighting.enable = true;
      autosuggestion.enable = true;
      oh-my-zsh = {
        enable = true;
        plugins = ["git" "sudo"];
      };
    };

    oh-my-posh = {
      enable = true;
      enableZshIntegration = true;
    };

    pay-respects.enable = true;
    atuin.enable = true;
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

    cava = {
      enable = true;
    };

    nh = {
      enable = true;
      flake = "/etc/nixos/nixos-backup/";
    };

    superfile = {
      enable = true;
      settings = {
        transparent_background = true;
        theme = "tokyonight-storm";
      };
    };
  };
}
