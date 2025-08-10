{pkgs}:
pkgs.writeShellScriptBin "rebuild" ''
  ${pkgs.git}/bin/git diff
  ${pkgs.git}/bin/git add --all
  read -p "Commit message: " commitmsg
  ${pkgs.git}/bin/git commit --all --message "$commitmsg"
  ${pkgs.git}/bin/git push
  ${pkgs.nh}/bin/nh os switch
''
