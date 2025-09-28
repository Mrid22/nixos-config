{
  config,
  pkgs,
  inputs,
  ...
}: {
  imports = [
    inputs.zen-browser.homeModules.twilight
  ];
  programs.zen-browser = {
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
    };
  };
}
