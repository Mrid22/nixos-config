{inputs, ...}: {
  perSystem = {pkgs, ...}: {
    packages.zsh =
      (inputs.wrappers.wrapperModules.zsh.apply {
        inherit pkgs;
        settings = {
          autocd = true;
          history.share = true;
          env.EDITOR = "$(which nvim)";
          integrations = {
            fzf.enable = true;
            starship.enable = true;
            zoxide = {
              enable = true;
              flags = ["--cmd cd"];
            };
          };
        };
      }).wrapper;
  };
}
