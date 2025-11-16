{ pkgs, lib, ... }:
{
  vim = {
    options = {
      shiftwidth = 2;
      tabstop = 2;
    };
    lsp = {
      enable = true;
      formatOnSave = true;
    };
    autocomplete.nvim-cmp.enable = true;
    autopairs.nvim-autopairs.enable = true;
    languages = {
      enableTreesitter = true;
      nix.enable = true;
    };
    statusline.lualine.enable = true;
    theme = {
      enable = true;
      name = "tokyonight";
      style = "storm";
      transparent = true;
    };
  };
}
