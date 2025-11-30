{...}: {
  programs = {
    kitty.enable = true;

    delta = {
      enable = true;
      enableGitIntegration = true;
    };

    atuin = {
      enable = true;
      enableZshIntegration = true;
    };

    oh-my-posh = {
      enable = true;
      enableZshIntegration = true;
    };

    nh = {
      enable = true;
      clean.enable = true;
      flake = "/home/mridula/nixos-config";
    };

    zoxide = {
      enable = true;
      enableZshIntegration = true;
      options = [
        "--cmd cd"
      ];
    };

    eza = {
      enable = true;
      enableZshIntegration = true;
      git = true;
      icons = "auto";
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
      shellAliases = {
        nvim = "nix run ~/nixos-config";
      };
      oh-my-zsh = {
        enable = true;
        plugins = [
          "git"
          "sudo"
        ];
      };
    };
  };
}
