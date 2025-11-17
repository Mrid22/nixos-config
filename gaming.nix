{
  config,
  pkgs,
  inputs,
  lib,
  ...
}: let
  gaming = {
    hardware = {
      graphics = {
        enable = true;
        enable32Bit = true;
      };
    };
    programs = {
      steam = {
        enable = true;
        gamescopeSession.enable = true;
      };
      gamemode.enable = true;
    };
    environment.systemPackages = with pkgs; [
      mangohud
    ];
  };

  nvidia = {
    services.xserver.videoDrivers = ["nvidia"];
    hardware.nvidia = {
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

  xbox-controller = {
    hardware = {
      xpadneo.enable = true;
      bluetooth = {
        enable = true; # enables support for Bluetooth
        powerOnBoot = true; # powers up the default Bluetooth controller on boot
        settings = {
          General = {
            Privacy = "device";
            JustWorksRepairing = "always";
            Class = "0x000100";
            FastConnectable = "true";
          };
        };
      };
    };
  };
in {
  options.gaming = {
    enable = lib.mkEnableOption "enable module ";
    nvidia = lib.mkEnableOption "toggle nvidia incase im moving to a computer without it";
    xbox-controller = lib.mkEnableOption "toggle xbox controller support incase I switch to steam or smth";
  };
  config = lib.mkMerge [
    (lib.mkIf config.gaming.enable gaming)
    (lib.mkIf config.gaming.nvidia nvidia)
    (lib.mkIf (config.gaming.xbox-controller && config.gaming.enable) xbox-controller)
  ];
}
