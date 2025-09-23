### Setup Instructions:
#### **`configuration.nix`**
```nix
nix.settings.experimental-features = ["nix-command" "flakes"];
```
#### **`terminal`**
```bash
nix run nixpkgs#git -- clone https://github.com/Mrid22/nixos-config
sudo nixos-rebuild switch --flake nixos-config
```

