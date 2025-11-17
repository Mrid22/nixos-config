{
  config,
  pkgs,
  inputs,
  ...
}: {
  home-manager = {
    extraSpecialArgs = {inherit inputs;};
    users = {
      "mridula" = import ./home.nix;
    };
  };

  users = {
    defaultUserShell = pkgs.zsh;
    users.mridula = {
      isNormalUser = true;
      description = "Mridul Agarwal";
      extraGroups = [
        "networkmanager"
        "wheel"
      ];
    };
  };
}
