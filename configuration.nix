{
  config,
  pkgs,
  inputs,
  ...
}: {
  imports = [
    # Include the results of the hardware scan.
    ./system.nix
#   ./server.nix
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

  # services.blueman.enable = true;

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
      jellyfin-media-player
      mangohud
      protonup
      pavucontrol
      wf-recorder
      godot_4
      nwg-look
      pamixer
      git
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
