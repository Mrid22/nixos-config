{inputs, ...}: {
  perSystem = {pkgs, ...}: {
    packages.default =
      (inputs.nvf.lib.neovimConfiguration {
        inherit pkgs;
        modules = [
          {
            vim = {
              git.enable = true;
              treesitter = {
                enable = true;
                fold = true;
              };
              options = {
                tabstop = 2;
                shiftwidth = 2;
              };
              autocomplete.nvim-cmp.enable = true;
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
              };
            };
          }
        ];
      }).neovim;
  };
}
