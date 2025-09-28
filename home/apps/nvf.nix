{
  config,
  pkgs,
  inputs,
  ...
}: {
  imports = [
    inputs.nvf.homeManagerModules.default
  ];
  programs.nvf = {
    enable = true;
    settings.vim = {
      lineNumberMode = "none";
      telescope.enable = true;
      autocomplete.nvim-cmp.enable = true;
      autopairs.nvim-autopairs.enable = true;
      statusline.lualine.enable = true;
      filetree.neo-tree.enable = true;
      options = {
        tabstop = 2;
        softtabstop = 2;
        shiftwidth = 2;
      };
      theme = {
        enable = true;
        transparent = true;
        name = "tokyonight";
        style = "night";
      };
      lsp = {
        enable = true;
        formatOnSave = true;
      };
      languages = {
        enableDAP = true;
        enableFormat = true;
        enableTreesitter = true;
        # Languages
        nix.enable = true;
        ts.enable = true;
        tailwind.enable = true;
        html = {
          enable = true;
          treesitter.autotagHtml = true;
        };
        markdown = {
          enable = true;
          extensions.markview-nvim.enable = true;
        };
      };
    };
  };
}
