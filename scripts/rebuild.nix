{pkgs}:
pkgs.writeShellScriptBin "rebuild" ''
  if [${pkgs.git}/bin/git diff --name-only="flake.lock"]
  then
  $comitmsg = "flake: update lockfile"
  echo $commitmsg
  fi
''
