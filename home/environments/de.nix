{
  pkgs,
  inputs,
  ...
}: {
  imports = with inputs; [
    vicinae.homeManagerModules.default
    caelestia-shell.homeManagerModules.default
    ags.homeManagerModules.default
  ];
  services = {
    swww.enable = true;
    vicinae = {
      enable = true;
      autoStart = true;
      settings = {
        faviconService = "twenty";
        popToRootOnClose = true;
        rootSearch.searchFiles = true;
      };
      extensions = with inputs.vicinae-extensions.packages.${pkgs.stdenv.hostPlatform.system}; [
        bluetooth
        nix
        power-profile
        it-tools
        hypr-keybinds
        otp
        player-pilot
        process-manager
      ];
    };
  };
  programs = {
    ags = {
      enable = true;
      configDir = inputs.self + /ags;
      extraPackages = with pkgs; [
        inputs.astal.packages.${pkgs.stdenv.hostPlatform.system}.battery
        inputs.astal.packages.${pkgs.stdenv.hostPlatform.system}.hyprland
        fzf
      ];
    };
    hyprshot.enable = true;
    caelestia = {
      enable = true;
      systemd = {
        enable = true;
        target = "graphical-session.target";
      };
      cli = {
        enable = true;
        settings = {
          appearance = {
            anim = {
              durations = {
                scale = 1;
              };
            };
            font = {
              family = {
                clock = "Rubik";
                material = "Material Symbols Rounded";
                mono = "CaskaydiaCove NF";
                sans = "Rubik";
              };
              size = {
                scale = 1;
              };
            };
            padding = {
              scale = 1;
            };
            rounding = {
              scale = 1;
            };
            spacing = {
              scale = 1;
            };
            transparency = {
              enabled = false;
              base = 0.85;
              layers = 0.4;
            };
          };
          general = {
            apps = {
              terminal = [
                "kitty"
              ];
              audio = [
                "pavucontrol"
              ];
              playback = [
                "mpv"
              ];
              explorer = [
                "thunar"
              ];
            };
            battery = {
              warnLevels = [
                {
                  level = 20;
                  title = "Low battery";
                  message = "You might want to plug in a charger";
                  icon = "battery_android_frame_2";
                }
                {
                  level = 10;
                  title = "Did you see the previous message?";
                  message = "You should probably plug in a charger <b>now</b>";
                  icon = "battery_android_frame_1";
                }
                {
                  level = 5;
                  title = "Critical battery level";
                  message = "PLUG THE CHARGER RIGHT NOW!!";
                  icon = "battery_android_alert";
                  critical = true;
                }
              ];
              criticalLevel = 3;
            };
            idle = {
              lockBeforeSleep = true;
              inhibitWhenAudio = true;
              timeouts = [
                {
                  timeout = 180;
                  idleAction = "lock";
                }
                {
                  timeout = 300;
                  idleAction = "dpms off";
                  returnAction = "dpms on";
                }
              ];
            };
          };
          background = {
            desktopClock = {
              enabled = false;
            };
            enabled = true;
            visualiser = {
              blur = true;
              enabled = true;
              autoHide = true;
              rounding = 1;
              spacing = 1;
            };
          };
          bar = {
            clock = {
              showIcon = true;
            };
            dragThreshold = 20;
            entries = [
              {
                id = "logo";
                enabled = true;
              }
              {
                id = "workspaces";
                enabled = true;
              }
              {
                id = "spacer";
                enabled = true;
              }
              {
                id = "activeWindow";
                enabled = true;
              }
              {
                id = "spacer";
                enabled = true;
              }
              {
                id = "tray";
                enabled = true;
              }
              {
                id = "clock";
                enabled = true;
              }
              {
                id = "statusIcons";
                enabled = true;
              }
              {
                id = "power";
                enabled = true;
              }
            ];
            persistent = true;
            popouts = {
              activeWindow = true;
              statusIcons = true;
              tray = true;
            };
            scrollActions = {
              brightness = true;
              workspaces = true;
              volume = true;
            };
            showOnHover = true;
            status = {
              showAudio = false;
              showBattery = true;
              showBluetooth = true;
              showKbLayout = false;
              showMicrophone = false;
              showNetwork = true;
              showLockStatus = true;
            };
            tray = {
              background = false;
              compact = false;
              iconSubs = [];
              recolour = false;
            };
            workspaces = {
              activeIndicator = true;
              activeLabel = "󰮯";
              activeTrail = false;
              label = "  ";
              occupiedBg = false;
              occupiedLabel = "󰮯";
              perMonitorWorkspaces = true;
              showWindows = true;
              shown = 5;
              specialWorkspaceIcons = [
                {
                  name = "steam";
                  icon = "sports_esports";
                }
              ];
            };
            excludedScreens = [
              ""
            ];
            activeWindow = {
              inverted = false;
            };
          };
          border = {
            rounding = 25;
            thickness = 10;
          };
          dashboard = {
            enabled = true;
            dragThreshold = 50;
            mediaUpdateInterval = 500;
            showOnHover = true;
          };
          launcher = {
            actionPrefix = ">";
            actions = [
              {
                name = "Calculator";
                icon = "calculate";
                description = "Do simple math equations (powered by Qalc)";
                command = [
                  "autocomplete"
                  "calc"
                ];
                enabled = true;
                dangerous = false;
              }
              {
                name = "Scheme";
                icon = "palette";
                description = "Change the current colour scheme";
                command = [
                  "autocomplete"
                  "scheme"
                ];
                enabled = true;
                dangerous = false;
              }
              {
                name = "Wallpaper";
                icon = "image";
                description = "Change the current wallpaper";
                command = [
                  "autocomplete"
                  "wallpaper"
                ];
                enabled = true;
                dangerous = false;
              }
              {
                name = "Variant";
                icon = "colors";
                description = "Change the current scheme variant";
                command = [
                  "autocomplete"
                  "variant"
                ];
                enabled = true;
                dangerous = false;
              }
              {
                name = "Transparency";
                icon = "opacity";
                description = "Change shell transparency";
                command = [
                  "autocomplete"
                  "transparency"
                ];
                enabled = false;
                dangerous = false;
              }
              {
                name = "Random";
                icon = "casino";
                description = "Switch to a random wallpaper";
                command = [
                  "caelestia"
                  "wallpaper"
                  "-r"
                ];
                enabled = true;
                dangerous = false;
              }
              {
                name = "Light";
                icon = "light_mode";
                description = "Change the scheme to light mode";
                command = [
                  "setMode"
                  "light"
                ];
                enabled = true;
                dangerous = false;
              }
              {
                name = "Dark";
                icon = "dark_mode";
                description = "Change the scheme to dark mode";
                command = [
                  "setMode"
                  "dark"
                ];
                enabled = true;
                dangerous = false;
              }
              {
                name = "Shutdown";
                icon = "power_settings_new";
                description = "Shutdown the system";
                command = [
                  "systemctl"
                  "poweroff"
                ];
                enabled = true;
                dangerous = true;
              }
              {
                name = "Reboot";
                icon = "cached";
                description = "Reboot the system";
                command = [
                  "systemctl"
                  "reboot"
                ];
                enabled = true;
                dangerous = true;
              }
              {
                name = "Logout";
                icon = "exit_to_app";
                description = "Log out of the current session";
                command = [
                  "loginctl"
                  "terminate-user"
                  ""
                ];
                enabled = true;
                dangerous = true;
              }
              {
                name = "Lock";
                icon = "lock";
                description = "Lock the current session";
                command = [
                  "loginctl"
                  "lock-session"
                ];
                enabled = true;
                dangerous = false;
              }
              {
                name = "Sleep";
                icon = "bedtime";
                description = "Suspend then hibernate";
                command = [
                  "systemctl"
                  "suspend-then-hibernate"
                ];
                enabled = true;
                dangerous = false;
              }
            ];
            dragThreshold = 50;
            vimKeybinds = false;
            enableDangerousActions = false;
            maxShown = 7;
            maxWallpapers = 9;
            specialPrefix = "@";
            useFuzzy = {
              apps = true;
              actions = true;
              schemes = true;
              variants = true;
              wallpapers = true;
            };
            showOnHover = false;
            hiddenApps = [];
          };
          lock = {
            recolourLogo = false;
          };
          notifs = {
            actionOnClick = true;
            clearThreshold = 0.3;
            defaultExpireTimeout = 5000;
            expandThreshold = 20;
            expire = false;
          };
          osd = {
            enabled = true;
            enableBrightness = true;
            enableMicrophone = true;
            hideDelay = 2000;
          };
          paths = {
            mediaGif = "root:/assets/bongocat.gif";
            sessionGif = "root:/assets/kurukuru.gif";
            wallpaperDir = "~/Pictures/Wallpapers";
          };
          services = {
            audioIncrement = 0.1;
            maxVolume = 1.0;
            gpuType = "nvidia";
            playerAliases = [
              {
                from = "com.github.th_ch.youtube_music";
                to = "YT Music";
              }
            ];
            weatherLocation = "";
            useFahrenheit = false;
            useTwelveHourClock = false;
            smartScheme = true;
            visualiserBars = 45;
          };
          session = {
            dragThreshold = 30;
            enabled = true;
            vimKeybinds = true;
            commands = {
              logout = [
                "loginctl"
                "terminate-user"
                ""
              ];
              shutdown = [
                "systemctl"
                "poweroff"
              ];
              hibernate = [
                "systemctl"
                "hibernate"
              ];
              reboot = [
                "systemctl"
                "reboot"
              ];
            };
          };
          sidebar = {
            dragThreshold = 80;
            enabled = true;
          };
          utilities = {
            enabled = true;
            maxToasts = 4;
            toasts = {
              audioInputChanged = true;
              audioOutputChanged = true;
              capsLockChanged = true;
              chargingChanged = true;
              configLoaded = true;
              dndChanged = true;
              gameModeChanged = true;
              kbLayoutChanged = true;
              numLockChanged = true;
              nowPlaying = false;
            };
          };
        };
      };
    };
  };

  wayland.windowManager.hyprland = {
    enable = true;

    package = inputs.hyprland.packages."${pkgs.stdenv.hostPlatform.system}".hyprland;

    plugins = with inputs; [
      split-monitor-workspaces.packages.${pkgs.stdenv.hostPlatform.system}.split-monitor-workspaces
    ];

    settings = {
      exec-once = ["vicinae server"];
      decoration.rounding = 10;

      input.touchpad = {
        natural_scroll = true;
        disable_while_typing = true;
      };

      general = {
        gaps_in = 5;
        gaps_out = 5;
        border_size = 0;
      };

      plugin.split-monitor-workspaces = {
        count = 10;
        keep_focused = 0;
        enable_notifications = 0;
        enable_persistent_workspaces = 0;
      };

      bind = [
        "ALT, Q, exec, kitty"
        "ALT, F, exec, zen-twilight"
        "ALT, SPACE, exec, vicinae toggle"
        "ALT SHIFT, S, exec, hyprshot -m region"
        "ALT SHIFT, SPACE, global, caelestia:launcher"

        "ALT, C, killactive"
        "ALT, H, movefocus, l"
        "ALT, J, movefocus, d"
        "ALT, K, movefocus, u"
        "ALT, L, movefocus, r"
        "ALT SHIFT, L, split-changemonitor, next"
        "ALT SHIFT, H, split-changemonitor, prev"

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
      ];

      bindel = [
        ",XF86AudioRaiseVolume, exec, wpctl set-volume @DEFAULT_AUDIO_SINK@ 5%+"
        ",XF86AudioLowerVolume, exec, wpctl set-volume @DEFAULT_AUDIO_SINK@ 5%-"
        ",XF86AudioMute, exec, wpctl set-mute @DEFAULT_AUDIO_SINK@ toggle"
        ",XF86AudioMicMute, exec, wpctl set-mute @DEFAULT_AUDIO_SOURCE@ toggle"
        ",XF86MonBrightnessUp, exec, brightnessctl s 10%+"
        ",XF86MonBrightnessDown, exec, brightnessctl s 10%"
      ];

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
    };
  };
}
