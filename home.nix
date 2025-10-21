{
  config,
  pkgs,
  inputs,
  ...
}:

{
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
  programs = {
    nvf = {
      enable = true;
      settings.vim = {
        viAlias = true;
        vimAlias = true;
        lineNumberMode = "none";
        telescope.enable = true;
        languages.nix.enable = true;
        statusline.lualine.enable = true;
        theme = {
          enable = true;
          transparent = true;
          name = "tokyonight";
          style = "storm";
        };
        autocomplete.nvim-cmp.enable = true;
        lsp = {
          enable = true;
          formatOnSave = true;
        };
      };
    };
    home-manager.enable = true;
  };
}
