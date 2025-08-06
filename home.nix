{
  config,
  pkgs,
  inputs,
  ...
}: {
  imports = [
    inputs.zen-browser.homeModules.twilight
    inputs.nvf.homeManagerModules.default
    inputs.gauntlet.homeManagerModules.default
    inputs.catppuccin.homeModules.catppuccin
    ./terminal.nix
    ./de.nix
  ];

  home = {
    username = "mridula";
    homeDirectory = "/home/mridula";
    stateVersion = "25.05";
    packages = with pkgs; [
      spotdl
    ];
  };

  catppuccin = {
    enable = true;
    accent = "lavender";
    flavor = "macchiato";
  };

  programs = {
    gauntlet = {
      enable = true;
      service.enable = true;
      config = {};
    };
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
          telescope.enable = true;
          dashboard.alpha.enable = true;
          statusline.lualine.enable = true;
          autocomplete.nvim-cmp.enable = true;
          autopairs.nvim-autopairs.enable = true;
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
}
