{
  config,
  pkgs,
  inputs,
  ...
}: {
  programs = {
    gh.enable = true;
    nh = {
      enable = true;
      flake = "/home/mridula/nixos-config";
    };
    kitty = {
      enable = true;
      settings.background_opacity = 0.5;
    };
    oh-my-posh = {
      enable = true;
      enableZshIntegration = true;
    };
    zsh = {
      enable = true;
      enableCompletion = true;
      autosuggestion.enable = true;
      syntaxHighlighting.enable = true;
      oh-my-zsh = {
        enable = true;
        plugins = [
          "git"
          "sudo"
        ];
      };
      shellAliases = {
        "nvim" = "nix run /home/mridula/nixos-config --";
      };
    };
    zoxide = {
      enable = true;
      enableZshIntegration = true;
      options = [
        "--cmd cd"
      ];
    };
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
  };
}
