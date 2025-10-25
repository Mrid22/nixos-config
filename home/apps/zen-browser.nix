{
  config,
  pkgs,
  inputs,
  ...
}: {
  imports = [
    inputs.zen-browser.homeModules.twilight
  ];
  stylix.targets.zen-browser = {
    enable = false;
    profileNames = ["mridula"];
  };
  programs.zen-browser = {
    enable = true;
    profiles.mridula = {
      settings."extensions.autoDisableScopes" = 0;
      extensions = {
        force = true;
        packages = with inputs.firefox-addons.packages.${pkgs.system}; [
          ublock-origin
          privacy-badger
          proton-pass
          #ctrl-number-to-switch-tabs
          dearrow
          decentraleyes
          sponsorblock
          duckduckgo-privacy-essentials
          transparent-zen
          improved-tube
        ];
      };
      bookmarks = {
        force = true;
        settings = [
          {
            name = "Dropout";
            url = "watch.dropout.tv";
          }
        ];
      };
      search = {
        default = "ddg";
        engines = {
          MyNixOS = {
            name = "MyNixOS";
            definedAliases = ["!nx"];
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

            icon = "${pkgs.nixos-icons}/share/icons/hicolor/scalable/apps/nix-snowflake.svg";
          };
        };
      };
    };
  };
}
