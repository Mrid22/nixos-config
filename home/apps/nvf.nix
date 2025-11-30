{...}: {
  vim = {
    viAlias = true;
    vimAlias = true;
    lineNumberMode = "none";
    telescope.enable = true;
    dashboard.alpha.enable = true;
    statusline.lualine.enable = true;
    autopairs.nvim-autopairs.enable = true;
    options = {
      tabstop = 2;
      shiftwidth = 2;
    };
    filetree.nvimTree = {
      enable = true;
      mappings.toggle = "<leader>e";
    };
    autocomplete.blink-cmp = {
      enable = true;
      friendly-snippets.enable = true;
    };
    lsp = {
      enable = true;
      formatOnSave = true;
    };
    languages = {
      enableFormat = true;
      enableTreesitter = true;
      nix.enable = true;
    };
    theme = {
      enable = true;
      name = "tokyonight";
      style = "storm";
      transparent = true;
    };
  };
}
