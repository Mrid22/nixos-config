{pkgs}:
pkgs.writeShellScriptBin "rebuild" ''
  cd ~/nixos-config/
  ${pkgs.git}/bin/git diff
  ${pkgs.git}/bin/git add .
  main=$(${pkgs.gum}/bin/gum choose $(ls -d */) "typo")
  echo $main
  second=$(${pkgs.gum}/bin/gum choose $(ls -d ./"$main"*))
  ${pkgs.gum}/bin/gum confirm "Commit changes?" && git commit -m ""$main"/"second": ${pkgs.gum}/bin/gum input"
''
