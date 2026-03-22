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
          autocd = true;
          env = {
            HIST_FILE = "~/.zsh_history";
            EDITOR = "$(which nvim)";
            PATH = "/nix/store/bqz2sllks58anmkms91fynijx1xvvi8a-fzf-0.70.0/bin:/nix/store/y2jp6fwbsbfvqd4clr4jcx7455ainfll-zoxide-0.9.9/bin:/nix/store/dw1g75jyd5wc5q6hp5ss8sggqsryi1f6-starship/bin:/nix/store/01xjwa6xf1qcc0g1z806gh794k6q14vz-pay-respects-0.7.12/bin:/nix/store/ymjfzdhyy8lqr9bkyb3akljlk30g2jc6-nix-zsh-completions-0.5.1-unstable-2025-12-12/bin:/nix/store/b2bp7j8qzbfqzm5d2gmdvcb5lb6ghjwq-zsh-completions-0.35.0/bin:$PATH";
          };
          shellAliases = {
            gaa = "git add .";
            gcam = "git commit -a -m";
            gp = "git push";
            gd = "git diff";
            ls = "eza --icons --git -lh";
            lsa = "eza --icons --git -lah";
            devsh = "nix develop -c zsh";
          };
          completion = {
            enable = true;
            colors = true;
            caseInsensitive = true;
            extraCompletions = true;
            fuzzySearch = true;
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
            starship = {
              enable = true;
              package = self'.packages.starship;
            };
            zoxide = {
              enable = true;
              flags = ["--cmd cd"];
            };
          };
        };
      }).wrapper;
  };
}
