{inputs, ...}: {
  perSystem = {pkgs, ...}: {
    packages.zsh =
      (inputs.mridwrappers.wrapperModules.zsh.apply {
        inherit pkgs;
        settings = {
          autocd = true;
          env.EDITOR = "$(which nvim)";
          shellAliases = {
            gaa = "git add .";
            gcam = "git commit -a -m";
            gp = "git push";
            gd = "git diff";
          };
          completion = {
            enable = true;
            colors = true;
            caseInsensitive = true;
            extraCompletions = true;
            # fuzzySearch = true;
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
            pay-respects.enable = true;
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
