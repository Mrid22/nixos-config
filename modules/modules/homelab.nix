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
        syncModels = true;
        package = pkgs.ollama-cuda;
        loadModels = [
          "devstral-small-2:24b"
        ];
      };
    };
  };
}
