{
config,
pkgs,
inputs,
...
}:{
  programs.git = {
    enable = true;
    userName = "Mrid22";
    userEmail = "mridulaga@outlook.com";
    delta.enable = true;
    extraConfig = {
      init.defaultBranch = "main";
    };
  };
}
