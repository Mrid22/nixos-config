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
    inputs.gauntlet-patch.homeManagerModules.default
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
        inputs.astal.packages.${system}.hyprland
        inputs.astal.packages.${system}.powerprofiles
        inputs.astal.packages.${system}.network
        inputs.astal.packages.${system}.wireplumber
        inputs.astal.packages.${system}.tray
        inputs.astal.packages.${system}.mpris
        inputs.astal.packages.${system}.apps
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
        extraPackages = [
          pkgs.vimPlugins.yuck-vim
          pkgs.vimPlugins.nvim-treesitter-parsers.yuck
        ];
      };
    };
  };
}
