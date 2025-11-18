{pkgs}:
pkgs.writeShellScriptBin "rebuild" ''
  ${pkgs.git}/bin/git add .
  main=$(${pkgs.gum}/bin/gum choose $(ls -d */) "typo")
  echo $main
  second=$(${pkgs.gum}/bin/gum choose $(ls -d ./$"main"*/))
  ${pkgs.gum}/bin/gum confirm "Commit changes?" && git commit -m $main -m ">" -m "$second"
''
