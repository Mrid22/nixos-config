{inputs, ...}: {
  perSystem = {pkgs, ...}: {
    packages.zsh =
      (
        inputs.mrid-wrappers.wrapperModules.zsh.apply
        {
          inherit pkgs;
          settings = {
            shellAliases = {
              hdon = "hyprctl dispatch dpms on";
            };
          };
        }
      ).wrapper;
  };
}
