{
  flake.nixosModules.homelab = {
    pkgs,
    inputs,
    lib,
    ...
  }: {
    environment.systemPackages = with pkgs; [
      spotdl
    ];
    fileSystems."/media" = {
      device = "/dev/sda1";
      fsType = "ntfs";
      options = [
        "users" # Allows any user to mount and unmount
        "nofail" # Prevent system from failing if this drive doesn't mount
        "exec" # Permit execution of binaries and other executable files
      ];
    };
    services = {
      ollama = {
        enable = true;
        loadModels = ["qwen3-coder-next:cloud"];
      };
      #Arr
      sonarr.enable = true;
      prowlarr.enable = true;
      bazarr.enable = true;
      flaresolverr.enable = true;

      transmission = {
        enable = true;
        settings = {
          download-dir = "/media/downloads/complete/";
          incomplete-dir = "/media/downloads/incomplete/";
          incomplete-dir-enabled = true;
        };
      };

      jellyfin.enable = true;

      seerr.enable = true;

      cloudflared = {
        enable = true;
        tunnels = {
          "f489f917-1174-4010-8171-ea1c08b6d166" = {
            credentialsFile = "/etc/cloudflared/f489f917-1174-4010-8171-ea1c08b6d166.json";
            default = "http_status:404";
          };
        };
      };
    };
  };
}
