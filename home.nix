{
  config,
  pkgs,
  inputs,
  ...
}:

{
  imports = [ inputs.zen-browser.homeModules.twilight ];
  home = {
    username = "mridula";
    homeDirectory = "/home/mridula";
    stateVersion = "25.05"; # Please read the comment before changing.
  };

  gtk = {
    enable = true;
    theme = {
      package = pkgs.layan-gtk-theme;
      name = "Layan-Dark";
    };
  };

  programs = {
    zen-browser = {
      enable = true;
      profiles.mridula.extensions.packages =
        with inputs.firefox-addons.packages.${pkgs.stdenv.hostPlatform.system}; [
          ublock-origin
          dearrow
          proton-pass
        ];
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

    home-manager.enable = true;
  };

  wayland.windowManager.hyprland = {
    enable = true;
    settings = {
      bind = [
        "ALT,Q,exec,kitty"
        "ALT,F,exec,zen-twilight"
        "ALT,C,killactive"
        "ALT,H,movefocus,l"
        "ALT,J,movefocus,d"
        "ALT,K,movefocus,u"
        "ALT,L,movefocus,r"

        "ALT,1,workspace,1"
        "ALT,2,workspace,2"
        "ALT,3,workspace,3"
        "ALT,4,workspace,4"
        "ALT,5,workspace,5"
        "ALT,6,workspace,6"
        "ALT,7,workspace,7"
        "ALT,8,workspace,8"
        "ALT,9,workspace,9"
        "ALT,0,workspace,10"

        "ALT SHIFT,1,movetoworkspace,1"
        "ALT SHIFT,2,movetoworkspace,2"
        "ALT SHIFT,3,movetoworkspace,3"
        "ALT SHIFT,4,movetoworkspace,4"
        "ALT SHIFT,5,movetoworkspace,5"
        "ALT SHIFT,6,movetoworkspace,6"
        "ALT SHIFT,7,movetoworkspace,7"
        "ALT SHIFT,8,movetoworkspace,8"
        "ALT SHIFT,9,movetoworkspace,9"
        "ALT SHIFT,0,movetoworkspace,10"
      ];
    };
  };
}
