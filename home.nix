{
  config,
  pkgs,
  inputs,
  ...
}: {
  imports = [
    ./terminal.nix
    inputs.nvf.homeManagerModules.default
    inputs.zen-browser.homeModules.twilight
    inputs.vicinae.homeManagerModules.default
  ];
  home = {
    username = "mridula";
    homeDirectory = "/home/mridula";

    packages = with pkgs; [
      zip
      xz
      unzip
      p7zip

      ripgrep
      jq
      yq-go
      eza
      fzf

      which
      tree
      gnused
      gnutar
      gawk
      zstd
      gnupg
      nwg-look
    ];

    stateVersion = "25.05";
  };

  xresources.properties = {
    "Xcursor.size" = 16;
    "Xft.dpi" = 172;
  };

  services.vicinae = {
    enable = true;
    autoStart = true;
    settings = {
      popToRootonClose = true;
      rootSearch.searchFiles = true;
    };
  };

  wayland.windowManager.hyprland = {
    enable = true;
    systemd.enable = true;
    xwayland.enable = true;
    settings = {
      general = {
        gaps_in = 5;
        gaps_out = 5;
        border_size = 0;
        resize_on_border = true;
      };
      decoration = {
        rounding = 10;
        blur = {
          size = 3;
          passes = 1;
          vibrancy = 0.1696;
        };
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
      bind = [
        #Apps
        "ALT,Q,exec,kitty"
        "ALT,F,exec,zen"

        # Windows
        "ALT,H,movefocus,l"
        "ALT,J,movefocus,d"
        "ALT,K,movefocus,u"
        "ALT,L,movefocus,r"

        "ALT,C, killactive"

        # Workspaces
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
      input = {
        follow_mouse = 1;
        touchpad.natural_scroll = true;
      };
    };
  };

  gtk = {
    enable = true;
    colorScheme = "dark";
    theme = {
      name = "Layan-Dark";
      package = pkgs.layan-gtk-theme;
    };
  };

  programs = {
    zen-browser.enable = true;
    eww = {
      enable = true;
      enableZshIntegration = true;
    };
    nvf = {
      enable = true;
      settings.vim = {
        lineNumberMode = "none";
        options = {
          tabstop = 2;
          softtabstop = 2;
          shiftwidth = 2;
        };
        theme = {
          enable = true;
          transparent = true;
          name = "tokyonight";
          style = "night";
        };
        statusline.lualine.enable = true;
        lsp = {
          enable = true;
          formatOnSave = true;
        };
        languages = {
          enableDAP = true;
          enableFormat = true;
          enableTreesitter = true;
          # Languages
          nix.enable = true;
        };
      };
    };
  };
}
