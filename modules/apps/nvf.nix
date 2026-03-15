{inputs, ...}: {
  perSystem = {pkgs, ...}: {
    packages.default =
      (inputs.nvf.lib.neovimConfiguration {
        inherit pkgs;
        modules = [
          {
            vim = {
              lineNumberMode = "none";
              options = {
                signcolumn = "yes";
                tabstop = 2;
                shiftwidth = 2;
              };
              git.gitsigns.enable = true;
              globals.mapleader = " ";
              fzf-lua.enable = true;
              visuals.nvim-web-devicons.enable = true;
              theme = {
                enable = true;
                name = "tokyonight";
                style = "moon";
                transparent = true;
              };
              keymaps = [
                {
                  key = "<leader>e";
                  mode = "n";
                  action = ":Oil<CR>";
                }
                {
                  key = "<leader>ff";
                  mode = "n";
                  action = ":FzfLua files<CR>";
                }
                {
                  key = "<leader>la";
                  mode = "n";
                  action = ":FzfLua lsp_code_actions<CR>";
                }
              ];
              assistant.codecompanion-nvim = {
                enable = true;

                setupOpts.providers.ollama = {
                  endpoint = "http://127.0.0.1:11434";
                  model = "qwen3:latest";
                  timeout = 30000; # Timeout in milliseconds
                  extra_request_body = {
                    options = {
                      temperature = 0.75;
                      num_ctx = 20480;
                      keep_alive = "5m";
                    };
                  };
                };
              };
              utility.oil-nvim = {
                enable = true;
                gitStatus.enable = true;
              };
              lsp = {
                enable = true;
                formatOnSave = true;
                lspsaga.enable = true;
                inlayHints.enable = true;
              };
              treesitter = {
                enable = true;
                indent.enable = false;
              };
              languages = {
                enableFormat = true;
                enableDAP = true;
                nix.enable = true;
                bash.enable = true;
                rust.enable = true;
                markdown = {
                  enable = true;
                  extensions.markview-nvim.enable = true;
                };
              };
              statusline.lualine.enable = true;
              autopairs.nvim-autopairs.enable = true;
              autocomplete.blink-cmp = {
                enable = true;
                friendly-snippets.enable = true;
              };
            };
          }
        ];
      }).neovim;
  };
}
