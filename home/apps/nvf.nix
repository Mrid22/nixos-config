{
  config,
  pkgs,
  inputs,
  ...
}: {
  imports = [inputs.nvf.homeManagerModules.default];
  programs.nvf = {
    enable = true;
    settings = {
      vim = {
        viAlias = true;
        vimAlias = true;
        lineNumberMode = "none";
        options = {
          tabstop = 2;
          shiftwidth = 2;
        };
        statusline.lualine.enable = true;
        filetree.nvim-tree.enable = true;
        dashboard.alpha.enable = true;
        lsp = {
          enable = true;
          formatOnSave = true;
        };
        languages = {
          enableFormat = true;
          enableTreesitter = true;
          nix.enable = true;
        };
        autopairs.nvim-autopairs.enable = true;
        autocomplete.blink-cmp = {
          enable = true;
          friendly-snippets.enable = true;
        };
      };
    };
  };
}
