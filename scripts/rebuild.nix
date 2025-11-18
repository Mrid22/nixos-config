{pkgs}:
pkgs.writeShellScriptBin "rebuild" ''
  main=$(${pkgs.gum}/bin/gum choose "home" "config")
  echo $main
  if [[ "$main" == "config" ]]; then
    second=$(${pkgs.gum}/bin/gum choose "gaming" "system" "apps")
  elif [[ "$main" == "home" ]]; then
    second=$(${pkgs.gum}/bin/gum choose "de" "terminal" "zen" "nvf")
  fi
  ${pkgs.gum}/bin/gum confirm "Commit changes?" && git commit -m $main -m ">" - "$second"
''
