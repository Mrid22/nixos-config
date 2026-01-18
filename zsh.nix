{inputs, ...}: {
  perSystem = {pkgs, ...}: {
    packages.zsh =
      (
        inputs.mridwrappers.wrapperModules.zsh.apply
        {
          inherit pkgs;
          settings = {
            keyMap = "emacs";
            shellAliases = {
              nvim = "nix run ~/nixos-config";
              hdon = "hyprctl dispatch dpms on";
              ls = "eza --icons";
              gaa = "git add .";
              gcam = "git commit -a -m";
              gp = "git push";
            };
            env = {
              NH_OS_FLAKE = "~/nixos-config";
            };
            history = {
              append = true;
              expanded = true;
              ignoreSpace = true;
              saveNoDups = true;
              ignoreDups = true;
            };
          };
          extraRC = ''
            eval "$(zoxide init zsh --cmd cd)"
            eval "$(oh-my-posh init zsh)"
          '';
        }
      ).wrapper;
  };
}
