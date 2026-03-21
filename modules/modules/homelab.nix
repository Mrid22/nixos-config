{
  flake.nixosModules.homelab = {
    pkgs,
    inputs,
    lib,
    ...
  }: {
    fileSystems."/media/" = {
      device = "/dev/sda1";
      fsType = "exfat";
      options = [
        "users" # Allows any user to mount and unmount
        "nofail" # Prevent system from failing if this drive doesn't mount
        "exec" # Permit execution of binaries and other executable files
      ];
    };
    services.ollama = {
      package = pkgs.ollama-cuda;
      enable = true;
      syncModels = true;
      loadModels = ["qwen3-coder-next:cloud"];
    };
  };
}
