{
  config,
  pkgs,
  inputs,
  ...
}: {
  imports = [
    inputs.zen-browser.homeModules.twilight
    inputs.nvf.homeManagerModules.default
    ./terminal.nix
  ];

  home = {
    username = "mridula";
    homeDirectory = "/home/mridula";
    stateVersion = "25.05";
    packages = with pkgs; [
      spotdl
    ];

    # Home Manager is pretty good at managing dotfiles. The primary way to manage
    # plain files is through 'home.file'.
    file = {
      # # Building this configuration will create a copy of 'dotfiles/screenrc' in
      # # the Nix store. Activating the configuration will then make '~/.screenrc' a
      # # symlink to the Nix store copy.
      # ".screenrc".source = dotfiles/screenrc;

      # # You can also set the file content immediately.
      # ".gradle/gradle.properties".text = ''
      #   org.gradle.console=verbose
      #   org.gradle.daemon.idletimeout=3600000
      # '';
    };
  };

  programs = {
    nvf = {
      enable = true;
      settings = {
        vim = {
          viAlias = true;
          vimAlias = true;
          lineNumberMode = "none";
          withPython3 = true;
          withNodeJs = true;
          options = {
            shiftwidth = 2;
            tabstop = 2;
          };
          theme = {
            enable = true;
            name = "tokyonight";
            style = "storm";
            transparent = true;
          };
          statusline.lualine.enable = true;
          telescope.enable = true;
          autocomplete.nvim-cmp.enable = true;
          assistant = {
            codecompanion-nvim.enable = true;
            copilot = {
              enable = true;
              cmp.enable = true;
            };
          };
          languages = {
            enableFormat = true;
            enableTreesitter = true;
            enableExtraDiagnostics = true;
            enableDAP = true;

            # Languages
            nix.enable = true;
            python.enable = true;
            html.enable = true;
            css.enable = true;
            ts.enable = true;
            markdown = {
              enable = true;
              extensions.markview-nvim.enable = true;
            };
          };
          lsp = {
            enable = true;
            formatOnSave = true;
            inlayHints.enable = true;
            lightbulb.enable = true;
            lspSignature.enable = true;
            lspkind.enable = true;
            lspsaga.enable = true;
            mappings = {
              codeAction = "<leader>ca";
            };
          };
        };
      };
    };

    zen-browser = {
      enable = true;
      policies = {};
    };

    home-manager.enable = true;
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

      "$mod" = "ALT";

      bind = [
        "$mod, Q, exec, kitty"
        "$mod, F, exec, zen"
        "$mod, E, exec, dolphin"
        "$mod, SPACE, exec, gauntlet open"
        "$mod, C, killactive"

        # Workspaces
        "$mod, 1, workspace, 1"
      ];
    };
  };
}
