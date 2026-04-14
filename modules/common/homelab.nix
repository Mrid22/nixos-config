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
        loadModels = ["qwen3-coder-next:cloud" "gemma4"];
      };
      #Arr
      sonarr.enable = true;
      prowlarr.enable = true;
      bazarr.enable = true;
      flaresolverr.enable = true;
      jellyfin.enable = true;
      seerr.enable = true;

      home-assistant = {
        enable = true;
        extraComponents = [
          "analytics"
          "google_translate"
          "met"
          "radio_browser"
          "shopping_list"
          "isal"
        ];
        config = {
          default_config = {};
        };
      };

      transmission = {
        enable = true;
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
          "7d156d9b-5d67-4cb5-9a7e-c25ae2f708ce" = {
            credentialsFile = "/etc/cloudflared/7d156d9b-5d67-4cb5-9a7e-c25ae2f708ce.json";
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
