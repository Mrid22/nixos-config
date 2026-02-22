{inputs, ...}: {
  perSystem = {
    pkgs,
    self',
    ...
  }: {
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
              "Grafcube/zinit-git"
            ];
            oh-my-zsh.plugins = [
              "sudo"
            ];
          };

          integrations = {
            starship = {
              enable = true;
              package = self'.packages.starship;
            };
            fzf.enable = true;
            zoxide = {
              enable = true;
              flags = [
                "--cmd cd"
              ];
            };
          };
        };
      }).wrapper;
  };
}
