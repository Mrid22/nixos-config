{
  config,
  inputs,
  ...
}: {
  programs = {
    zsh = {
      enable = true;
      enableCompletion = true;
      autosuggestion.enable = true;
      syntaxHighlighting.enable = true;
      defaultKeymap = "emacs";
      shellAliases = {
        "cd" = "z";
        "cdi" = "zi";
      };
      oh-my-zsh = {
        enable = true;
        plugins = [
          "git"
          "sudo"
        ];
      };
    };

    kitty = {
      enable = true;
      settings = {
        background_opacity = 0.5;
      };
    };

    zoxide = {
      enable = true;
      enableZshIntegration = true;
    };

    oh-my-posh = {
      enable = true;
      enableZshIntegration = true;
    };

    pay-respects = {
      enable = true;
      enableZshIntegration = true;
    };

    nh = {
      enable = true;
      clean.enable = true;
      clean.extraArgs = "--keep-since 4d --keep 3";
      flake = "/etc/nixos/nixos-config";
    };

    eza = {
      enable = true;
      enableZshIntegration = true;
      icons = "always";
      git = true;
    };

    git = {
      enable = true;
      userName = "Mrid22";
      userEmail = "mridulaga@outlook.com";
      delta.enable = true;
      extraConfig = {
        init = {
          defaultBranch = "main";
        };
      };
    };
  };
}
