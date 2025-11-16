{
  config,
  pkgs,
  inputs,
  lib,
  ...
}:
{
  options.gaming = {
    enable = lib.mkEnableOption "enable general gaming stuff" lib.mkDefault true;
    nvidia.enable =
      lib.mkEnableOption "enable nvidia incase im moving to a computer without it" lib.mkDefault
        false;
  };

  config = {
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

    nvidia = lib.mkIf config.gaming.nvidia.enable {
      services.xserver.videoDrivers = [ "nvidia" ];
      nvidia = {
        modesetting.enable = true;
        open = true;
        powerManagement.enable = true;
        powerManagement.finegrained = true;

        prime.offload = {
          enable = true;
          enableOffloadCmd = true;
        };
      };
      nvidia.prime.intelBusId = "PCI:0:2:0";
      nvidia.prime.nvidiaBusId = "PCI:1:0:0";
    };
  };
}
