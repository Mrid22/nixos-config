{inputs, ...}: {
  perSystem = {pkgs, ...}: {
    packages.hyprpaper =
      (
        inputs.my-wrappers.wrapperModules.hyprpaper.apply
        {
          inherit pkgs;
          settings = {
            preload = ["~/nixos-config/Wallpaper.jpg"];
            wallpaper = [",~/nixos-config/Wallpaper.jpg"];
          };
        }
      ).wrapper;
  };
}
