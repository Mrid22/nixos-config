{pkgs}:
pkgs.writeShellScriptBin "rebuild" ''
  ${pkgs.gum}/bin/gum filter $(${pkgs.git}/bin/git diff --name-only)
''
