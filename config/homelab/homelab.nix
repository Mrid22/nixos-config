{
  config,
  pkgs,
  inputs,
  ...
}: {
  imorts = [
    inputs.selfhostblocks.nixosModules.default
  ];
}
