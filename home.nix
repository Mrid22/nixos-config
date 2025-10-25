{
  config,
  pkgs,
  inputs,
  ...
}: {
  imports = [
    ./home/environments/de.nix
    ./home/environments/terminal.nix
    ./home/apps/floorp.nix
    ./home/apps/nvf.nix
    inputs.zen-browser.homeModules.twilight
  ];
  home = {
    username = "mridula";
    homeDirectory = "/home/mridula";
    stateVersion = "25.05";
  };
  stylix = {
    enable = true;
    image = ./Wallpaper.jpg;
    targets = {
      nvf.transparentBackground = true;
      waybar.addCss = true;
      zen-browser = {
        profileNames = ["mridula"];
      };
    };
  };
  programs = {
    zen-browser = {
      enable = true;
      profiles.mridula = {
        settings."extensions.autoDisableScopes" = 0;
        extensions = {
          force = true;
          packages = with inputs.firefox-addons.packages.${pkgs.system}; [
            ublock-origin
            privacy-badger
            proton-pass
            ctrl-number-to-switch-tabs
            dearrow
            decentraleyes
            sponsorblock
            duckduckgo-privacy-essentials
            #improved-tube
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
    home-manager.enable = true;
  };
}
