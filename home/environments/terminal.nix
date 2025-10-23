{
  config,
  pkgs,
  inputs,
  ...
}: {
  programs = {
    kitty.enable = true;
    delta = {
      enable = true;
      enableGitIntegration = true;
    };
    git = {
      enable = true;
      settings = {
        init.defaultBranch = "main";
        user = {
          name = "Mrid22";
          email = "mridulaga@outlook.com";
        };
      };
    };
    zsh = {
      enable = true;
      autosuggestion.enable = true;
      syntaxHighlighting.enable = true;
      shellAliases = {
        cd = "z";
        cdi = "zi";
      };
      oh-my-zsh = {
        enable = true;
        plugins = [
          "sudo"
          "git"
        ];
      };
    };
    nh = {
      enable = true;
      flake = "/home/mridula/nixos-config";
      clean.enable = true;
    };
    fzf = {
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
    oh-my-posh = {
      enable = true;
      enableZshIntegration = true;
    };
    pay-respects = {
      enable = true;
      enableZshIntegration = true;
    };
  };
}
