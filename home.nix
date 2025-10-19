{
  config,
  pkgs,
  inputs,
  ...
}:

{
  home = {
    username = "mridula";
    homeDirectory = "/home/mridula";
    stateVersion = "25.05";
  };
  gtk = {
    enable = true;
    colorScheme = "dark";
    theme = {
      name = "Layan-Dark";
      package = pkgs.layan-gtk-theme;
    };
  };
  wayland.windowManager.hyprland = {
    enable = true;
    settings = {
      input.touchpad.natural_scroll = true;
      "$mod" = "ALT";
      bind = [
        # Apps
        "$mod, Q, exec, kitty"
        "$mod, F, exec, floorp"
        # Windows
        "$mod, H, movefocus, l"
        "$mod, J, movefocus, d"
        "$mod, K, movefocus, u"
        "$mod, L, movefocus, r"
        "$mod, C, killactive"
        #Workspaces
        "$mod, 1, workspace, 1"
        "$mod, 2, workspace, 2"
        "$mod, 3, workspace, 3"
        "$mod, 4, workspace, 4"
        "$mod, 5, workspace, 5"
        "$mod, 6, workspace, 6"
        "$mod, 7, workspace, 7"
        "$mod, 8, workspace, 8"
        "$mod, 9, workspace, 9"
        "$mod, 0, workspace, 10"

        "$mod SHIFT, 1, movetoworkspace, 1"
        "$mod SHIFT, 2, movetoworkspace, 2"
        "$mod SHIFT, 3, movetoworkspace, 3"
        "$mod SHIFT, 4, movetoworkspace, 4"
        "$mod SHIFT, 5, movetoworkspace, 5"
        "$mod SHIFT, 6, movetoworkspace, 6"
        "$mod SHIFT, 7, movetoworkspace, 7"
        "$mod SHIFT, 8, movetoworkspace, 8"
        "$mod SHIFT, 9, movetoworkspace, 9"
        "$mod SHIFT, 0, movetoworkspace, 10"
      ];
    };
  };
  programs = {
    git = {
      enable = true;
      userName = "Mrid22";
      userEmail = "mridulaga@outlook.com";
      delta.enable = true;
      extraConfig.init.defaultBranch = "main";
    };
    kitty = {
      enable = true;
      settings.background_opacity = 0.5;
    };
    zsh = {
      enable = true;
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
    nvf = {
      enable = true;
      settings.vim = {
        viAlias = true;
        vimAlias = true;
        languages.nix.enable = true;
        lsp.enable = true;
        lsp.formatOnSave = true;
      };
    };
    floorp = {
      enable = true;
      profiles.mridula = {
        extensions = {
          packages = with inputs.firefox-addons.packages.${pkgs.system}; [
            ublock-origin
            privacy-badger
            proton-pass
            ctrl-number-to-switch-tabs
            dearrow
            decentraleyes
            #improved-tube
          ];
        };
        search = {
          default = "ddg";
          engines = {
            MyNixOS = {
              name = "MyNixOS";
              definedAliases = [ "!nx" ];
              urls = [
                {
                  template = "https://mynixos.com/search";
                  params = [
                    {
                      name = "q";
                      value = "{searchTerms}";
                    }
                  ];
                }
              ];

              icon = "${pkgs.nixos-icons}/share/icons/hicolor/scalable/apps/nix-snowflake.svg";
            };
          };
        };
      };
    };
    home-manager.enable = true;
  };
}
