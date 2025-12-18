{
  config,
  pkgs,
  inputs,
  ...
}: {
  imports = with inputs; [
    sops-nix.nixosModules.default
    selfhostblocks.nixosModules.sops
  ];

  sops = {
    defaultSopsFile = ./secrets.yaml;
    defaultSopsFormat = "yaml";
    age.keyFile = "/home/mridula/.config/sops/age/keys.txt";
  };

  shb = {
    home-assistant = {
      enable = true;
      subdomain = "ha";
      domain = "shmanju.org";

      config = {
        name = "Mridul Home";
        country.source = config.shb.sops.secret."country".result.path;
        latitude.source = config.shb.sops.secret."latitude".result.path;
        longitude.source = config.shb.sops.secret."longitude".result.path;
        time_zone.source = config.shb.sops.secret."timezone".result.path;
        unit_system = "metric";
      };
    };
    sops.secret = {
      "country".request = {
        mode = "0440";
        owner = "hass";
        group = "hass";
        restartUnits = ["home-assistant.service"];
      };
      "latitude".request = {
        mode = "0440";
        owner = "hass";
        group = "hass";
        restartUnits = ["home-assistant.service"];
      };
      "longitude".request = {
        mode = "0440";
        owner = "hass";
        group = "hass";
        restartUnits = ["home-assistant.service"];
      };
      "timezone".request = {
        mode = "0440";
        owner = "hass";
        group = "hass";
        restartUnits = ["home-assistant.service"];
      };
    };
  };

  programs.gnome-disks.enable = true;

  environment.systemPackages = with pkgs; [
    ntfs3g
    spotdl
  ];

  fileSystems."/media" = {
    device = "/dev/sda1";
    fsType = "ntfs";
    options = [
      "users"
      "nofail"
      "exec"
    ];
  };

  services = {
    # meilisearch.enable = true;
    open-webui.enable = true;

    jellyfin = {
      enable = true;
      openFirewall = true;
    };

    jellyseerr = {
      enable = true;
      openFirewall = true;
    };

    sonarr = {
      enable = true;
      openFirewall = true;
    };

    radarr = {
      enable = true;
      openFirewall = true;
    };

    prowlarr = {
      enable = true;
      openFirewall = true;
    };

    flaresolverr = {
      enable = true;
      openFirewall = true;
    };

    transmission = {
      enable = true;
      openFirewall = true;
      package = pkgs.transmission_4;
      settings = {
        download-dir = "/media/downloads/incomplete";
        incomplete-dir = "/media/downloads/incomplete";
        incomplete-dir-enabled = true;
      };
    };

    cloudflared = {
      enable = true;
      tunnels = {
        "f2b0a7d3-c143-493f-b7d8-93c76bf852df" = {
          credentialsFile = "/etc/cloudflared/f2b0a7d3-c143-493f-b7d8-93c76bf852df.json";
          default = "http_status:404";
          ingress = {
            "jellyfin.shmanju.org" = "http://localhost:8096";
            "jellyseerr.shmanju.org" = "http://localhost:5055";
            "photos.shmanju.org" = "http://localhost:2283";
          };
        };
      };
    };

    immich = {
      enable = true;
      openFirewall = true;
      host = "0.0.0.0";
      machine-learning.enable = true;
      mediaLocation = "/media/photos/";
    };

    ollama = {
      enable = true;
      host = "0.0.0.0";
      package = pkgs.ollama-cuda;
      loadModels = ["llama3.2:1b"];
      models = "/media/models/";
    };
  };
}
