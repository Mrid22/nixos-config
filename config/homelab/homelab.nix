{
  config,
  pkgs,
  inputs,
  lib,
  ...
}: {
  imports = [
    inputs.selfhostblocks.nixosModules.default
    inputs.sops-nix.nixosModules.default
    inputs.selfhostblocks.nixosModules.sops
  ];
  sops = {
    defaultSopsFile = ./secrets.yaml;
    defaultSopsFormat = "yaml";
    age.keyFile = "/home/mridula/.config/sops/age/keys.txt";
  };
  services = {
    duckdns = {
      enable = true;
      domains = ["mridulagarwal"];
      tokenFile = "/home/mridula/auth.txt";
    };
  };
  shb.home-assistant = {
    enable = true;
    subdomain = "ha";
    domain = "mridulagarwal.duckdns.org";

    config = {
      name = "SelfHostBlocks - Home Assistant";
      country.source = config.shb.sops.secret."home-assistant/country".result.path;
      latitude.source = config.shb.sops.secret."home-assistant/latitude".result.path;
      longitude.source = config.shb.sops.secret."home-assistant/longitude".result.path;
      time_zone.source = config.shb.sops.secret."home-assistant/time_zone".result.path;
      unit_system = "metric";
    };
  };

  shb.sops.secret."home-assistant/country".request = {
    mode = "0440";
    owner = "hass";
    group = "hass";
    restartUnits = ["home-assistant.service"];
  };
  shb.sops.secret."home-assistant/latitude".request = {
    mode = "0440";
    owner = "hass";
    group = "hass";
    restartUnits = ["home-assistant.service"];
  };
  shb.sops.secret."home-assistant/longitude".request = {
    mode = "0440";
    owner = "hass";
    group = "hass";
    restartUnits = ["home-assistant.service"];
  };
  shb.sops.secret."home-assistant/time_zone".request = {
    mode = "0440";
    owner = "hass";
    group = "hass";
    restartUnits = ["home-assistant.service"];
  };
}
