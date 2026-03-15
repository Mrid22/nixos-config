{
  flake.nixosModules.homelab = {
    pkgs,
    inputs,
    lib,
    ...
  }: {
    services = {
      ollama = {
        enable = true;
        package = pkgs.ollama-cuda;
      };
      open-webui.enable = true;
    };
  };
}
