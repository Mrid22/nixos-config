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
      #Arr
      sonarr.enable = true;
      prowlarr.enable = true;
      radarr.enable = true;
      bazarr.enable = true;
      flaresolverr.enable = true;
      jellyfin = {
        enable = true;
        hardwareAcceleration = {
          enable = true;
          type = "nvenc";
          device = "/dev/dri/renderD128";
        };
      };
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
          "946f223f-58c0-4dc8-9309-f6529259e5cf" = {
            credentialsFile = "/etc/cloudflared/946f223f-58c0-4dc8-9309-f6529259e5cf.json";
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
