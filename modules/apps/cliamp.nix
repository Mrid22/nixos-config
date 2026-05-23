{inputs, ...}: {
  perSystem = {
    pkgs,
    self',
    ...
  }: {
    packages.cliamp =
      (inputs.mridwrappers.wrapperModules.cliamp.apply {
        inherit pkgs;
        theme = {
          name = "darkpurp";
          extraThemes."darkpurp" = {
            bg = "#FF";
            fg = "#F0";
          };
        };
        settings = {
          jellyfin = {
            username = "hello";
            password = "hel";
          };
        };
      }).wrapper;
  };
}
