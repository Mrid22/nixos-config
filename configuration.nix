{
  config,
  pkgs,
  inputs,
  ...
}: {
  imports = [
    # Include the results of the hardware scan.
    ./system.nix
    ./server.nix
    inputs.home-manager.nixosModules.default
  ];

  users = {
    defaultUserShell = pkgs.fish;
    users.mridula = {
      isNormalUser = true;
      description = "Mridul Agarwal";
      extraGroups = ["networkmanager" "wheel"];
    };
  };

  virtualisation.virtualbox.host.enable = true;
  services.blueman.enable = true;

  programs = {
    hyprland.enable = true;
    fish.enable = true;
    gnome-disks.enable = true;
    neovim.defaultEditor = true;
    steam = {
      enable = true;
      gamescopeSession.enable = true;
    };
    gamescope = {
      enable = true;
      capSysNice = true;
    };
    gamemode.enable = true;
  };

  environment = {
    variables = {
      EDITOR = "nvim";
      VISUAL = "nvim";
      TERM = "kitty";
    };
    systemPackages = with pkgs; [
      bluez
      bluez-tools
      kdePackages.dolphin
      lutris
      heroic
      brightnessctl
      kdePackages.ark
      playerctl
      hyprshot
      hyprpicker
      wineWowPackages.full
      nodejs
      pnpm
      lunar-client
      mangohud
      protonup
      pavucontrol
      wf-recorder
      godot_4
      jetbrains.webstorm
      jetbrains.pycharm-community
      nwg-look
      pamixer
      libsForQt5.qtstyleplugin-kvantum
      (import ./rebuild.nix {inherit pkgs;})
      (import ./autogit.nix {inherit pkgs;})
    ];

    sessionVariables = {
      STEAM_EXTRA_COMPAT_TOOLS_PATHS = "\${HOME}/.steam/root/compatibilitytools.d";
    };
  };

  fonts.packages = with pkgs; [
    noto-fonts
    noto-fonts-cjk-sans
    noto-fonts-emoji
    nerd-fonts.fira-code
  ];

  home-manager = {
    extraSpecialArgs = {inherit inputs;};
    backupFileExtension = ".bak";
    users = {
      "mridula" = import ./home.nix;
    };
  };
}
