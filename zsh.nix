{inputs, ...}: {
  perSystem = {pkgs, ...}: {
    packages.zsh =
      (
        inputs.mridwrappers.wrapperModules.zsh.apply
        {
          inherit pkgs;
          settings = {
            keyMap = "emacs";
            integrations = {
              atuin.enable = true;
              oh-my-posh.enable = true;
            };
            shellAliases = {
              nvim = "nix run ~/nixos-config";
              hdon = "hyprctl dispatch dpms on";
              hdoff = "hyprctl dispatch dpms off";
              ls = "eza --icons";
              gaa = "git add .";
              gcam = "git commit -a -m";
              gp = "git push";
              gd = "git diff";
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
          '';
        }
      ).wrapper;
  };
}
