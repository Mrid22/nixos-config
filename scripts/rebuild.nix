{pkgs}:
pkgs.writeShellScriptBin "rebuild" ''
  ${pkgs.git}/bin/git add .
  main=$(${pkgs.gum}/bin/gum choose $(ls -d */) "typo")
  echo $main
  if [[ "$main" == "config" ]]; then
    second=$(${pkgs.gum}/bin/gum choose $(ls -d ./config/*/))
  elif [[ "$main" == "home" ]]; then
    second=$(${pkgs.gum}/bin/gum choose $(ls -d ./home/*/*))
  fi
  ${pkgs.gum}/bin/gum confirm "Commit changes?" && git commit -m $main -m ">" -m "$second"
''
