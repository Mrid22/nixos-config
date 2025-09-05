{
  config,
  pkgs,
  inputs,
  ...
}: {
  wayland.windowManager.hyprland = {
    enable = true;
    systemd.enable = true;
    xwayland.enable = true;
    settings = {
      "$mod" = "ALT";
      bind = [
        "$mainMod, Q, exec, kitty"
      ];
    };
  };
}
