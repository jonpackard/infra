# Edit this configuration file to define what should be installed on
# your system.  Help is available in the configuration.nix(5) man page
# and in the NixOS manual (accessible by running ‘nixos-help’).

{ config, pkgs, ... }:

{
  imports =
    [ # Include the results of the hardware scan.
      ./hardware-configuration.nix
      #./python3.nix not working yet
    ];

  # Use the systemd-boot EFI boot loader.
  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;

  # networking.hostName = "nixos"; # Define your hostname.
  # Pick only one of the below networking options.
  # networking.wireless.enable = true;  # Enables wireless support via wpa_supplicant.
  # networking.networkmanager.enable = true;  # Easiest to use and most distros use this by default.

  # Set your time zone.
  time.timeZone = "America/New_York";

  # Configure network proxy if necessary
  # networking.proxy.default = "http://user:password@proxy:port/";
  # networking.proxy.noProxy = "127.0.0.1,localhost,internal.domain";

  # Select internationalisation properties.
  i18n.defaultLocale = "en_US.UTF-8";
  # console = {
  #  font = "Lat2-Terminus16";
  #  keyMap = "us";
  #  useXkbConfig = true; # use xkbOptions in tty.
  # };

  # Enable the X11 windowing system.
  services.xserver.enable = true;

  # Enable KDE Plasma desktop environment
  services.xserver.desktopManager.plasma5.enable = true;
  

  # Configure keymap in X11
  # services.xserver.layout = "us";
  # services.xserver.xkbOptions = {
  #   "eurosign:e";
  #   "caps:escape" # map caps to escape.
  # };

  # Enable CUPS to print documents.
  services.printing.enable = true;

  # Enable sound.
  sound.enable = true;
  hardware.pulseaudio.enable = true;

  # Enable touchpad support (enabled default in most desktopManager).
  # services.xserver.libinput.enable = true;

  # Define a user account. Don't forget to set a password with ‘passwd’.
  users.users.jon = {
    isNormalUser = true;
    extraGroups = [ "wheel" "steam" "networkmanager" "docker" ]; # Enable ‘sudo’ for the user.
    packages = with pkgs; [
      firefox
      bitwarden
    ];
  };

  # Allow "unfree" packages.
  nixpkgs.config.allowUnfree = true;

  environment.systemPackages = with pkgs; [
    vim # Do not forget to add an editor to edit configuration.nix! The Nano editor is also installed by default.
    wget
    tmux
    #podman
    #podman-tui
    #podman-compose # need newer version from github
    cni
    cni-plugins
    btrfs-progs
    iotop
    bitwarden-cli
    anydesk
    git
    git-secrets
    OVMF
    virt-manager
    qemu
    pciutils
    notepadqq
    #iproute2
    nmap
    docker
    docker-compose
    #remmina
    wol
    linuxKernel.packages.linux_libre.nvidia_x11_production_open
  ];

  # Some programs need SUID wrappers, can be configured further or are
  # started in user sessions.
  # programs.mtr.enable = true;
  # programs.gnupg.agent = {
  #   enable = true;
  #   enableSSHSupport = true;
  # };

  # List services that you want to enable:

  # Enable Flatpak
  services.flatpak.enable = true;

  # Enable the OpenSSH daemon.
  services.openssh.enable = true;
  services.openssh.forwardX11 = true;

  # Open ports in the firewall.
  networking.firewall.allowedTCPPorts = [ 7070 8581 51489 ];
  networking.firewall.allowedUDPPorts = [ 7070 8581 51489 ];
  # Or disable the firewall altogether.
  networking.firewall.enable = false;

  # Copy the NixOS configuration file and link it from the resulting system
  # (/run/current-system/configuration.nix). This is useful in case you
  # accidentally delete configuration.nix.
  system.copySystemConfiguration = true;

  # This value determines the NixOS release from which the default
  # settings for stateful data, like file locations and database versions
  # on your system were taken. It‘s perfectly fine and recommended to leave
  # this value at the release version of the first install of this system.
  # Before changing this value read the documentation for this option
  # (e.g. man configuration.nix or on https://nixos.org/nixos/options.html).
  system.stateVersion = "22.11"; # Did you read the comment?

  nix.extraOptions = ''
    experimental-features = nix-command flakes
    '';

  virtualisation = {
    docker = {
      enable = true;
      extraOptions = "--ip=192.168.1.29";

      # Create a `docker` alias for podman, to use it as a drop-in replacement
      # dockerCompat = true;

      # Required for containers under podman-compose to be able to talk to each other.
      # defaultNetwork.settings.dns_enabled = true;
    };
  };

  programs.steam = {
    enable = true;
    remotePlay.openFirewall = true; # Open ports in the firewall for Steam Remote Play
    dedicatedServer.openFirewall = true; # Open ports in the firewall for Source Dedicated Server
  };

  services.xserver.videoDrivers = [ "nvidia" ];
  #services.xserver.videoDrivers = [ "nvidia" "displaylink" ];
  hardware.opengl.enable = true;
  hardware.nvidia.open = true;

  # Optionally, you may need to select the appropriate driver version for your specific GPU.
  hardware.nvidia.package = config.boot.kernelPackages.nvidiaPackages.stable;

  # nvidia-drm.modeset=1 is required for some wayland compositors, e.g. sway
  hardware.nvidia.modesetting.enable = true;

  ## Preparing for PCI passthrough ##
  ## ... for now disabling the 2nd NVidia GPU. Ref: https://gist.github.com/RyanCargan/7326349eb>
  ## Unplugged the 2nd nvidia GPU, was causing "no video boot fail" issues. Might be no good.

  #boot.kernelParams = [ "intel_iommu=on" ];
  #boot.kernelParams = [ "amd_iommu=on" ];

  # These modules are required for PCI passthrough, and must come before early modesetting stuff
  #boot.kernelModules = [ "vfio" "vfio_iommu_type1" "vfio_pci" "vfio_virqfd" ];
  
  # CHANGE: Don't forget to put your own PCI IDs here
  #boot.extraModprobeConfig ="options vfio-pci ids=10de:1380,10de:0fbc";


  ## NETWORKING ##
  
  networking = {
    
    enableIPv6 = false;

    #Enable networkManager
    #networkmanager.enable = true;

    #defaultGateway = "10.84.1.254";
    nameservers = [ "1.1.1.1" ];
    
    #firewall.enable = false;

    vlans = {
      #lan = {
      #  interface = "enp5s0";
      #  id = 84;
      #};
      guest = {
        interface = "enp5s0";
        id = 1;
      };
    };

    interfaces = {
      #enp1s0.useDHCP = true;
      #enp3s0.useDHCP = false;
      #enp4s0.useDHCP = false;
      enp5s0 = {
        useDHCP = true;
      #  ipv4.addresses = [{
      #      address = "10.84.1.8";
      #      prefixLength = 24;
      #  }];
      };
      #lan = {
      #  ipv4.addresses = [{
      #    address = "10.84.1.8";
      #    prefixLength = 24;
      #  }];
      #};
      guest = {
        useDHCP = true;
        #ipv4.addresses = [{
        #  address = "192.168.1.253";
        #  prefixLength = 24;
        #}];
      };
    };
  };

}

