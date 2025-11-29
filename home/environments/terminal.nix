{
  config,
  pkgs,
  inputs,
  ...
}: {
  programs = {
    delta = {
      enable = true;
      enableZshIntegration = true;
    };
    git = {
      enable = true;
      settings = {
        user = {
          email = "mridulaga@outlook.com";
          name = "Mrid22";
        };
        init.defaultBranch = "main";
        push.autoSetupRemote = true;
      };
    };

    zsh = {
      enable = true;
      autosuggestion.enable = true;
      syntaxHighlighting.enable = true;
      oh-my-zsh = {
        enable = true;
        plugins = [
          "git"
          "sudo"
        ];
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
      options = [
        "--cmd cd"
      ];
    };

    nh = {
      enable = true;
      clean.enable = true;
      flake = "/home/mridula/nixos-config";
    };

    eza = {
      enable = true;
      enableZshIntegration = true;
      git = true;
      icons = "auto";
    };

    kitty.enable = true;
  };
}
