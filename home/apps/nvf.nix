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
    treesitter = {
      enable = true;
      autoTagHtml = true;
      context.enable = true;
    };
    filetree.nvimTree = {
      enable = true;
      mappings.toggle = "<leader>e";
    };
    terminal.toggleterm = {
      enable = true;
      lazygit.enable = true;
      mappings.open = "<leader>t";
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
      nix.enable = true;
      html.enable = true;
      css.enable = true;
      tailwind.enable = true;
      ts = {
        enable = true;
        extensions.ts-error-translator.enable = true;
      };
    };
    theme = {
      enable = true;
      name = "tokyonight";
      style = "storm";
      transparent = true;
    };
  };
}
