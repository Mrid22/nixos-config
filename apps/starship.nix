{inputs, ...}: {
  perSystem = {pkgs, ...}: {
    packages.starship =
      (inputs.wrappers.wrapperModules.starship.apply {
        inherit pkgs;
      }).wrapper;
  };
}
