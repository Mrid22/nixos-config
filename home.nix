{...}: {
  imports = [
    ./home/apps/librewolf.nix
    ./home/apps/zed.nix
    ./home/environments/de.nix
    ./home/environments/terminal.nix
  ];
  home = {
    username = "mridula";
    homeDirectory = "/home/mridula";
    stateVersion = "25.05";
  };

  programs.home-manager.enable = true;
}
