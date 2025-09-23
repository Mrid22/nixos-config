### Setup Instructions:

## Installation
#### **`configuration.nix`**
```nix
nix.settings.experimental-features = ["nix-command" "flakes"];
```
#### **`terminal`**
```bash
nix run nixpkgs#git -- clone https://github.com/Mrid22/nixos-config
sudo mv /etc/nixos/hardware-configuration.nix ~/nixos-config
sudo nixos-rebuild switch --flake nixos-config
```

## ssh for easier access
#### **`terminal`**
```bash
ssh-keygen
wl-copy < ~/.ssh/id_ed25519.pub
```
[Add the key to GitHub](https://www.github.com/Mrid22/settings/keys)

