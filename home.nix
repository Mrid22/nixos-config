{
  config,
  pkgs,
  inputs,
  ...
}: {
  imports = [
    ./home/environments/de.nix
    ./home/environments/terminal.nix
    ./home/apps/floorp.nix
  ];
  home = {
    username = "mridula";
    homeDirectory = "/home/mridula";
    stateVersion = "25.05";
  };
  stylix = {
    enable = true;
    image = ./Wallpaper.jpg;
    targets = {
      nvf.transparentBackground = true;
      waybar.addCss = true;
      floorp = {
        colorTheme.enable = true;
        profileNames = ["mridula"];
      };
    };
  };
  programs = {
    nvf = {
      enable = true;
      settings.vim = {
        viAlias = true;
        vimAlias = true;
        lineNumberMode = "none";
        telescope.enable = true;
        statusline.lualine.enable = true;
        autocomplete.nvim-cmp.enable = true;
        autopairs.nvim-autopairs.enable = true;
        dashboard.alpha.enable = true;
        options = {
          shiftwidth = 2;
          tabstop = 2;
        };
        filetee.neo-tree.enable = true;
        treesitter = {
          enable = true;
          autotagHtml = true;
          context.enable = true;
        };
        languages = {
          enableTreesitter = true;
          enableDAP = true;
          enableExtraDiagnostics = true;
          enableFormat = true;
          nix.enable = true;
          html.enable = true;
          css.enable = true;
          tailwind.enable = true;
          ts = {
            enable = true;
            extensions.ts-error-translator.enable = true;
          };
          markdown = {
            enable = true;
            extensions.render-markdown-nvim.enable = true;
          };
        };
        lsp = {
          enable = true;
          formatOnSave = true;
          inlayHints.enable = true;
          lspSignature.enable = true;
          lspkind.enable = true;
          lspsaga.enable = true;
          lightbulb = {
            enable = true;
            autocmd.enable = true;
          };
        };
      };
    };
    home-manager.enable = true;
  };
}
