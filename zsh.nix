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
          shellAliases = {
            ls = "eza -lh --icons --git";
            lsa = "eza -lha --icons --git";
            nvim = "nix run ~/nixos-config";
          };
          autocd = true;

          plugins.zinit = {
            enable = true;
            light = [
              "zsh-users/zsh-syntax-highlighting"
            ];
            load = [
              "Grafcube/zinit-git"
            ];
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
