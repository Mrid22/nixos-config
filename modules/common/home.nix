{
  inputs,
  self,
  ...
}: {
  imports = [
    inputs.home-manager.flakeModules.home-manager
  ];

  flake.homeModules.home-config = {pkgs, ...}: {
    imports = with inputs; [
      zen-browser.homeModules.twilight
      vicinae.homeManagerModules.default
    ];

    home = {
      username = "mridula";
      homeDirectory = "/home/mridula";
      stateVersion = "25.11";
    };

    services.swaync.enable = true;

    programs = {
      obsidian = {
        enable = true;
        vaults.notes.target = "Notes";
        defaultSettings = {
          app = {
            spellCheck = true;
            alwaysUpdateLinks = true;
            attachmentFolderPath = "Attachements";
            vimMode = true;
          };
          hotkeys = {
            "omnisearch:show-modal-infile" = [
              {
                modifiers = [
                  "Mod"
                  "Shift"
                ];
                key = "P";
              }
            ];
            "omnisearch:show-modal" = [
              {
                modifiers = [
                  "Mod"
                ];
                key = "P";
              }
            ];
          };
          corePlugins = [
            "file-explorer"
            "global-search"
            "switcher"
            "graph"
            "backlink"
            "outgoing-link"
            "tag-pane"
            "properties"
            "page-preview"
            "daily-notes"
            "templates"
            "note-composer"
            "slash-command"
            "editor-status"
            "bookmarks"
            "outline"
            "file-recovery"
            "bases"
          ];
          communityPlugins = with pkgs.obsidianPlugins; [
            omnisearch
            obsidian-excalidraw-plugin
            attachment-management
            text-extractor
            pdf-plus
          ];
        };
      };
      quickshell = {
        enable = true;
        systemd.enable = true;
        configs = {
          "default" = inputs.self.outPath + "/quickshell/default";
        };
        activeConfig = "default";
      };
      btop.enable = true;
      vicinae = {
        enable = true;
        systemd = {
          enable = true;
          autoStart = true;
        };
        settings = {
          close_on_focus_loss = true;
          pop_to_root_on_close = false;
          keybinding = "emacs";
          keybinds = {
            toggle-action-panel = "control+K";
            "action.new" = "control+A";
            open-search-filter = "control+F";
          };
          providers = {
            "@Gelei/vicinae-extension-bluetooth-0" = {
              preferences = {
                connectionToggleable = true;
              };
              entrypoints.devices.alias = "btd";
            };
            "@knoopx/vicinae-extension-nix-0" = {
              entrypoints.options.alias = "nxo";
            };
          };
        };
        extensions = with inputs.vicinae-extensions.packages.${pkgs.stdenv.hostPlatform.system}; [
          nix
          wifi-commander
          process-manager
          player-pilot
          color-converter
        ];
      };
      obs-studio = {
        enable = true;
        plugins = with pkgs.obs-studio-plugins; [
          wlrobs
          obs-backgroundremoval
          obs-pipewire-audio-capture
        ];
      };
      vscode = {
        enable = true;
        package = pkgs.vscode.fhs;
        profiles.default = {
          extensions = with pkgs.vscode-extensions; [
            visualstudiotoolsforunity.vstuc
            vscodevim.vim
          ];
          userSettings = {
            "chat.disableAIFeatures" = true;
            dotnet = {
              acquisitionExtension.enable = false;
              server.useOmnisharp = true;
              enablePackageRestore = true;
              automaticallyInstallRuntime = false;
            };
            omnisharp = {
              dotnetPath = "dotnet";
              monoPath = "mono";
              useModernNet = true;
              autoStart = true;
              loggingLevel = "debug";
              path = "OmniSharp";
            };
          };
        };
      };

      gh = {
        enable = true;
        settings.git_protocol = "ssh";
        gitCredentialHelper.enable = true;
      };
      hyprshot = {
        enable = true;
        saveLocation = "$HOME/Pictures/Screenshots";
      };
      zen-browser = {
        enable = true;
        setAsDefaultBrowser = true;
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
            violentmonkey
            privacy-badger
            duckduckgo-privacy-essentials
            consent-o-matic
            dearrow
            proton-pass
            zen-internet
            noscript
            sponsorblock
          ];
          keyboardShortcuts = [
            {
              id = "key_quitApplication";
              disabled = true;
            }
            {
              id = "key_selectTab1";
              key = "1";
              modifiers.control = true;
            }
            {
              id = "key_selectTab2";
              key = "2";
              modifiers.control = true;
            }
            {
              id = "key_selectTab3";
              key = "3";
              modifiers.control = true;
            }
            {
              id = "key_selectTab4";
              key = "4";
              modifiers.control = true;
            }
            {
              id = "key_selectTab5";
              key = "5";
              modifiers.control = true;
            }
            {
              id = "key_selectTab6";
              key = "6";
              modifiers.control = true;
            }
            {
              id = "key_selectTab7";
              key = "7";
              modifiers.control = true;
            }
            {
              id = "key_selectTab8";
              key = "8";
              modifiers.control = true;
            }
            {
              id = "key_selectTab9";
              key = "9";
              modifiers.control = true;
            }
            {
              id = "key_selectTab10";
              key = "0";
              modifiers.control = true;
            }
          ];
          keyboardShortcutsVersion = 20;
          mods = [
            "642854b5-88b4-4c40-b256-e035532109df"
            "a5f6a231-e3c8-4ce8-8a8e-3e93efd6adec"
            "a6335949-4465-4b71-926c-4a52d34bc9c0"
          ];
          search = {
            default = "ddg";
            force = true;
            engines = {
              mynixos = {
                name = "My NixOS";
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
                definedAliases = ["@nx"];
              };
            };
          };
        };
      };

      home-manager.enable = true;
    };

    wayland.windowManager.hyprland = {
      enable = true;
      configType = "lua";
      extraConfig = builtins.readFile ./hyprland.lua;
    };
  };
}
