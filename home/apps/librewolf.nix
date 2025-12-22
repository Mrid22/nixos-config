{
  pkgs,
  inputs,
  ...
}: let
  param = [
    {
      name = "query";
      value = "{searchTerms}";
    }
  ];
in {
  stylix.targets.librewolf = {
    profileNames = ["mridula"];
    #   enableCss = false;
  };

  programs.librewolf = {
    enable = true;
    nativeMessagingHosts = [inputs.caelestia-shell.packages.${pkgs.stdenv.hostPlatform.system}.default];
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
        default = "ddgnoai";
        engines = {
          ddgnai = {
            name = "DuckDuckGo (No AI)";
            urls = [
              {
                template = "https://noai.duckduckgo.com/?q={searchTerm}";
                params = param;
              }
            ];
          };
          mynixos = {
            name = "My NixOS";
            urls = [
              {
                template = "https://mynixos.com/search?q={searchTerms}";
                params = param;
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
