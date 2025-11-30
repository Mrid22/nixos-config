{
  pkgs,
  lib,
  ...
}: {
  vim = {
    viAlias = true;
    vimAlias = true;
    lineNumberMode = "none";
    options = {
      tabstop = 2;
      shiftwidth = 2;
    };
    theme = {
      enable = true;
      name = "tokyonight";
      style = "storm";
      transparent = true;
    };
    statusline.lualine.enable = true;
    filetree.nvimTree = {
      enable = true;
      mappings.toggle = "<leader>e";
    };
    telescope.enable = true;
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
}
