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
}
