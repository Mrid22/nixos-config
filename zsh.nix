{inputs, ...}: {
  perSystem = {pkgs, ...}: {
    packages.zsh =
      (
        inputs.mridwrappers.wrapperModules.zsh.apply
        {
          inherit pkgs;
            keyMap = "vicmd";
	    completion.enable = true;
            shellAliases = {
              "hdon" = "hyprctl dispatch dpms on";
              "hdoff" = "hyprctl dispatch dpms off";
	      "nvim" = "nix run ~/nixos-config";
            };
        }
      ).wrapper;
  };
}
