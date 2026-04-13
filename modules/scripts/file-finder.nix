{inputs, ...}: {
  perSystem = {pkgs, ...}: let
    wrappedpkgs = inputs.self.packages.${pkgs.stdenv.hostPlatform.system};
  in {
    packages.file-finder = pkgs.writeShellScriptBin "file-finder" ''
      ff() {
        local selected
        selected=$(${pkgs.fzf}/bin/fzf --preview="${pkgs.bat}/bin/bat --color=always {}") || return
        case "$(${pkgs.file}/bin/file --brief --mime-type "$selected")" in
          text/*|application/x-empty|inode/x-empty)
            ${wrappedpkgs.default}/bin/nvim "$selected"
            ;;
          *)
            ${pkgs.xdg-utils}/bin/xdg-open "$selected"
            ;;
        esac
      }
      ff
    '';
  };
}
