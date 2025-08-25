{pkgs}:
pkgs.writeShellScriptBin "update" ''
    nix flake update
    ${pkgs.git}/bin/git add --all
    ${pkgs.git}/bin/git commit --all --message "Update"
    ${pkgs.git}/bin/git push
    ${pkgs.nh}/bin/nh os switch
  fi
''
