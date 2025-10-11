### Setup Instructions:

## Installation

#### **`configuration.nix`**

```nix
nix.settings.experimental-features = ["nix-command" "flakes"];
```

#### **`terminal`**

```bash
cd
nix run nixpkgs#git -- clone https://github.com/Mrid22/nixos-config
sudo mv /etc/nixos/hardware-configuration.nix ~/nixos-config
sudo nixos-rebuild switch --flake ~/nixos-config
```

## ssh for easier access

#### **`terminal`**

```bash
ssh-keygen
wl-copy < ~/.ssh/id_ed25519.pub
git remote set-url origin git@github.com:Mrid22/nixos-config.git
xdg-open https://github.com/settings/keys
```

[Add the key to GitHub](https://www.github.com/settings/keys)

## Update system and git history

#### **`terminal`**

```bash
nix flake update
gaa
gcam "update system"
gp
nh os switch
```

## Setup tailscale

#### **`terminal`**

```bash
sudo tailscale login
sudo tailscale up --advertise-exit-node
```
