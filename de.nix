{
  config,
  pkgs,
  inputs,
  ...
}: {
  imports = [
    inputs.vicinae.homeManagerModules.default
  ];
  services = {
    swww.enable = true;
    swaync.enable = true;
    vicinae = {
      enable = true;
      autoStart = true;
      settings = {
        popToRootonClose = true;
        rootSearch.searchFiles = true;
      };
    };
  };
}
