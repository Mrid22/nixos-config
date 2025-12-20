{
  pkgs,
  inputs,
  ...
}: {
  imports = [
    inputs.tor-browser-flake.homeModules.default
  ];
  programs.tor-browser = {
    enable = true;
    profiles.mridula = {
      extensions.packages = with inputs.firefox-addons.packages.${pkgs.stdenv.hostPlatform.system}; [
        ublock-origin
        dearrow
        noscript
        proton-pass
        decentraleyes
        censor-tracker
        snowflake
        privacy-badger
        duckduckgo-privacy-essentials
        sponsorblock
        firenvim
        darkreader
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
