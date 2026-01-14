{inputs, ...}: {
  perSystem = {pkgs, ...}: {
    packages.zsh =
      (
        inputs.wrappers.wrapperModules.zsh.apply
        {
          inherit pkgs;
          settings = {
            keyMap = "vi";
            shellAliases = {
              "hdon" = "hyprctl dispatch dpms on";
              "hdoff" = "hyprctl dispatch dpms off";
            };
          };
        }
      ).wrapper;
  };
}
