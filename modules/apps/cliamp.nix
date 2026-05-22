{inputs, ...}: {
  perSystem = {
    pkgs,
    self',
    ...
  }: {
    packages.cliamp =
      (inputs.mridwrappers.wrapperModules.cliamp.apply {
        inherit pkgs;
        settings = {
          jellyfin = {
            username = "hello";
            password = "hel";
          };
        };
      }).wrapper;
  };
}
