{
  config,
  pkgs,
  inputs,
  self,
  ...
}: {
  imports = [
    ./home/terminal.nix
    ./home/de.nix
    ./home/zen.nix
    ./home/nvf.nix
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
