{
  flake.nixosModules.homelab = {
    pkgs,
    inputs,
    lib,
    ...
  }: {
    services.ollama = {
      package = pkgs.ollama-cuda;
      enable = true;
      syncModels = true;
      loadModels = ["qwen3-coder-next:cloud"];
    };
  };
}
