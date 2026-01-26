{inputs, ...}: {
  perSystem = {pkgs, ...}: {
    packages.kitty =
      (
        inputs.wrappers.wrapperModules.kitty.apply
        {
          inherit pkgs;
          settings = {
            background_opacity = 0.5;
            confirm_os_window_close = 0;
            themeFile = "Catppuccin-Mocha";
          };
        }
      ).wrapper;
  };
}
