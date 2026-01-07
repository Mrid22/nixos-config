{
  pkgs,
  inputs,
  ...
}: {
  imports = with inputs; [
    vicinae.homeManagerModules.default
    catppuccin.homeModules.catppuccin
    caelestia-shell.homeManagerModules.default
  ];

  home = {
    username = "mridula";
    homeDirectory = "/home/mridula";
    stateVersion = "25.11";
  };
  services = {
    vicinae = {
      enable = true;
      systemd = {
        enable = true;
        autoStart = true;
      };
      settings = {
        close_on_focus_loss = true;
        search_files_in_root = true;
        pop_to_root_on_close = false;
        launcher_window.opacity = 0.5;
      };
      extensions = with inputs.vicinae-extensions.packages.${pkgs.stdenv.hostPlatform.system}; [
        bluetooth
        nix
        power-profile
        player-pilot
      ];
    };
    hyprpaper = {
      enable = true;
      settings = {
        preload = ["~/nixos-config/Wallpaper.jp"];
        wallpaper = [",~/nixos-config/Wallpaper.jp"];
      };
    };
  };

  catppuccin.enable = true;

  wayland.windowManager.hyprland = {
    enable = true;
    package = inputs.hyprland.packages.x86_64-linux.hyprland;
    plugins = [
      inputs.split-monitor-workspaces.packages.${pkgs.stdenv.hostPlatform.system}.split-monitor-workspaces
    ];
    settings = {
      general = {
        gaps_in = 5;
        gaps_out = 5;
        border_size = 0;
        resize_on_border = true;
      };
      input = {
        follow_mouse = 1;
        touchpad = {
          natural_scroll = true;
          disable_while_typing = true;
          drag_lock = 2;
          tap-and-drag = true;
          drag_3fg = 1;
        };
      };

      decoration.rounding = 5;

      exec-once = ["vicinae server"];
      bind = [
        "ALT, Q, exec, kitty"
        "ALT, F, exec, librewolf"
        "ALT, SPACE, exec, vicinae open"
        "ALT, C, killactive"
        "ALT, H, movefocus, l"
        "ALT, J, movefocus, d"
        "ALT, K, movefocus, u"
        "ALT, L, movefocus, r"

        "ALT, 1, split-workspace, 1"
        "ALT, 2, split-workspace, 2"
        "ALT, 3, split-workspace, 3"
        "ALT, 4, split-workspace, 4"
        "ALT, 5, split-workspace, 5"
        "ALT, 6, split-workspace, 6"
        "ALT, 7, split-workspace, 7"
        "ALT, 8, split-workspace, 8"
        "ALT, 9, split-workspace, 9"
        "ALT, 0, split-workspace, 10"

        "ALT SHIFT, 1, split-movetoworkspace, 1"
        "ALT SHIFT, 2, split-movetoworkspace, 2"
        "ALT SHIFT, 3, split-movetoworkspace, 3"
        "ALT SHIFT, 4, split-movetoworkspace, 4"
        "ALT SHIFT, 5, split-movetoworkspace, 5"
        "ALT SHIFT, 6, split-movetoworkspace, 6"
        "ALT SHIFT, 7, split-movetoworkspace, 7"
        "ALT SHIFT, 8, split-movetoworkspace, 8"
        "ALT SHIFT, 9, split-movetoworkspace, 9"
        "ALT SHIFT, 0, split-movetoworkspace, 10"

        "ALT SHIFT, H, split-changemonitor, prev"
        "ALT SHIFT, L, split-changemonitor, next"
      ];
    };
  };

  programs = {
    home-manager.enable = true;
    nh = {
      enable = true;
      clean = {
        enable = true;
        extraArgs = "--keep-since 4d --keep 3";
      };
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
    zoxide = {
      enable = true;
      enableZshIntegration = true;
      options = [
        "--cmd cd"
      ];
    };
    eza = {
      enable = true;
      git = true;
      enableZshIntegration = true;
    };
    atuin = {
      enable = true;
      enableZshIntegration = true;
    };
    zsh = {
      enable = true;
      autosuggestion.enable = true;
      syntaxHighlighting.enable = true;
      oh-my-zsh = {
        enable = true;
        plugins = ["git" "sudo"];
      };
      shellAliases."nvim" = "nix run ~/nixos-config";
    };
    caelestia = {
      enable = true;
      systemd.enable = true;
      settings.paths.wallpaperDir = "~/nixos-config";
      cli.enable = true;
    };
    librewolf = {
      enable = true;
      profiles.mridula = {
        extensions = {
          force = true;
          packages = with inputs.firefox-addons.packages.${pkgs.stdenv.hostPlatform.system}; [
            ublock-origin
            dearrow
            darkreader
            proton-pass
            canvasblocker
            noscript
            sponsorblock
            catppuccin-web-file-icons
            catppuccin-mocha-mauve
            censor-tracker
            clearurls
            consent-o-matic
            noscript
            firenvim
            snowflake
            ctrl-number-to-switch-tabs
          ];
        };
        search = {
          force = true;
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
                      value = "searchTerms";
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
  };
}
