{inputs, ...}: {
  perSystem = {pkgs, ...}: {
    packages.kitty =
      (
        inputs.wrappers.wrapperModules.kitty.apply
        {
          inherit pkgs;
          settings = {
            background_opacity = 0.5;
            themeFile = "Catppuccin-Mocha";
            shellIntegration.enableZshIntegration = true;
          };
        }
      ).wrapper;
  };
}
