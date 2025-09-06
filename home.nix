{
  config,
  pkgs,
  inputs,
  ...
}: {
  imports = [
    ./de.nix
    ./terminal.nix
    inputs.zen-browser.homeModules.twilight
    # inputs.gauntlet.homeManagerModules.default
    inputs.nvf.homeManagerModules.default
  ];
  home = {
    # programs.gauntlet = {
    #   enable = true;
    #   service.enable = true;
    #   config = {};
    # };
    username = "mridula";
    homeDirectory = "/home/mridula";

    stateVersion = "25.05";

    packages = [
    ];

    sessionVariables = {
    };
  };
  programs = {
    zen-browser.enable = true;

    # Let Home Manager install and manage itself.
    home-manager.enable = true;

    nvf = {
      enable = true;
      settings = {
        vim = {
          viAlias = true;
          vimAlias = true;
          withNodeJs = true;
          telescope.enable = true;
          statusline.lualine.enable = true;
          autocomplete.nvim-cmp.enable = true;
          lineNumberMode = "none";
          options = {
            tabstop = 2;
            shiftwidth = 2;
          };
          treesitter = {
            addDefaultGrammars = true;
            autotagHtml = true;
            context.enable = true;
          };
          theme = {
            enable = true;
            name = "tokyonight";
            style = "storm";
            transparent = true;
          };
          languages = {
            enableDAP = true;
            enableExtraDiagnostics = true;
            enableFormat = true;
            enableTreesitter = true;
            # Languages
            html.enable = true;
            nix.enable = true;
            css.enable = true;
            ts.enable = true;
            tailwind.enable = true;
          };
          lsp = {
            enable = true;
            formatOnSave = true;
            lspkind.enable = true;
          };
        };
      };
    };
  };
}
