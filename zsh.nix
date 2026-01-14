{inputs, ...}: {
  perSystem = {pkgs, ...}: {
    packages.zsh =
      (
        inputs.mridwrappers.wrapperModules.zsh.apply
        {
          inherit pkgs;
          settings = {
            autocd = true;
            completion.enable = true;
            history = {
              saveNoDups = true;
              append = true;
            };
          };
        }
      ).wrapper;
  };
}
