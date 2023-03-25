export PATH="~/.local/bin:$PATH"

alias "nixed=sudo nano /etc/nixos/configuration.nix" # Edit NixOS config
alias "renix=sudo nixos-rebuild switch" # Re-configure NixOS
alias "synix=rsync -av /etc/nixos/ nix/systems/tower-nixos/" # Clone nixos config to infra git repo
alias "ll=ls -lha"
