{inputs, ...}: {
  perSystem = {pkgs, ...}: {
    packages.zsh =
      (inputs.wrappers.wrapperModules.zsh.apply {
        inherit pkgs;
        settings = {
          autocd = true;
        };
        integrations = {
          fzf.enable = true;
          starship.enable = true;
          zoxide = {
            enable = true;
            flags = ["--cmd cd"];
          };
        };
      }).wrapper;
  };
}
