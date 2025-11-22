{
  config,
  pkgs,
  inputs,
  ...
}: {
  imports = [
    inputs.nvf.homeManagerModules.default
    inputs.zen-browser.homeModules.twilight
    inputs.vicinae.homeManagerModules.default
  ];
  home = {
    username = "mridula";
    homeDirectory = "/home/mridula";
    stateVersion = "25.05";

    sessionVariables = {
    };
  };
  gtk = {
    enable = true;
    theme = {
      name = "Layan-Dark";
      package = pkgs.layan-gtk-theme;
    };
  };
  services = {
    vicinae = {
      enable = true;
      autoStart = true;
      settings = {
        faviconService = "twenty";
        popToRootOnClose = false;
        rootSearch.searchFiles = true;
        theme.name = "tokyonight-storm";
      };
    };
    hyprpaper = {
      enable = true;
      settings = {
        ipc = "on";
        splash = false;
        splash_offset = 2.0;

        preload = ["~/nixos-config/Wallpaper.jpg"];

        wallpaper = [
          ",~/nixos-config/Wallpaper.jpg"
        ];
      };
    };
  };
  programs = {
    zen-browser = {
      enable = true;
      profiles.mridula = {
        extensions.packages = with inputs.firefox-addons.packages.${pkgs.stdenv.hostPlatform.system}; [
          ublock-origin
          dearrow
          proton-pass
          decentraleyes
          censor-tracker
          snowflake
        ];
        search = {
          default = "ddg";
          engines = {
            mynixos = {
              name = "My NixOS";
              urls = [
                {
                  template = "https://mynixos.com/search?q={searchTerms}";
                  params = [
                    {
                      name = "query";
                      value = "{searchTerms}";
                    }
                  ];
                }
              ];

              icon = "${pkgs.nixos-icons}/share/icons/hicolor/scalable/apps/nix-snowflake.svg";
              definedAliases = ["@nx"];
            };
          };
        };
      };
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
    zoxide = {
      enable = true;
      enableZshIntegration = true;
      options = [
        "--cmd cd"
      ];
    };
    kitty = {
      enable = true;
      settings.background_opacity = 0.5;
    };

    nvf = {
      enable = true;
      settings.vim = {
        viAlias = true;
        vimAlias = true;
        lineNumberMode = "none";
        options = {
          tabstop = 2;
          shiftwidth = 2;
        };
        theme = {
          enable = true;
          name = "tokyonight";
          style = "storm";
          transparent = true;
        };
        statusline.lualine.enable = true;
        lsp = {
          enable = true;
          formatOnSave = true;
        };
        languages = {
          enableFormat = true;
          enableTreesitter = true;
          nix.enable = true;
        };
        autopairs.nvim-autopairs.enable = true;
        autocomplete.blink-cmp = {
          enable = true;
          friendly-snippets.enable = true;
        };
      };
    };

    home-manager.enable = true;
  };

  wayland.windowManager.hyprland = {
    enable = true;
    settings = {
      exec-once = [
        "vicinae server"
      ];
      bind = [
        "ALT, Q, exec, kitty"
        "ALT, F, exec, zen-twilight"
        "ALT, SPACE, exec, vicinae toggle"

        "ALT, C, killactive"
        "ALT, H, movefocus, l"
        "ALT, J, movefocus, d"
        "ALT, K, movefocus, u"
        "ALT, L, movefocus, r"

        "ALT, 1, workspace, 1"
        "ALT, 2, workspace, 2"
        "ALT, 3, workspace, 3"
        "ALT, 4, workspace, 4"
        "ALT, 5, workspace, 5"
        "ALT, 6, workspace, 6"
        "ALT, 7, workspace, 7"
        "ALT, 8, workspace, 8"
        "ALT, 9, workspace, 9"
        "ALT, 0, workspace, 10"

        "ALT SHIFT, 1, movetoworkspace, 1"
        "ALT SHIFT, 2, movetoworkspace, 2"
        "ALT SHIFT, 3, movetoworkspace, 3"
        "ALT SHIFT, 4, movetoworkspace, 4"
        "ALT SHIFT, 5, movetoworkspace, 5"
        "ALT SHIFT, 6, movetoworkspace, 6"
        "ALT SHIFT, 7, movetoworkspace, 7"
        "ALT SHIFT, 8, movetoworkspace, 8"
        "ALT SHIFT, 9, movetoworkspace, 9"
        "ALT SHIFT, 0, movetoworkspace, 10"
      ];
      general = {
        gaps_in = 5;
        gaps_out = 5;
        border_size = 0;
      };
      decoration.rounding = 5;
      input.touchpad = {
        natural_scroll = true;
        disable_while_typing = true;
      };
    };
  };
}
