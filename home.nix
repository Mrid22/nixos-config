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

  wayland.windowManager.hyprland = {
    enable = true;
    settings = {
      binds = [
        "ALT,Q,exec,kitty"
      ];
    };
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
        preload = ["~/nixos-config/Wallpaper.jpg"];
        wallpaper = [",~/nixos-config/Wallpaper.jpg"];
      };
    };
  };

  catppuccin = {
    enable = true;
    accent = "mauve";
    flavor = "mocha";
    cache.enable = true;
  };

  wayland.windowManager.hyprland = {
    enable = true;
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

      animations = {
        enabled = "yes, please :)";
        bezier = [
          "easeOutQuint,0.23,1,0.32,1"
          "easeInOutCubic,0.65,0.05,0.36,1"
          "linear,0,0,1,1"
          "almostLinear,0.5,0.5,0.75,1.0"
          "quick,0.15,0,0.1,1"
        ];
        animation = [
          "global, 1, 10, default"
          "border, 1, 5.39, easeOutQuint"
          "windows, 1, 4.79, easeOutQuint"
          "windowsIn, 1, 4.1, easeOutQuint, popin 87%"
          "windowsOut, 1, 1.49, linear, popin 87%"
          "fadeIn, 1, 1.73, almostLinear"
          "fadeOut, 1, 1.46, almostLinear"
          "fade, 1, 3.03, quick"
          "layers, 1, 3.81, easeOutQuint"
          "layersIn, 1, 4, easeOutQuint, fade"
          "layersOut, 1, 1.5, linear, fade"
          "fadeLayersIn, 1, 1.79, almostLinear"
          "fadeLayersOut, 1, 1.39, almostLinear"
          "workspaces, 1, 1.94, almostLinear, slide"
          "workspacesIn, 1, 1.21, almostLinear, slide"
          "workspacesOut, 1, 1.94, almostLinear, slide"
        ];
      };

      exec-once = ["vicinae server"];
      bind = [
        "ALT, Q, exec, kitty"
        "ALT, F, exec,zen-browser"
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
      bindel = [
        ",XF86AudioRaiseVolume, exec, wpctl set-volume @DEFAULT_AUDIO_SINK@ 5%+"
        ",XF86AudioLowerVolume, exec, wpctl set-volume @DEFAULT_AUDIO_SINK@ 5%-"
        ",XF86AudioMute, exec, wpctl set-mute @DEFAULT_AUDIO_SINK@ toggle"
        ",XF86AudioMicMute, exec, wpctl set-mute @DEFAULT_AUDIO_SOURCE@ toggle"
        ",XF86MonBrightnessUp, exec, brightnessctl s 10%+"
        ",XF86MonBrightnessDown, exec, brightnessctl s 10%-"
      ];

      bindl = [
        ",XF86AudioNext, exec, playerctl next"
        ",XF86AudioPause, exec, playerctl play-pause"
        ",XF86AudioPlay, exec, playerctl play-pause"
        ",XF86AudioPrev, exec, playerctl previous"
      ];
    };
  };

  programs = {
    home-manager.enable = true;
    gh.enable = true;
    eza = {
      enable = true;
      git = true;
      enableZshIntegration = true;
    };
    atuin = {
      enable = true;
      enableZshIntegration = true;
    };
    caelestia = {
      enable = true;
      systemd.enable = true;
      settings.paths.wallpaperDir = "~/nixos-config";
      cli.enable = true;
    };
    firefox = {
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
