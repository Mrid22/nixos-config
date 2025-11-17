{
  pkgs,
  lib,
  ...
}: {
  vim = {
    lineNumberMode = "none";
    autopairs.nvim-autopairs.enable = true;
    comments.comment-nvim.enable = true;
    filetree.neo-tree.enable = true;
    git.enable = true;
    options = {
      shiftwidth = 2;
      tabstop = 2;
    };
    lsp = {
      enable = true;
      formatOnSave = true;
      inlayHints.enable = true;
      lightbulb.enable = true;
      lspkind.enable = true;
      lspsaga.enable = true;
      nvim-docs-view.enable = true;
      otter-nvim.enable = true;
    };
    autocomplete.blink-cmp = {
      enable = true;
      friendly-snippets.enable = true;
      setupOpts.signature.enabled = true;
    };
    languages = {
      enableTreesitter = true;
      enableDAP = true;
      enableFormat = true;
      enableExtraDiagnostics = true;
      nix.enable = true;
      css.enable = true;
      html.enable = true;
      java.enable = true;
      python.enable = true;
      tailwind.enable = true;
      yaml.enable = true;
      ts = {
        enable = true;
        extensions.ts-error-translator.enable = true;
      };
      markdown = {
        enable = true;
        extensions.markview-nvim.enable = true;
        format.type = "prettierd";
      };
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
