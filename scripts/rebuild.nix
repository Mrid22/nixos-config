{pkgs}:
pkgs.writeShellScriptBin "rebuild" ''
  ${pkgs.gum}/bin/gum
''
