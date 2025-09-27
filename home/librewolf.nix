{
  config,
  pkgs,
  ...
}: {
  programs.librewolf = {
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
      extensions = {
        packages = with pkgs.firefoxAddons; [
          ublock-origin
          proton-pass
          shortkeys
          dearrow
        ];
      };
    };
  };
}
