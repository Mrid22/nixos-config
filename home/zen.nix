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
        "uBlock0@raymondhill.net" = "ublock-origin";
        "78272b6fa58f4a1abaac99321d503a20@proton.me" = "proton-pass";
        "deArrow@ajay.app" = "dearrow";
        "sponsorBlocker@ajay.app" = "sponsorBlock";
        "jid1-BoFifL9Vbdl2zQ@jetpack" = "decentraleyes";
        "{91aa3897-2634-4a8a-9092-279db23a7689}" = "zen-internet";
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
