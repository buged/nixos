{ config, pkgs, ... }:

{
  imports =
    [ # Include the results of the hardware scan.
      ./hardware-configuration.nix
    ];

  # Use the systemd-boot EFI boot loader.
  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;

  networking.networkmanager.enable = true;
  networking.hostName = "nixos"; # Define your hostname.
  networking.wireless.enable = false;  # Enables wireless support via wpa_supplicant.
  networking.wireless.networks.".".pskRaw = "bfe5ba93ebcad0b18e2164cf5d5bb0e9f241bfb5af477164a95022477de02b3e";
  # networking.wireless.networks = {
  # "." = {                # SSID with no spaces or special characters
  #   psk = "bfe5ba93ebcad0b18e2164cf5d5bb0e9f241bfb5af477164a95022477de02b3e";
  # };
  # };

  # Set your time zone.
  time.timeZone = "America/Sao_Paulo";

  # The global useDHCP flag is deprecated, therefore explicitly set to false here.
  # Per-interface useDHCP will be mandatory in the future, so this generated config
  # replicates the default behaviour.
  networking.useDHCP = false;
  networking.interfaces.enp2s0.useDHCP = true;
  networking.interfaces.wlp3s0.useDHCP = true;
  
  # TODO: enable bluetooth if you use it on your MBP, otherwise I
  # just disable to save on battery.
  hardware.bluetooth.enable = true;

  # Configure network proxy if necessary
  # networking.proxy.default = "http://user:password@proxy:port/";
  # networking.proxy.noProxy = "127.0.0.1,localhost,internal.domain";

  # Select internationalisation properties.
  i18n.defaultLocale = "en_US.UTF-8";
  console = {
    font = "Lat2-Terminus16";
    keyMap = "br-abnt2";
  };

  # Enable the X11 windowing system.
  services.xserver.enable = true;


  # Enable the Plasma 5 Desktop Environment.
  services.xserver.displayManager.sddm.enable = true;
  services.xserver.desktopManager.plasma5.enable = true;
  
  # Configure keymap in X11
  services.xserver.layout = "us";
  services.xserver.xkbOptions = "eurosign:e";

  # Enable CUPS to print documents.
  services.printing.enable = true;
  services.printing.drivers = [ pkgs.epson-escpr ];
  services.avahi.enable = true; # for CUPS to automatically find the printer via Wi-Fi
  services.avahi.nssmdns = true; # for CUPS to automatically find the printer via Wi-Fi

  # Enable sound.
  sound.enable = true;
  hardware.pulseaudio.enable = true;

  # Update Intel CPU Microcode
  hardware.cpu.intel.updateMicrocode = true;

  # Enable touchpad support (enabled default in most desktopManager).
  services.xserver.libinput.enable = true;

  # Define a user account. Don't forget to set a password with ‘passwd’.
  users.users.us3r = {
    isNormalUser = true;
    extraGroups = [ "wheel" "networkmanager" ]; # Enable ‘sudo’ for the user.
  };

  # List packages installed in system profile. To search, run:
  # $ nix search wget
  environment.systemPackages = with pkgs; [
  # Do not forget to add an editor to edit configuration.nix! The Nano editor is also installed by default.
    
    # generally useful tools
    curl
    git
    lshw
    neofetch
    # numlockx
    python310
    libsForQt5.ark
    killall
    xorg.xkill
    duf                  # disk usage/free utility
    # simple-scan          # scanner gui
    # simplescreenrecorder # screen recorder gui
    xclip # Tool to access the X clipboard from a console application
    neovim
    
    # sys tools
    wget
    htop
    
    # TODO:
    vim_configurable
    p7zip
    qbittorrent
    flameshot
    libreoffice
    vlc
    mpv
    youtube-dl
    anydesk
    atom
    freetube
    inkscape
    libsForQt5.kdeconnect-kde
    zoom-us
    teams
    
    # browser
    firefox
    chromium
    
    # Printing
    # Drivers Epson L3250
    epson-escpr
    epson-escpr2
    
    # Fun
    # cmatrix
   
    # Research before install
    # pipewire
    # wayland
    
  ];
  
  # Allowing nonfree applications
  # nixpkgs.config.allowUnfree = true;
  nixpkgs.config.allowUnfreePredicate = (pkg: builtins.elem
    pkg.pname [
      "anydesk"
      "zoom"
      "teams"
    ]
  );
  
  # System upgrade automatically
  system.autoUpgrade.enable = true; 
  system.autoUpgrade.allowReboot = false; # if true, restarts. if false, it runs nixos-rebuild switch. 
  
  # Enable KDE Connect
  programs.kdeconnect.enable = true;
  
  # Some programs need SUID wrappers, can be configured further or are
  # started in user sessions.
  # programs.mtr.enable = true;
  # programs.gnupg.agent = {
  #   enable = true;
  #   enableSSHSupport = true;
  # };

  # List services that you want to enable:

  # Enable the OpenSSH daemon.
  # services.openssh.enable = true;

  # Open ports in the firewall.
  # networking.firewall.allowedTCPPorts = [ ... ];
  # networking.firewall.allowedUDPPorts = [ ... ];
  # Or disable the firewall altogether.
  # networking.firewall.enable = false;

  # This value determines the NixOS release from which the default
  # settings for stateful data, like file locations and database versions
  # on your system were taken. It‘s perfectly fine and recommended to leave
  # this value at the release version of the first install of this system.
  # Before changing this value read the documentation for this option
  # (e.g. man configuration.nix or on https://nixos.org/nixos/options.html).
  system.stateVersion = "21.11"; # Did you read the comment?

}
