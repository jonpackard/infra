export PATH="${HOME}/.local/bin:$PATH"
export infra="${HOME}/infra"

alias "nixed=sudo nano /etc/nixos/configuration.nix" # Edit NixOS config
alias "renix=sudo nixos-rebuild switch" # Re-configure NixOS
alias "synix=rsync -av /etc/nixos/ \"${infra}/nix/systems/$(hostname)/\"" # Clone nixos config to infra git repo
alias "ll=ls -lha"
alias "tmux=tmux a || tmux"
alias "prepvr=sudo setcap CAP_SYS_NICE+ep ~/.local/share/Steam/steamapps/common/SteamVR/bin/linux64/vrcompositor-launcher"
alias "xhostinit=xhost +si:localuser:$USER"
