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
        theme.name = "tokyo-night-storm";
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
          privacy-badger
          duckduckgo-privacy-essentials
          transparent-zen
          firenvim
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

    waybar = {
      enable = true;
      systemd.enable = true;
      settings = {
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
          format = "<span foreground=>   </span>{:%a %d %H:%M}";
          tooltip-format = "<big>{:%Y %B}</big>
<tt><small>{calendar}</small></tt>";
        };
        battery = {
          states = {
            warning = 30;
            critical = 15;
          };
          format = "<span size='13000' foreground=>{icon} </span> {capacity}%";
          format-warning = "<span size='13000' foreground=>{icon} </span> {capacity}%";
          format-critical = "<span size='13000' foreground=>{icon} </span> {capacity}%";
          format-charging = "<span size='13000' foreground=> </span>{capacity}%";
          format-plugged = "<span size='13000' foreground=> </span>{capacity}%";
          format-alt = "<span size='13000' foreground=>{icon} </span> {time}";
          format-full = "<span size='13000' foreground=> </span>{capacity}%";
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
          format-wifi = "<span size='13000' foreground=>  </span>{essid}";
          format-ethernet = "<span size='13000' foreground=>󰤭  </span> Disconnected";
          format-linked = "{ifname} (No IP) ";
          format-disconnected = "<span size='13000' foreground=>  </span>Disconnected";
          tooltip-format-wifi = "Signal Strenght: {signalStrength}%";
        };
        pulseaudio = {
          format = "{icon}  {volume}%";
          format-muted = "";
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

    atuin = {
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

    nh = {
      enable = true;
      clean.enable = true;
      flake = "/home/mridula/nixos-config";
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

      bindel = [
        ",XF86AudioRaiseVolume, exec, wpctl set-volume @DEFAULT_AUDIO_SINK@ 5%+"
        ",XF86AudioLowerVolume, exec, wpctl set-volume @DEFAULT_AUDIO_SINK@ 5%-"
        ",XF86AudioMute, exec, wpctl set-mute @DEFAULT_AUDIO_SINK@ toggle"
        ",XF86AudioMicMute, exec, wpctl set-mute @DEFAULT_AUDIO_SOURCE@ toggle"
        ",XF86MonBrightnessUp, exec, brightnessctl s 10%+"
        ",XF86MonBrightnessDown, exec, brightnessctl s 10%"
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
