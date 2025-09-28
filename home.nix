{
  config,
  pkgs,
  inputs,
  self,
  ...
}: {
  imports = [
    ./home/terminal.nix
    ./home/de.nix
    ./home/zen.nix
    inputs.nvf.homeManagerModules.default
    inputs.ags.homeManagerModules.default
  ];
  home = {
    username = "mridula";
    homeDirectory = "/home/mridula";

    packages = with pkgs; [
      zip
      xz
      unzip
      p7zip

      ripgrep
      jq
      yq-go
      eza
      fzf

      which
      tree
      gnused
      gnutar
      gawk
      zstd
      gnupg
    ];

    stateVersion = "25.05";
  };
  services.kdeconnect.enable = true;

  programs = {
    ags = {
      enable = true;
      extraPackages = with pkgs; [
        inputs.astal.packages.${system}.battery
      ];
      configDir = self + /home/ags;
    };
    nvf = {
      enable = true;
      settings.vim = {
        lineNumberMode = "none";
        telescope.enable = true;
        autocomplete.nvim-cmp.enable = true;
        autopairs.nvim-autopairs.enable = true;
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
        statusline.lualine.enable = true;
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
          html.enable = true;
          markdown = {
            enable = true;
            extensions.markview-nvim.enable = true;
          };
        };
        extraPlugins = {
          yuck = {
            package = pkgs.vimPlugins.yuck-vim;
          };
          treesitter-yuck = {
            package = pkgs.vimPlugins.nvim-treesitter-parsers.yuck;
          };
        };
      };
    };
  };
}
