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
  services = {
    jellyfin = {
      enable = true;
      openFirewall = true;
    };
    prowlarr = {
      enable = true;
      openFirewall = true;
    };
    sonarr = {
      enable = true;
      openFirewall = true;
    };
    flaresolverr = {
      enable = true;
      openFirewall = true;
    };
    immich = {
      enable = true;
      openFirewall = true;
      machine-learning.enable = true;
      mediaLocation = "/media/photos";
    };
    open-webui = {
      enable = true;
      openFirewall = true;
      environment = {
        ANONYMIZED_TELEMETRY = "False";
        DO_NOT_TRACK = "True";
        SCARF_NO_ANALYTICS = "True";
        OLLAMA_API_BASE_URL = "http://127.0.0.1:11434/api";
        OLLAMA_BASE_URL = "http://127.0.0.1:11434";
      };
    };
    ollama = {
      enable = true;
      openFirewall = true;
      loadModels = ["llama3.2:3b"];
      acceleration = "cuda";
    };
    transmission = {
      enable = true;
      openFirewall = true;
      settings = {
        download-dir = "/media/downloads";
        incomplete-dir = "/media/incomplete";
        incomplete-dir-enabled = true;
      };
    };
  };
}
