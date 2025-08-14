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
    defaultUserShell = pkgs.zsh;
    users.mridula = {
      isNormalUser = true;
      description = "Mridul Agarwal";
      extraGroups = ["networkmanager" "wheel"];
    };
  };

  programs = {
    hyprland.enable = true;
    zsh.enable = true;
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
    };
    systemPackages = with pkgs; [
      kdePackages.dolphin
      brightnessctl
      kdePackages.ark
      playerctl
      hyprshot
      nodejs
      pnpm
      lunar-client
      mangohud
      protonup
      pavucontrol
      wf-recorder
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
    useGlobalPkgs = true;
    backupFileExtension = ".bak";
    users = {
      "mridula" = import ./home.nix;
    };
  };
}
