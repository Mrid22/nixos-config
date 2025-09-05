{
  config,
  inputs,
  ...
}:{
  programs.zsh = {
    enable = true;
    autosuggestion.enable = true;
    syntaxHighlighting.enable = true;
    defaultKeymap = "emacs";
    shellAliases = {
    "cd"="z";
    "cdi"="zi";
    };
  };
  programs.kitty = {
    enable = true;
    settings = {
      background_opacity = 0.5;
    };
  };
  programs.zoxide = {
    enable = true;
    enableZshIntegration = true;
  };
  programs.oh-my-posh = {
    enable = true;
    enableZshIntegration = true;
  };
  programs.pay-respects = {
    enable = true;
    enableZshIntegration = true;
  };

  programs.nh = {
    enable = true;
    clean.enable = true;
    clean.extraArgs = "--keep-since 4d --keep 3";
    flake = "/etc/nixos/nixos-config";
  };

  programs.git = {
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

}
