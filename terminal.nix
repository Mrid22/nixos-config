{
  config,
  pkgs,
  inputs,
  ...
}: {
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

    zsh = {
      enable = true;
      autocd = true;
      defaultKeymap = "emacs";
      syntaxHighlighting.enable = true;
      autosuggestion.enable = true;
      shellAliases = {
        "cd" = "z";
        "cdi" = "zi";
      };
      oh-my-zsh = {
        enable = true;
        plugins = ["git" "sudo"];
      };
    };

    nh = {
      enable = true;
      clean.enable = true;
      flake = "/home/mridula/nixos-config";
    };

    kitty = {
      enable = true;
      shellIntegration.enableZshIntegration = true;
      settings = {
        background_opacity = 0.5;
      };
    };

    oh-my-posh = {
      enable = true;
      enableZshIntegration = true;
    };

    atuin = {
      enable = true;
      enableZshIntegration = true;
    };

    zoxide = {
      enable = true;
      enableZshIntegration = true;
    };
  };
}
