{
  pkgs,
  inputs,
  lib,
  ...
}: {
  imports = with inputs; [
    zen-browser.homeModules.twilight
    vicinae.homeManagerModules.default
  ];

  services = {
    swayosd = {
      enable = true;
      package = inputs.self.packages.${pkgs.stdenv.hostPlatform.system}.swayosd;
    };

    vicinae = {
      enable = true; # default: false
      systemd = {
        enable = true; # default: false
        autoStart = true; # default: false
        environment = {
          USE_LAYER_SHELL = 1;
        };
      };
      settings.keybinds.toggle-action-panel = "control+K";
      extensions = with inputs.vicinae-extensions.packages.${pkgs.stdenv.hostPlatform.system}; [
        bluetooth
        nix
        power-profile
        wifi-commander
      ];
    };
  };

  home = {
    username = "mridula";
    homeDirectory = "/home/mridula";
    stateVersion = "25.11";
  };

  stylix = {
    targets.zen-browser = {
      profileNames = ["mridula"];
      enableCss = false;
    };
  };

  wayland.windowManager.hyprland = {
    enable = true;
    settings = {
      general = {
        gaps_in = 5;
        gaps_out = 5;
        border_size = 0;
      };
      decoration.rounding = 5;
      input.touchpad.natural_scroll = true;
      bind = [
        "ALT, Q, exec, kitty"
        "ALT, F, exec, zen-twilight"
        "ALT, SPACE, exec, vicinae toggle"

        "ALT, C, killactive"
        "ALT, H, movefocus, l"
        "ALT, J, movefocus, d"
        "ALT, K, movefocus, u"
        "ALT, L, movefocus, r"
        "ALT, T, togglefloating"

        "ALT, 1, workspace, 1"
        "ALT, 2, workspace, 2"
        "ALT, 3, workspace, 3"
        "ALT, 4, workspace, 4"
        "ALT, 5, workspace, 5"

        "ALT SHIFT, 1, movetoworkspace, 1"
        "ALT SHIFT, 2, movetoworkspace, 2"
        "ALT SHIFT, 3, movetoworkspace, 3"
        "ALT SHIFT, 4, movetoworkspace, 4"
        "ALT SHIFT, 5, movetoworkspace, 5"
      ];

      bindel = [
        ",XF86AudioRaiseVolume, exec, swayosd-client --output-volume raise"
        ",XF86AudioLowerVolume, exec, swayosd-client --output-volume lower"
        ",XF86AudioMute, exec, swayosd-client --output-volume mute-toggle"
        ",XF86AudioMicMute, exec,swayosd-client --input-volume mute-toggle"
        ",XF86MonBrightnessUp, exec, swayosd-client --brightness +10"
        ",XF86MonBrightnessDown, exec, swayosd-client --brightness -10"
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
    waybar = {
      enable = true;
      systemd.enable = true;
      settings = {
        main = {
          height = 30;
          spacing = 4;
          modules-left = [
            "hyprland/workspaces"
          ];
          modules-center = [
            "hyprland/window"
          ];
          modules-right = [
            "pulseaudio"
            "network"
            "battery"
            "clock"
          ];
          "hyprland/workspaces" = {
            disable-scroll = true;
            all-outputs = true;
            warp-on-scroll = false;
            format = "{name}";
          };
          clock = {
            tooltip-format = "<big>{:%Y %B}</big>\n<tt><small>{calendar}</small></tt>";
            format-alt = "{:%Y-%m-%d}";
          };
          battery = {
            states = {
              good = 90;
              warning = 30;
              critical = 15;
            };
            format = "{capacity}% {icon}";
            format-full = "{capacity}% {icon}";
            format-charging = "{capacity}% 󰂅 ";
            format-plugged = "{capacity}%  ";
            format-alt = "{time} {icon}";
            format-icons = [
              " "
              " "
              " "
              " "
              " "
            ];
          };
          network = {
            format-wifi = "{essid} ({signalStrength}%)  ";
            format-ethernet = "{ipaddr}/{cidr}  ";
            tooltip-format = "{ifname} via {gwaddr} ";
            format-linked = "{ifname} (No IP) ";
            format-disconnected = "Disconnected ⚠";
            format-alt = "{ifname}: {ipaddr}/{cidr}";
          };
          pulseaudio = {
            format = "{volume}% {icon} {format_source}";
            format-bluetooth = "{volume}% {icon} {format_source}";
            format-bluetooth-muted = " {icon} {format_source}";
            format-muted = " {format_source}";
            format-source = "{volume}% ";
            format-source-muted = " ";
            format-icons = {
              headphone = " ";
              hands-free = "";
              headset = "";
              phone = " ";
              portable = " ";
              car = " ";
              default = [
                ""
                " "
                " "
              ];
            };
            on-click = "pavucontrol";
          };
        };
      };
    };
    zen-browser = {
      enable = true;
      suppressXdgMigrationWarning = true;
      policies = {
        AutofillAddressEnabled = false;
        AutofillCreditCardEnabled = false;
        DisableAppUpdate = true;
        DisableFeedbackCommands = true;
        DisableFirefoxStudies = true;
        DisablePocket = true;
        DisableTelemetry = true;
        DontCheckDefaultBrowser = true;
        NoDefaultBookmarks = true;
        OfferToSaveLogins = false;
        EnableTrackingProtection = {
          Value = true;
          Locked = true;
          Cryptomining = true;
          Fingerprinting = true;
        };
      };
      profiles.mridula = {
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
              definedAliases = ["@nx"]; # Keep in mind that aliases defined here only work if they start with "@"
            };
          };
        };
        keyboardShortcutsVersion = 16;
        keyboardShortcuts = [
          {
            id = "key_selectTab1";
            key = "1";
            modifiers = {
              control = true;
            };
          }
          {
            id = "key_selectTab2";
            key = "2";
            modifiers = {
              control = true;
            };
          }
          {
            id = "key_selectTab3";
            key = "3";
            modifiers = {
              control = true;
            };
          }
          {
            id = "key_selectTab4";
            key = "4";
            modifiers = {
              control = true;
            };
          }
          {
            id = "key_selectTab4";
            key = "4";
            modifiers = {
              control = true;
            };
          }
          {
            id = "key_selectTab5";
            key = "5";
            modifiers = {
              control = true;
            };
          }
          {
            id = "key_selectTab6";
            key = "6";
            modifiers = {
              control = true;
            };
          }
          {
            id = "key_selectTab7";
            key = "7";
            modifiers = {
              control = true;
            };
          }
          {
            id = "key_selectTab8";
            key = "8";
            modifiers = {
              control = true;
            };
          }
          {
            id = "key_selectTab9";
            key = "9";
            modifiers = {
              control = true;
            };
          }
          {
            id = "key_selectTab10";
            key = "0";
            modifiers = {
              control = true;
            };
          }
        ];
        mods = [
          "642854b5-88b4-4c40-b256-e035532109df" # Transparent Zen
          "a5f6a231-e3c8-4ce8-8a8e-3e93efd6adec" # Cleaned URL bar
          "a6335949-4465-4b71-926c-4a52d34bc9c0" # Better Find bar
        ];
        extensions.packages = with inputs.firefox-addons.packages.${pkgs.stdenv.hostPlatform.system}; [
          ublock-origin
          dearrow
          proton-pass
          zen-internet
          sponsorblock
          noscript
          decentraleyes
          privacy-badger
          duckduckgo-privacy-essentials
          consent-o-matic
          darkreader
          snowflake
        ];
      };
    };
    eza = {
      enable = true;
      enableZshIntegration = true;
      git = true;
      icons = "always";
    };
  };
}
