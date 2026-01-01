{inputs, ...}: {
  perSystem = {pkgs, ...}: {
    packages.git =
      (
        inputs.wrappers.wrapperModules.git.apply
        {
          inherit pkgs;
          settings = {
            user = {
              name = "Mrid22";
              email = "mridulaga@outlook.com";
            };
            init.defaultBranch = "main";
            push.autoSetupRemote = true;
          };
        }
      ).wrapper;
  };
}
