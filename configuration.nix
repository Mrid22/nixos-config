{
  config,
  pkgs,
  inputs,
  ...
}: {
  imports = [
    # Include the results of the hardware scan.
    ./hardware-configuration.nix
    ./config/system.nix
    ./config/server.nix
  ];
  services = {
    tlp.enable = true;
    xserver = {
      enable = true;
      xkb = {
        layout = "us";
        variant = "";
      };
    };
    udisks2.enable = true;
    displayManager.sddm.enable = true;
    desktopManager.plasma6.enable = true;
    syncthing = {
      enable = true;
      openDefaultPorts = true;
    };
    keyd = {
      enable = true;
      keyboards = {
        default = {
          ids = ["*"];
          settings = {
            main = {
              capslock = "overload(control, esc)";
            };
          };
        };
      };
    };

    printing.enable = true;
    blueman.enable = true;
    pulseaudio.enable = false;
    pipewire = {
      enable = true;
      alsa.enable = true;
      alsa.support32Bit = true;
      pulse.enable = true;
    };
  };
  security.rtkit.enable = true;

  fonts.packages = with pkgs; [
    nerd-fonts.fira-code
  ];
  users = {
    defaultUserShell = pkgs.zsh;
    users.mridula = {
      isNormalUser = true;
      description = "Mridul Agarwal";
      extraGroups = ["networkmanager" "wheel"];
    };
  };
  programs = {
    gnome-disks.enable = true;
    adb.enable = true;
    zsh.enable = true;
    hyprland.enable = true;
    neovim = {
      enable = true;
      defaultEditor = true;
    };
  };
  nixpkgs = {
    config.allowUnfree = true;
    overlays = [inputs.nix-firefox-addons.overlays.default];
  };

  environment.systemPackages = with pkgs; [
    git
    proton-authenticator
    wireguard-tools
    protonvpn-gui
    wl-clipboard
    mediawriter
  ];
}
