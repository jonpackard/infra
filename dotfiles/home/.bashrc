export PATH="~/.local/bin:$PATH"
export infra="${HOME}/infra"

alias "nixed=sudo nano /etc/nixos/configuration.nix" # Edit NixOS config
alias "renix=sudo nixos-rebuild switch" # Re-configure NixOS
alias "synix=rsync -av /etc/nixos/ \"${infra}/nix/systems/$(hostname)/\"" # Clone nixos config to infra git repo
alias "ll=ls -lha"
