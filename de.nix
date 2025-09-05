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
        "$mod, Q, exec, kitty"
        "$mod, 1, workspace, 1"
      ];
    };
  };
}
