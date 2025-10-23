{
  config,
  pkgs,
  inputs,
  ...
}: {
  fileSystems."/media" = {
    device = "/dev/sda1";
    fsType = "ntfs";
    options = [
      "users"
      "nofail"
    ];
  };
  system.activationScripts.setupFolders = ''
    mkdir -p /media/downloads/downloads
    mkdir -p /media/downloads/downloads/tv-sonarr
    mkdir -p /media/downloads/incomplete
    mkdir -p /media/tv
    mkdir -p /media/photos
    mkdir -p /media/home
  '';
  virtualisation = {
    backend = "docker";
    containers.homeassistant = {
      volumes = [
        "home-assistant:/config"
        "/var/run/dbus:/run/dbus:ro"
      ];
      environment.TZ = "Europe/Amsterdam";
      image = "ghcr.io/home-assistant/home-assistant:stable";
      extraOptions = [
        "--network=host"
      ];
    };
  };
  services = {
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
    jellyfin = {
      enable = true;
      openFirewall = true;
    };
    jellyseerr = {
      enable = true;
      openFirewall = true;
    };
    tailscale = {
      enable = true;
      openFirewall = true;
      disableTaildrop = true;
      useRoutingFeatures = "both";
    };
    immich = {
      enable = true;
      openFirewall = true;
      host = "0.0.0.0";
      mediaLocation = "/media/photos";
      machine-learning.enable = true;
    };
    transmission = {
      enable = true;
      package = pkgs.transmission_4;
      settings = {
        download-dir = "/media/downloads/downloads";
        incomplete-dir = "/media/downloads/incomplete";
        incomplete-dir-enabled = true;
      };
    };
    ollama = {
      enable = true;
      openFirewall = true;
      acceleration = "cuda";
      loadModels = ["llama3.2:3b"];
    };
    open-webui = {
      enable = true;
      openFirewall = true;
      host = "0.0.0.0";
    };
    # home-assistant = {
    #   enable = true;
    #   extraComponents = [
    #     "analytics"
    #     "google_translate"
    #     "met"
    #     "radio_browser"
    #     "shopping_list"
    #     "isal"
    #   ];
    #   config = {
    #     default_config = {};
    #   };
    # };
  };
}
