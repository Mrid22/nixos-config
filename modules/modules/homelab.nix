{
  flake.nixosModules.homelab = {
    pkgs,
    inputs,
    lib,
    ...
  }: {
    services.ollama = {
      enable = true;
      syncModels = true;
      loadModels = ["qwen3-coder-next:cloud"];
    };
  };
}
