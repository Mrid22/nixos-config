{
  config,
  pkgs,
  inputs,
  lib,
  ...
}:
let
  gaming = lib.mkIf config.gaming.enable {
    hardware = {
      opengl = {
        enable = true;
        driSupport = true;
        driSupport32Bit = true;
      };

    };
    programs = {
      steam = {
        enable = true;
        gameScopeSession.enable = true;
      };
      gamemode.enable = true;
    };
    environment.systemPackages = with pkgs; [
      mangohud
    ];
  };
  nvidia = lib.mkIf config.gaming.nvidia {
    services.xserver.videoDrivers = [ "nvidia" ];
    nvidia = {
      modesetting.enable = true;
      open = true;
      powerManagement = {
        enable = true;
        finegrained = true;
      };
      prime = {
        offload = {
          enable = true;
          enableOffloadCmd = true;
        };
        intelBusId = "PCI:0:2:0";
        nvidiaBusId = "PCI:1:0:0";
      };
    };
  };
in
{
  options.gaming = {
    enable = lib.mkEnableOption "enable module ";
    nvidia = lib.mkEnableOption "enable nvidia incase im moving to a computer without it";
  };
  config = lib.mkMerge [
    (lib.mkIf config.gaming.enable gaming)
    (lib.mkIf (config.gaming.enable && config.gaming.nvidia) nvidia)
  ];
}
