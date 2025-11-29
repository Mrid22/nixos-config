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
    profiles.mridula = {
      extensions.packages = with inputs.firefox-addons.packages.${pkgs.stdenv.hostPlatform.system}; [
        ublock-origin
        dearrow
        proton-pass
        decentraleyes
        censor-tracker
        snowflake
        privacy-badger
        duckduckgo-privacy-essentials
        transparent-zen
        sponsorblock
        firenvim
        ctrl-number-to-switch-tabs
      ];
      search = {
        default = "ddg";
        engines = {
          mynixos = {
            name = "My NixOS";
            urls = [
              {
                template = "https://mynixos.com/search?q={searchTerms}";
                params = [
                  {
                    name = "query";
                    value = "{searchTerms}";
                  }
                ];
              }
            ];

            icon = "${pkgs.nixos-icons}/share/icons/hicolor/scalable/apps/nix-snowflake.svg";
            definedAliases = ["@nx"];
          };
        };
      };
    };
  };
}
