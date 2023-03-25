# Edit this configuration file to define what should be installed on
# your system.  Help is available in the configuration.nix(5) man page
# and in the NixOS manual (accessible by running ‘nixos-help’).

{ config, pkgs, ... }:

{
  imports =
    [ # Include the results of the hardware scan.
      ./hardware-configuration.nix
      ./nextcloud.nix
      ./jellyfin.nix
    ];

  # Use the systemd-boot EFI boot loader.
  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;

  # Set your time zone.
  time.timeZone = "America/New_York";

  # The global useDHCP flag is deprecated, therefore explicitly set to false here.
  # Per-interface useDHCP will be mandatory in the future, so this generated config
  # replicates the default behaviour.
  networking.useDHCP = false;
  #networking.interfaces.enp1s0.useDHCP = true;
  networking.interfaces.enp1s0.ipv4.addresses = [ {
    address = "10.84.1.10";
    prefixLength = 24;
  } ];
  networking.defaultGateway = "10.84.1.254";
  networking.nameservers = [ "1.1.1.1" ];
  networking.hostName = "nixos-svr"; # Define your hostname.

  # Select internationalisation properties.
  i18n.defaultLocale = "en_US.UTF-8";
  console = {
    font = "Lat2-Terminus16";
    keyMap = "us";
  };

  # Define a user account. Don't forget to set a password with ‘passwd’.
  users.users.jon = {
    isNormalUser = true;
    extraGroups = [ "wheel" ]; # Enable ‘sudo’ for the user.
  };

  # List packages installed in system profile. To search, run:
  # $ nix search wget
  environment.systemPackages = with pkgs; [
    # These are all optional and not required for normal function.
    tmux
    nmap
    dig
    git
    cryptsetup
  ];

  # List services that you want to enable:

  # Enable the OpenSSH daemon.
  services.openssh.enable = true;
  services.openssh.extraConfig = ''
    HostKeyAlgorithms ssh-rsa,ecdsa-sha2-nistp256,ssh-ed25519
    PubkeyAcceptedAlgorithms ssh-rsa,ecdsa-sha2-nistp256,ssh-ed25519
    '';

  # Optional: Mount NFS share
    fileSystems."/mnt/library" = {
      device = "10.84.1.8:/mnt/user/library";
      fsType = "nfs";
      options = [ "x-systemd.automount" "noauto" ]; # lazy mounting
    };

  # This value determines the NixOS release from which the default
  # settings for stateful data, like file locations and database versions
  # on your system were taken. It‘s perfectly fine and recommended to leave
  # this value at the release version of the first install of this system.
  # Before changing this value read the documentation for this option
  # (e.g. man configuration.nix or on https://nixos.org/nixos/options.html).
  system.stateVersion = "22.05"; # Did you read the comment?

  services.cron.systemCronJobs = [
    "* * * * *  jon sleep 00; /home/jon/checkworkpc.sh"
    "* * * * *  jon sleep 15; /home/jon/checkworkpc.sh"
    "* * * * *  jon sleep 30; /home/jon/checkworkpc.sh"
    "* * * * *  jon sleep 45; /home/jon/checkworkpc.sh"
  ];    

}


