{
  config,
  pkgs,
  inputs,
  ...
}: let
  rebuild =
    import ../scripts/rebuild.nix {inherit pkgs;};
in {
  services.keyd = {
    enable = true;
    keyboards.default = {
      ids = ["*"];
      settings.main = {
        capslock = "overload(control,escape)";
      };
    };
  };

  programs = {
    zsh.enable = true;
    hyprland.enable = true;
    neovim = {
      enable = true;
      defaultEditor = true;
    };
  };
  nixpkgs.config.allowUnfree = true;

  environment.systemPackages = with pkgs; [
    playerctl
    wl-clipboard
    kitty
    blueberry
    rebuild
  ];
}
