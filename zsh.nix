{inputs, ...}: {
  perSystem = {pkgs, ...}: {
    packages.git =
      (
        inputs.wrappers.wrapperModules.zsh.apply
        {
          inherit pkgs;
          settings = {
            keyMap = "vi";
          };
        }
      ).wrapper;
  };
}
