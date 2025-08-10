{pkgs}:
pkgs.writeShellScriptBin "rebuild" ''
  ${pkgs.git}/bin/git diff
  read -p "Diff approved? (y/n): " -n 1 -r CONFIRM
  if [[ ! $CONFIRM =~ ^[Yy]$ ]]; then
    echo "Aborting."
    exit 1
  else
    echo
    ${pkgs.git}/bin/git add --all
    read -p "Commit message: " commitmsg
    ${pkgs.git}/bin/git commit --all --message "$commitmsg"
    ${pkgs.git}/bin/git push
    ${pkgs.nh}/bin/nh os switch
  fi
''
