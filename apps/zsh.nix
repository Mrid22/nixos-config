{inputs, ...}: {
  perSystem = {pkgs, ...}: {
    packages.zsh =
      (inputs.wrappers.wrapperModules.zsh.apply {
        inherit pkgs;
        settings = {
          autocd = true;
          env.EDITOR = "$(which nvim)";
          completion = {
            colors = true;
            caseInsensitive = true;
            extraCompletions = true;
          };
          history = {
            append = true;
            share = true;
            findNoDups = true;
            ignoreAllDups = true;
            ignoreDups = true;
            ignoreSpace = true;
            saveNoDups = true;
          };
          autoSuggestions.enable = true;
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
