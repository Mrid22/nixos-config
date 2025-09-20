{
config,
pkgs,
inputs,
...
}:{
  programs.git = {
    enable = true;
    userName = "Mrid22";
    userEmail = "mridulaga@outlook.com";
    delta.enable = true;
    extraConfig = {
      init.defaultBranch = "main";
    };
  };

programs.zsh = {
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

programs.nh = {
  enable = true;
  clean.enable = true;
  flake = "/home/mridula/nixos-config";
};

programs.kitty = {
  enable = true;
  shellIntegration.enableZshIntegration = true;
  settings = {
    background_opacity = 0.5;
  };
};

programs.oh-my-posh = {
  enable = true;
  enableZshIntegration = true;
};

programs.atuin = {
  enable = true;
  enableZshIntegration = true;
};

programs.zoxide = {
  enable = true;
  enableZshIntegration = true;
};
}
