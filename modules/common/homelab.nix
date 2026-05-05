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

    virtualisation.oci-containers = {
      backend = "podman";
      containers.homeassistant = {
        volumes = ["home-assistant:/config"];
        environment.TZ = "Asia/Nicosia";
        # Note: The image will not be updated on rebuilds, unless the version label changes
        image = "ghcr.io/home-assistant/home-assistant:stable";
        extraOptions = [
          # Use the host network namespace for all sockets
          "--network=host"
        ];
      };
    };

    services = {
      ollama = {
        package = pkgs.ollama-cuda;
        enable = true;
        loadModels = ["qwen3-coder-next:cloud" "gemma4"];
      };
      #Arr
      sonarr.enable = true;
      prowlarr.enable = true;
      bazarr.enable = true;
      flaresolverr.enable = true;
      jellyfin.enable = true;
      seerr.enable = true;

      transmission = {
        enable = true;
        openRPCPort = true;
        settings = {
          download-dir = "/media/downloads/complete/";
          incomplete-dir = "/media/downloads/incomplete/";
          incomplete-dir-enabled = true;
        };
      };

      immich.enable = true;

      cloudflared = {
        enable = true;
        tunnels = {
          "05ed54b5-8f4c-4b90-9ad7-3ad0d25f6bb3" = {
            credentialsFile = "/etc/cloudflared/05ed54b5-8f4c-4b90-9ad7-3ad0d25f6bb3.json";
            default = "http_status:404";
            ingress = {
              "jf.shmanju.org" = "http://localhost:8096";
              "js.shmanju.org" = "http://localhost:5055";
            };
          };
        };
      };
    };
  };
}
