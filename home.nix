{
  config,
  pkgs,
  inputs,
  self,
  ...
}: {
  imports = [
    ./terminal.nix
    ./de.nix
    inputs.nvf.homeManagerModules.default
    inputs.zen-browser.homeModules.twilight
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
    zen-browser = {
      enable = true;
      policies = let
        mkExtensionSettings = builtins.mapAttrs (_: pluginId: {
          install_url = "https://addons.mozilla.org/firefox/downloads/latest/${pluginId}/latest.xpi";
          installation_mode = "force_installed";
        });
      in {
        ExtensionSettings = mkExtensionSettings {
          "wappalyzer@crunchlabz.com" = "wappalyzer";
          "{85860b32-02a8-431a-b2b1-40fbd64c9c69}" = "github-file-icons";
        };
      };
    };
    librewolf = {
      enable = true;
      settings."extensions.autoDisableScopes" = 0;
      profiles.mridula = {
        bookmarks = {
          force = true;
          settings = [
            {
              name = "Colleges";
              toolbar = true;
              bookmarks = [
                {
                  name = "Computational Social Science Bsc @ UvA";
                  url = "https://www.uva.nl/en/programmes/bachelors/computational-social-science";
                }
                {
                  name = "Computing Science Bsc @ Radboud University";
                  url = "https://www.ru.nl/en/education/bachelors/computing-science";
                }
              ];
            }
          ];
        };
        search = {
          default = "ddg";
          engines = {
            nix-options = {
              name = "NixOS";
              urls = [
                {
                  template = "https://mynixos.com/search";
                  params = [
                    {
                      name = "q";
                      value = "{searchTerms}";
                    }
                  ];
                }
              ];

              definedAliases = ["@nx"];
            };

            bing.metaData.hidden = true;
            google.metaData.alias = "@g";
          };
        };
        extenstions = {
          packages = with pkgs.firefoxAddons; [
            ublock-origin
            proton-pass
          ];
        };
      };
    };
    ags = {
      enable = true;
      extraPackages = with pkgs; [
        inputs.astal.packages.${system}.battery
      ];
      configDir = self + /ags;
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
