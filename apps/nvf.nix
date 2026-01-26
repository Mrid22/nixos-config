{inputs, ...}: {
  perSystem = {pkgs, ...}: {
    packages.default =
      (inputs.nvf.lib.neovimConfiguration {
        inherit pkgs;
        modules = [
          {
            vim = {
              lineNumberMode = "none";
              git.enable = true;
              telescope.enable = true;
              statusline.lualine.enable = true;
              filetree.nvimTree = {
                enable = true;
                mappings.toggle = "<space>e";
              };
              terminal.toggleterm = {
                enable = true;
                mappings.open = "<space>t";
              };
              autocomplete.nvim-cmp.enable = true;
              autopairs.nvim-autopairs.enable = true;
              treesitter = {
                enable = true;
                fold = true;
              };
              options = {
                tabstop = 2;
                shiftwidth = 2;
              };
              theme = {
                enable = true;
                name = "catppuccin";
                style = "mocha";
                transparent = true;
              };
              lsp = {
                enable = true;
                inlayHints.enable = true;
                lightbulb.enable = true;
                lspSignature.enable = true;
                lspkind.enable = true;
                lspsaga.enable = true;
                formatOnSave = true;
              };
              languages = {
                enableDAP = true;
                enableExtraDiagnostics = true;
                enableFormat = true;
                enableTreesitter = true;
                nix.enable = true;
                python.enable = true;
                ts = {
                  enable = true;
                  extensions.ts-error-translator.enable = true;
                };
              };
            };
          }
        ];
      }).neovim;
  };
}
