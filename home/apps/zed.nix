{
  config,
  pkgs,
  inputs,
  ...
}: {
  programs.zed-editor = {
    enable = true;
    extensions = ["nix" "html"];
    userSettings = {
      features = {
        copilot = false;
      };
      telemetry = {
        metrics = false;
      };
      vim_mode = true;
      ui_font_size = 16;
    };
  };
}
