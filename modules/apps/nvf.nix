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
              comments.comment-nvim.enable = true;
              terminal.toggleterm.enable = true;
              git.gitsigns.enable = true;
              globals.mapleader = " ";
              fzf-lua.enable = true;
              ui.colorizer.enable = true;
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
                  key = "<leader>t";
                  mode = "n";
                  action = ":ToggleTerm";
                }
                {
                  key = "<leader>ff";
                  mode = "n";
                  action = ":FzfLua files<CR>";
                }
                {
                  key = "<leader>fg";
                  mode = "n";
                  action = ":FzfLua live_grep_native<CR>";
                }
                {
                  key = "<leader>la";
                  mode = "n";
                  action = ":FzfLua lsp_code_actions<CR>";
                }
              ];
              utility.oil-nvim = {
                enable = true;
                gitStatus.enable = true;
              };
              lsp = {
                enable = true;
                formatOnSave = true;
                mappings.codeAction = "<leader>ca";
                lspsaga.enable = true;
                presets.tailwindcss-langauge-server.enable = true;
                inlayHints.enable = true;
              };
              treesitter = {
                enable = true;
                indent.enable = false;
                autotagHtml = true;
              };
              languages = {
                enableFormat = true;
                enableDAP = true;
                nix.enable = true;
                json.enable = true;
                html.enable = true;
                bash.enable = true;
                python.enable = true;
                typescript.enable = true;
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
