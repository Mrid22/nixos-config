{inputs, ...}: {
  perSystem = {pkgs, ...}: {
    packages.default =
      (inputs.nvf.lib.neovimConfiguration {
        inherit pkgs;
        modules = [
          {
            vim = {
              viAlias = true;
              vimAlias = true;
              lineNumberMode = "none";
              options = {
                tabstop = 2;
                softtabstop = 2;
                shiftwidth = 2;
              };
              globals.mapleader = " ";
              keymaps = [
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
                  key = "<leader>fr";
                  mode = "n";
                  action = ":FzfLua buffers<CR>";
                }
                {
                  key = "<leader>ca";
                  mode = "n";
                  action = ":FzfLua lsp_code_actions<CR>";
                }
              ];
              visuals.nvim-web-devicons.enable = true;
              statusline.lualine.enable = true;
              snippets.luasnip.enable = true;
              autopairs.nvim-autopairs.enable = true;
              autocomplete.nvim-cmp.enable = true;
              terminal.toggleterm.enable = true;
              theme = {
                enable = true;
                name = "tokyonight";
                style = "night";
                transparent = true;
              };
              utility.surround = {
                enable = true;
                useVendoredKeybindings = false;
              };
              comments.comment-nvim.enable = true;
              lsp = {
                enable = true;
                formatOnSave = true;
                lspsaga.enable = true;
                inlayHints.enable = true;
              };
              filetree.nvimTree = {
                enable = true;
                mappings.toggle = "<leader>e";
              };
              languages = {
                enableFormat = true;
                enableDAP = true;
                enableExtraDiagnostics = true;
                nix.enable = true;
                python.enable = true;
                ts = {
                  enable = true;
                  extensions.ts-error-translator.enable = true;
                };
              };
              treesitter = {
                enable = true;
                addDefaultGrammars = true;
                autotagHtml = true;
                context.enable = true;
              };
              fzf-lua.enable = true;
            };
          }
        ];
      }).neovim;
  };
}
