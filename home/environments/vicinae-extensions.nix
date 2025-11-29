{
  pkgs,
  inputs,
}: let
  base = inputs.vicinae.packages.${pkgs.stdenv.hostPlatform.system}.mkVicinaeExtension;

  arguments = {
    pname,
    rev,
    path,
  }:
    base {
      pname = pname;
      src =
        pkgs.fetchFromGitHub {
          owner = "vicinaehq";
          repo = "extensions";
          rev = rev;
          sha256 = "sha256-C2b6upygLE6xUP/cTSKZfVjMXOXOOqpP5Xmgb9r2dhA=";
        }
        + path;
    };

  template = [
    {
      pname = "bluetooth";
      rev = "ec7334e9bb636f4771580238bd3569b58dbce879";
      path = "/extensions/bluetooth";
    }
    {
      pname = "power-profiles";
      rev = "effaaa2a87227a3887a263b158b29dd06840932a";
      path = "/extensions/power-profile";
    }
    {
      pname = "nix";
      rev = "610459553a20cf510fa414844f0d094f14ae9643";
      path = "/extensions/nix";
    }
  ];
in
  map arguments template
