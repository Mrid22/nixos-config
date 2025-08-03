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
        "$mod, 2, workspace, 2"
        "$mod, 3, workspace, 3"
        "$mod, 4, workspace, 4"
        "$mod, 5, workspace, 5"
        "$mod, 6, workspace, 3"
        "$mod, 7, workspace, 7"
        "$mod, 8, workspace, 8"
        "$mod, 9, workspace, 9"
        "$mod, 0, workspace, 0"

        "$mod, 1, movetoworkspace, 1"
        "$mod, 2, movetoworkspace, 2"
        "$mod, 3, movetoworkspace, 3"
        "$mod, 4, movetoworkspace, 4"
        "$mod, 5, movetoworkspace, 5"
        "$mod, 6, movetoworkspace, 3"
        "$mod, 7, movetoworkspace, 7"
        "$mod, 8, movetoworkspace, 8"
        "$mod, 9, movetoworkspace, 9"
        "$mod, 0, movetoworkspace, 0"
      ];
    };
  };
}
