{
  flake.nixosModules.homelab = {
    pkgs,
    inputs,
    ...
  }: {
    services = {
      ollama = {
        enable = true;
      };
    };
  };
}
