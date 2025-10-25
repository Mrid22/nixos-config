{
  config,
  pkgs,
  inputs,
  ...
}: {
  imports = [
    ./home/environments/de.nix
    ./home/environments/terminal.nix
    ./home/apps/zen-browser.nix
    ./home/apps/nvf.nix
  ];
  home = {
    username = "mridula";
    homeDirectory = "/home/mridula";
    stateVersion = "25.05";
  };
  stylix = {
    enable = true;
    image = ./Wallpaper.jpg;
    targets = {
      nvf.transparentBackground = true;
      waybar.addCss = true;
    };
  };

  programs.home-manager.enable = true;
}
