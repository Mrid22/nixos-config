{config,pkgs,...}:
{
  programs.git = {
    enable = true;
    userName = "Mrid22";
    userEmail = "mridulaga@outlook.com";
    delta.enable = true;
    extraConfig = {
      init.defaultBranch = "main";
    };
  };

  programs.kitty = {
    enable = true;
    shellIntegration.enableZshIntegration = true;
    enableGitIntegration = true;
    settings = {
      background_opacity = 0.5;
    };
  };

  programs.zsh = {
    enable = true;
    enableCompletion = true;
    syntaxHighlighting.enable = true;
    autosuggestion.enable = true;
    oh-my-zsh = {
      enable = true;
      plugins = ["git" "sudo"];
    };
  };

  programs.oh-my-posh = {
    enable = true;
    enableZshIntegration = true;
  };

  programs.pay-respects.enable = true;
  programs.atuin.enable = true;
  programs.zoxide = {
    enable = true;
    enableZshIntegration = true;
    options = [
      "--cmd cd"
    ];
  };
  programs.fzf = {
    enable = true;
    enableZshIntegration = true;
  };

  programs.cava = {
    enable = true;
  };

  programs.nh = {
    enable = true;
    flake = "/etc/nixos/";
    clean.enable = true;
  };

}
