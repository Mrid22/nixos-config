{
  config,
  pkgs,
  inputs,
  ...
}: {
  imports = [
    inputs.vicinae.homeManagerModules.default
  ];
  gtk = {
    enable = true;
    theme = {
      package = pkgs.layan-gtk-theme;
      name = "Layan-Dark";
    };
  };

  services.vicinae = {
    enable = true; # default: false
    autoStart = true; # default: true
    settings = {
      faviconService = "twenty"; # twenty | google | none
      font.size = 11;
      popToRootOnClose = false;
      rootSearch.searchFiles = true;
      theme.name = "tokyonight-storm";
    };
  };

  services.hyprpaper = {
    enable = true;
    settings = {
      preload = ["~/nixos-config/Wallpaper.jpg"];
      wallpaper = [",~/nixos-config/Wallpaper.jpg"];
    };
  };

  wayland.windowManager.hyprland = {
    enable = true;
    settings = {
      bind = [
        "ALT,Q,exec,kitty"
        "ALT,F,exec,zen-twilight"
        "ALT,C,killactive"
        "ALT,H,movefocus,l"
        "ALT,J,movefocus,d"
        "ALT,K,movefocus,u"
        "ALT,L,movefocus,r"

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
    };
  };
}
