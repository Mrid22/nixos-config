{inputs, ...}: {
  perSystem = {pkgs, ...}: {
    packages.zsh =
      (inputs.mridwrappers.wrapperModules.zsh.apply {
        inherit pkgs;
        settings = {
          autoSuggestions.enable = true;
          completion.enable = true;
          keyMap = "emacs";
          history = {
            append = true;
            ignoreDups = true;
            expireDupsFirst = true;
            saveNoDups = true;
          };
          integrations = {
            zoxide = {
              enable = true;
              flags = [
                "--cmd cd"
              ];
            };
          };
        };
        extraRC = ''
          source <(fzf --zsh)
          eval "$(starship init zsh)"
        '';
      }).wrapper;
  };
}
