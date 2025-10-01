{
  config,
  pkgs,
  inputs,
  self,
  ...
}: {
  imports = [
    ./home/environments/terminal.nix
    ./home/environments/de.nix
    ./home/apps/zen.nix
    ./home/apps/nvf.nix
  ];
  home = {
    username = "mridula";
    homeDirectory = "/home/mridula";

    packages = with pkgs; [
      zip
      xz
      unzip
      p7zip

      ripgrep
      jq
      yq-go
      eza
      fzf

      which
      tree
      gnused
      gnutar
      gawk
      zstd
      gnupg
    ];

    stateVersion = "25.05";
  };
  services.kdeconnect.enable = true;
}
