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
              nvim = "nix run ~/nixos-config";
              hdon = "hyprctl dispatch dpms on";
            };
          };
        }
      ).wrapper;
  };
}
