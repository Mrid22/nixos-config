{
  pkgs,
  inputs,
  ...
}: {
  imports = with inputs; [
    zen-browser.homeModules.twilight
    vicinae.homeManagerModules.default
  ];

  home = {
    username = "mridula";
    homeDirectory = "/home/mridula";
    stateVersion = "25.11";
  };

  services.vicinae = {
    enable = true;
    autoStart = true;
    settings = {
      close_on_focus_loss = true;
      pop_to_root_on_close = false;
    };
  };

  programs = {
    waybar = {
      enable = true;
      systemd.enable = true;
      settings = {
        mainBar = {
          position = "top";
          modules-left = [
            "hyprland/workspaces"
          ];
          modules-center = [
            "hyprland/window"
          ];
          modules-right = [
            "network"
            "pulseaudio"
            "battery"
            "clock"
          ];
          clock = {
            format = "<span >   </span>{:%a %d %H:%M}";
          };
          battery = {
            states = {
              warning = 30;
              critical = 15;
            };
            format = "<span size='13000' >{icon} </span> {capacity}%";
            format-warning = "<span size='13000' >{icon} </span> {capacity}%";
            format-critical = "<span size='13000' >{icon} </span> {capacity}%";
            format-charging = "<span size='13000' > </span>{capacity}%";
            format-plugged = "<span size='13000' > </span>{capacity}%";
            format-alt = "<span size='13000' >{icon} </span> {time}";
            format-full = "<span size='13000' > </span>{capacity}%";
            format-icons = [
              ""
              ""
              ""
              ""
              ""
            ];
            tooltip-format = "{time}";
          };
          network = {
            format-wifi = "<span size='13000' >  </span>{essid}";
            format-ethernet = "<span size='13000' >󰤭  </span> Disconnected";
            format-linked = "{ifname} (No IP) ";
            format-disconnected = "<span size='13000' >  </span>Disconnected";
            tooltip-format-wifi = "Signal Strenght: {signalStrength}%";
          };
          pulseaudio = {
            format = "{icon}  {volume}%";
            format-muted = " ";
            format-icons = {
              default = [
                ""
                ""
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
      policies = {
        AutofillAddressEnabled = true;
        AutofillCreditCardEnabled = false;
        DisableAppUpdate = true;
        DisableFeedbackCommands = true;
        DisableFirefoxStudies = true;
        DisablePocket = true;
        DisableTelemetry = true;
        DontCheckDefaultBrowser = false;
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
        extensions.packages = with inputs.firefox-addons.packages.${pkgs.stdenv.hostPlatform.system}; [
          ublock-origin
          decentraleyes
          privacy-badger
          duckduckgo-privacy-essentials
          dearrow
          proton-pass
          zen-internet
          noscript
        ];
        keyboardShortcuts = [
          {
            id = "key_quitApplication";
            disabled = true;
          }
          {
            id = "key_selectTab1";
            key = "1";
            modifiers.control = true;
          }
          {
            id = "key_selectTab2";
            key = "2";
            modifiers.control = true;
          }
          {
            id = "key_selectTab3";
            key = "3";
            modifiers.control = true;
          }
          {
            id = "key_selectTab4";
            key = "4";
            modifiers.control = true;
          }
          {
            id = "key_selectTab5";
            key = "5";
            modifiers.control = true;
          }
          {
            id = "key_selectTab6";
            key = "6";
            modifiers.control = true;
          }
          {
            id = "key_selectTab7";
            key = "7";
            modifiers.control = true;
          }
          {
            id = "key_selectTab8";
            key = "8";
            modifiers.control = true;
          }
          {
            id = "key_selectTab9";
            key = "9";
            modifiers.control = true;
          }
          {
            id = "key_selectTab10";
            key = "0";
            modifiers.control = true;
          }
        ];
        # Fails activation on schema changes to detect potential regressions
        # Find this in about:config or prefs.js of your profile
        keyboardShortcutsVersion = 16;
        mods = [
          "642854b5-88b4-4c40-b256-e035532109df"
          "a5f6a231-e3c8-4ce8-8a8e-3e93efd6adec"
        ];
        search = {
          force = true;
          default = "ddg";
          engines = {
            mynixos = {
              name = "My NixOS";
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
              definedAliases = ["@nx"];
            };
          };
        };
      };
    };

    home-manager.enable = true;
  };

  wayland.windowManager.hyprland = {
    enable = true;
    settings = {
      bindel = [
        ",XF86AudioRaiseVolume, exec, wpctl set-volume @DEFAULT_AUDIO_SINK@ 5%+"
        ",XF86AudioLowerVolume, exec, wpctl set-volume @DEFAULT_AUDIO_SINK@ 5%-"
        ",XF86AudioMute, exec, wpctl set-mute @DEFAULT_AUDIO_SINK@ toggle"
        ",XF86AudioMicMute, exec, wpctl set-mute @DEFAULT_AUDIO_SOURCE@ toggle"
        ",XF86MonBrightnessUp, exec, brightnessctl s 10%+"
        ",XF86MonBrightnessDown, exec, brightnessctl s 10%-"
      ];
      bindl = [
        ", XF86AudioNext, exec, playerctl next"
        ", XF86AudioPause, exec, playerctl play-pause"
        ", XF86AudioPlay, exec, playerctl play-pause "
        ", XF86AudioPrev, exec, playerctl previous   "
      ];
      bind = [
        "ALT,Q,exec,kitty"
        "ALT,F,exec,zen-twilight"

        "ALT,H,movefocus,l"
        "ALT,J,movefocus,d"
        "ALT,K,movefocus,u"
        "ALT,L,movefocus,r"
        "ALT,C,killactive"

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
      input.touchpad.natural_scroll = true;
      general = {
        gaps_in = 5;
        gaps_out = 5;
        border_size = 0;
      };
      decoration.rounding = 5;
    };
  };
}
