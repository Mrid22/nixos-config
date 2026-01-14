{inputs, ...}: {
  perSystem = {pkgs, ...}: {
    packages.zsh =
      (
        inputs.mridwrappers.wrapperModules.zsh.apply
        {
          inherit pkgs;
          settings = {
            keyMap = "emacs";
            shellAliases = {
              "hdon" = "hyprctl dispatch dpms on";
              "hdoff" = "hyprctl dispatch dpms off";
            };
          };
        }
      ).wrapper;
  };
}
