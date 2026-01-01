{
  pkgs,
  inputs,
  ...
}: {
  imports = with inputs; [
    vicinae.homeManagerModules.default
    catppuccin.homeModules.catppuccin
  ];

  home = {
    username = "mridula";
    homeDirectory = "/home/mridula";
    stateVersion = "25.11";
  };

  services.vicinae = {
    enable = true; # default: false
    systemd = {
      enable = true; # default: false
      autoStart = true; # default: false
    };
    settings = {
      close_on_focus_loss = true;
      search_files_in_root = true;
      pop_to_root_on_close = false;
      launcher_window.opacity = 0.5;
    };
    extensions = with inputs.vicinae-extensions.packages.${pkgs.stdenv.hostPlatform.system}; [
      bluetooth
      nix
      power-profile
    ];
  };

  catppuccin.enable = true;

  wayland.windowManager.hyprland = {
    enable = true;
    package = inputs.hyprland.packages.x86_64-linux.hyprland;
    settings = {
      exec-once = ["vicinae server"];
      bind = [
        "ALT, Q, exec, kitty"
        "ALT, F, exec, librewolf"
        "ALT, SPACE, exec, vicinae open"
        "ALT, C, killactive"
        "ALT, H, movefocus, l"
        "ALT, J, movefocus, d"
        "ALT, K, movefocus, u"
        "ALT, L, movefocus, r"

        "ALT, 1, workspace, 1"
        "ALT, 2, workspace, 2"
        "ALT, 3, workspace, 3"
        "ALT, 4, workspace, 4"
        "ALT, 5, workspace, 5"
        "ALT, 6, workspace, 6"
        "ALT, 7, workspace, 7"
        "ALT, 8, workspace, 8"
        "ALT, 9, workspace, 9"
        "ALT, 0, workspace, 10"

        "ALT SHIFT, 1, movetoworkspace, 1"
        "ALT SHIFT, 2, movetoworkspace, 2"
        "ALT SHIFT, 3, movetoworkspace, 3"
        "ALT SHIFT, 4, movetoworkspace, 4"
        "ALT SHIFT, 5, movetoworkspace, 5"
        "ALT SHIFT, 6, movetoworkspace, 6"
        "ALT SHIFT, 7, movetoworkspace, 7"
        "ALT SHIFT, 8, movetoworkspace, 8"
        "ALT SHIFT, 9, movetoworkspace, 9"
        "ALT SHIFT, 0, movetoworkspace, 10"
      ];
    };
  };

  programs = {
    home-manager.enable = true;
    kitty.enable = true;
    librewolf = {
      enable = true;
      profiles.mridula = {
        extensions.packages = with inputs.firefox-addons.packages.${pkgs.stdenv.hostPlatform.system}; [
          ublock-origin
          dearrow
          proton-pass
          canvasblocker
          noscript
          catppuccin-web-file-icons
          catppuccin-mocha-mauve
          censor-tracker
          clearurls
          consent-o-matic
          noscript
          firenvim
          snowflake
        ];
      };
    };
    eza = {
      enable = true;
      git = true;
      enableZshIntegration = true;
    };
    zsh = {
      enable = true;
      autosuggestion.enable = true;
      syntaxHighlighting.enable = true;
      oh-my-zsh = {
        enable = true;
        plugins = ["git" "sudo"];
      };
      shellAliases."nvim" = "nix run ~/nixos-config";
    };
  };
}
