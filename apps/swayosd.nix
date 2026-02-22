{inputs, ...}: {
  perSystem = {pkgs, ...}: {
    packages.swayosd =
      (inputs.wrappers.wrapperModules.swayosd.apply {inherit pkgs;}).wrapper;
  };
}
