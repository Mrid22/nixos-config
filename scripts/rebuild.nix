{pkgs}:
pkgs.writeShellScriptBin "rebuild" ''
  main=${pkgs.gum}/bin/gum choose "home" "config"
  if main == "config":
  then
    ${pkgs.gum}/bin/gum choose "gaming"
  fi
''
