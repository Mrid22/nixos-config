# Installation

```nix
nix.settings.extraExperimentalFetures = ["nix-command" "flakes"];
```

```bash
git clone https://github.com/nixos-config
cd nixos-config
sudo mv /etc/hardware-configuration.nix .
nix flake update
sudo nixos-rebuild switch --flake .
```
