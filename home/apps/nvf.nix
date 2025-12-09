{...}: {
  vim = {
    viAlias = true;
    vimAlias = true;
    lineNumberMode = "none";
    telescope.enable = true;
    dashboard.alpha.enable = true;
    statusline.lualine.enable = true;
    autopairs.nvim-autopairs.enable = true;
    debugger.nvim-dap.enable = true;
    notify.nvim-notify.enable = true;
    runner.run-nvim.enable = true;
    snippets.luasnip.enable = true;
    options = {
      tabstop = 2;
      shiftwidth = 2;
    };
    git = {
      enable = true;
      neogit.enable = true;
    };
    treesitter = {
      enable = true;
      fold = true;
      autotagHtml = true;
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
      setupOpts.signature.enabled = true;
    };
    lsp = {
      enable = true;
      formatOnSave = true;
      inlayHints.enable = true;
      lightbulb.enable = true;
      lspkind.enable = true;
      lspsaga.enable = true;
      null-ls.enable = true;
      otter-nvim.enable = true;
      trouble.enable = true;
    };
    languages = {
      enableFormat = true;
      enableDAP = true;
      enableTreesitter = true;
      html.enable = true;
      css.enable = true;
      tailwind.enable = true;
      ts = {
        enable = true;
        extensions.ts-error-translator.enable = true;
      };
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
