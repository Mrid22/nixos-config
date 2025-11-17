{
  config,
  pkgs,
  inputs,
  ...
}: {
  imports = [inputs.zen-browser.homeModules.twilight];
  programs.zen-browser = {
    enable = true;
    profiles.mridula = {
      search = {
        default = "ddg";
        engines = {
          mynixos = {
            name = "NixOS";
            urls = [{template = "https://mynixos.com/search?q={searchTerms}";}];
            iconMapObj."16" = "https://wiki.nixos.org/favicon.ico";
            definedAliases = ["@nx"];
          };
        };
      };
      extensions.packages = with inputs.firefox-addons.packages.${pkgs.stdenv.hostPlatform.system}; [
        ublock-origin
        dearrow
        proton-pass
        decentraleyes
        privacy-badger
        sponsorblock
        transparent-zen
        snowflake
        dearrow
        noscript
        github-file-icons
      ];
    };
  };
}
