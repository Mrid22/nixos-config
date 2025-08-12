{
  config,
  pkgs,
  inputs,
  ...
}: {
  imports = [
    inputs.zen-browser.homeModules.twilight
    inputs.gauntlet.homeManagerModules.default
    inputs.nvf.homeManagerModules.default
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
          telescope.enable = true;
          dashboard.alpha.enable = true;
          statusline.lualine.enable = true;
          autocomplete.nvim-cmp.enable = true;
          autopairs.nvim-autopairs.enable = true;
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
          terminal = {
            toggleterm = {
              enable = true;
              lazygit.enable = true;
            };
          };
          assistant = {
            codecompanion-nvim.enable = true;
            avante-nvim = {
              enable = true;
              setupOpts = {
                providers = {
                  ollama = {
                    endpoint = "http://nixos:11434";
                    timeout = 30000;
                    extra_request_body = {
                      options = {
                        temperature = 0.75;
                        num_ctx = 20480;
                        keep_alive = "5m";
                      };
                    };
                  };
                };
                auto_suggestions_provider = "ollama";
              };
            };
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
    gauntlet = {
      enable = true;
      service.enable = true;
      config = {};
    };

    zen-browser = {
      enable = true;
      policies = {};
    };

    home-manager.enable = true;
  };
}
