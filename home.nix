{
  pkgs,
  inputs,
  ...
}: {
  imports = [
    inputs.zen-browser.homeModules.twilight
  ];
  home = {
    username = "mridula";
    homeDirectory = "/home/mridula";
    stateVersion = "25.11";
  };

  gtk = {
    enable = true;
    theme = {
      name = "Layan-Dark";
      package = pkgs.layan-gtk-theme;
    };
  };

  programs = {
    kitty = {
      enable = true;
      settings.background_opacity = 0.5;
    };

    zen-browser = {
      enable = true;
      policies = {
        AutofillAddressEnabled = true;
        AutofillCreditCardEnabled = false;
        DisableAppUpdate = true;
        DisableFeedbackCommands = true;
        DisableFirefoxStudies = true;
        DisablePocket = true;
        DisableTelemetry = true;
        DontCheckDefaultBrowser = false;
        NoDefaultBookmarks = true;
        OfferToSaveLogins = false;
        EnableTrackingProtection = {
          Value = true;
          Locked = true;
          Cryptomining = true;
          Fingerprinting = true;
        };
      };
      profiles.mridula = {
        extensions.packages = with inputs.firefox-addons.packages.${pkgs.stdenv.hostPlatform.system}; [
          ublock-origin
          decentraleyes
          privacy-badger
          duckduckgo-privacy-essentials
          dearrow
          proton-pass
          zen-internet
        ];
        mods = [
          "642854b5-88b4-4c40-b256-e035532109df"
          "a5f6a231-e3c8-4ce8-8a8e-3e93efd6adec"
        ];
        search = {
          force = true;
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
                      value = "searchTerms";
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

    delta = {
      enable = true;
      enableGitIntegration = true;
    };

    git = {
      enable = true;
      settings = {
        user = {
          name = "Mrid22";
          email = "mridulaga@outlook.com";
        };
        init.defaultBranch = "main";
      };
    };

    home-manager.enable = true;
  };

  wayland.windowManager.hyprland = {
    enable = true;
    settings = {
      bind = [
        "ALT,Q,exec,kitty"
        "ALT,F,exec,zen-twilight"

        "ALT,H,movefocus,l"
        "ALT,J,movefocus,d"
        "ALT,K,movefocus,u"
        "ALT,L,movefocus,r"
        "ALT,C,killactive"

        "ALT,1,workspace,1"
        "ALT,2,workspace,2"
        "ALT,3,workspace,3"
        "ALT,4,workspace,4"
        "ALT,5,workspace,5"
        "ALT,6,workspace,6"
        "ALT,7,workspace,7"
        "ALT,8,workspace,8"
        "ALT,9,workspace,9"
        "ALT,0,workspace,10"

        "ALT SHIFT,1,movetoworkspace,1"
        "ALT SHIFT,2,movetoworkspace,2"
        "ALT SHIFT,3,movetoworkspace,3"
        "ALT SHIFT,4,movetoworkspace,4"
        "ALT SHIFT,5,movetoworkspace,5"
        "ALT SHIFT,6,movetoworkspace,6"
        "ALT SHIFT,7,movetoworkspace,7"
        "ALT SHIFT,8,movetoworkspace,8"
        "ALT SHIFT,9,movetoworkspace,9"
        "ALT SHIFT,0,movetoworkspace,10"
      ];
      general = {
        gaps_in = 5;
        gaps_out = 5;
        border_size = 0;
      };
      decoration.rounding = 5;
    };
  };
}
