# Edit this configuration file to define what should be installed on
# your system.  Help is available in the configuration.nix(5) man page
# and in the NixOS manual (accessible by running ‘nixos-help’).

{ config, pkgs, ... }:

{
  imports =
    [ # Include the results of the hardware scan.
      ./hardware-configuration.nix
    ];

  # Bootloader.
  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;

  networking.hostName = "nixos"; # Define your hostname.
  # networking.wireless.enable = true;  # Enables wireless support via wpa_supplicant.

  # Configure network proxy if necessary
  # networking.proxy.default = "http://user:password@proxy:port/";
  # networking.proxy.noProxy = "127.0.0.1,localhost,internal.domain";

  # Enable networking
  networking.networkmanager.enable = true;
  networking.firewall.enable   = true;

  # Set your time zone.
  time.timeZone = "Europe/London";

  # Select internationalisation properties.
  i18n.defaultLocale = "en_GB.UTF-8";

  i18n.extraLocaleSettings = {
    LC_ADDRESS = "en_GB.UTF-8";
    LC_IDENTIFICATION = "en_GB.UTF-8";
    LC_MEASUREMENT = "en_GB.UTF-8";
    LC_MONETARY = "en_GB.UTF-8";
    LC_NAME = "en_GB.UTF-8";
    LC_NUMERIC = "en_GB.UTF-8";
    LC_PAPER = "en_GB.UTF-8";
    LC_TELEPHONE = "en_GB.UTF-8";
    LC_TIME = "en_GB.UTF-8";
  };

  # Enable the X11 windowing system.
  services.xserver.enable = true;

  services.desktopManager.cosmic.enable        = true;
  services.displayManager.cosmic-greeter.enable = true;

  services.desktopManager.cosmic.xwayland.enable = true;
  # Configure keymap in X11
  services.xserver.xkb = {
    layout = "gb";
    variant = "";
  };

  # Configure console keymap
  console.keyMap = "uk";

  # Enable CUPS to print documents.
  services.printing.enable = true;

  # Enable sound with pipewire.
  services.pulseaudio.enable = false;
  security.rtkit.enable = true;
  services.pipewire = {
    enable = true;
    alsa.enable = true;
    alsa.support32Bit = true;
    pulse.enable = true;
    # If you want to use JACK applications, uncomment this
    #jack.enable = true;

    # use the example session manager (no others are packaged yet so this is enabled by default,
    # no need to redefine it in your config for now)
    #media-session.enable = true;
  };

  # Enable touchpad support (enabled default in most desktopManager).
  services.libinput.enable = true;

  # Define a user account. Don't forget to set a password with ‘passwd’.
  users.users.ocelot = {
    isNormalUser = true;
    description = "Ocelot";
    extraGroups = [ "networkmanager" "wheel" "podman" "docker" "libvirtd" "audio" "video"];
    packages = with pkgs; [
    #  thunderbird
    ];
    shell = pkgs.zsh;
  };

  # Enable nix flakes
  nix.settings.experimental-features = [ "nix-command" "flakes" ];

  # Install firefox.
  programs.firefox.enable = true;

  # Allow unfree packages
  nixpkgs.config.allowUnfree = true;

  # List packages installed in system profile. To search, run:
  # $ nix search wget
  environment.systemPackages = with pkgs; [
    claude-code
    nil
    nixd
    opencode
    podman-desktop
    zulu
    zulu8
    zulu25
    nur.repos.charmbracelet.crush
    pywal16
    vscode
    pure-prompt
    cider-2
    fastfetch
    ast-grep
    luajitPackages.luarocks_bootstrap
    php85Packages.composer
    php85
    bash
    # --- Terminals ---
    kitty

    # --- Shells & CLI tools ---
    starship
    fzf
    bat
    eza
    fd
    ripgrep
    zoxide
    lazygit
    tmux
    zellij
    yazi
    fastfetch
    btop
    bottom
    tealdeer
    gum
    jq
    sd
    duf
    tree

    # --- Browsers ---
    google-chrome

    # --- Communication ---
    discord
    telegram-desktop


    # --- Password manager ---
    bitwarden-desktop

    # --- Editors & IDEs ---
    vscode              # unfree
    helix
    vim
    neovim
    zed-editor          # confirmed in nixpkgs since 24.11

    jetbrains-toolbox

    # --- Version control ---
    git
    github-cli
    gitkraken           # unfree — confirmed in nixpkgs

    # --- Build tools ---
    gcc
    clang
    cmake
    ninja
    gnumake
    pkg-config

    # --- Languages & runtimes ---
    rustup
    go
    python3
    nodejs
    bun
    deno
    ruby
    julia
    jdk21
    dotnet-sdk
    rust-analyzer

    # --- Python tooling ---
    uv
    ruff

    # --- Container & VM tools ---
    distrobox
    virt-manager        # GUI front-end for libvirtd (enabled above)

    # --- GPU Screen Recorder GUI ---
    gpu-screen-recorder-gtk

    # --- System & disk tools ---
    gparted
    btrfs-progs
    btrfs-assistant     # GUI for snapper / btrfs — confirmed in nixpkgs
    snapper
    smartmontools
    gptfdisk
    dosfstools
    e2fsprogs
    exfatprogs
    ntfs3g
    inxi
    hwinfo

    # --- Networking tools ---
    wget
    curl
    rsync
    nmap
    bind                # provides dig / nslookup
    iproute2

    # --- File tools ---
    p7zip
    unrar
    unzip
    zip
    file

    # --- Media ---
    ffmpeg
    mpv
    vlc
    imagemagick
    blender
    obs-studio
    strawberry
               # unfree

    # --- Graphics & creative ---
    gimp
    inkscape
    krita

    # --- Office & productivity ---
    libreoffice-qt6
    texlive.combined.scheme-full
    zathura
    typora              # unfree

    # --- Notes & writing ---
    zettlr
    obsidian            # unfree — confirmed in nixpkgs

    # --- Database tools ---
    dbeaver-bin         # unfree — confirmed in nixpkgs

    # --- Wayland / compositor utilities ---

    wl-clipboard
    slurp
    grim
    flameshot
    satty               # screenshot annotation tool

    # --- Misc CLI utilities ---
    yt-dlp

    # --- Dev extras ---
    just                # command runner (like make, but simpler)
    stow                # dotfile symlink manager
    cppcheck            # static analysis for C/C++

    # Neovim plugins
    vimPlugins.nvim-treesitter
  ];


  programs.neovim = {
   enable = true;
   defaultEditor = true;
  };

  # Some programs need SUID wrappers, can be configured further or are
  # started in user sessions.
  # programs.mtr.enable = true;
  # programs.gnupg.agent = {
  #   enable = true;
  #   enableSSHSupport = true;
  # };
  virtualisation.libvirtd.enable = true;

  virtualisation.spiceUSBRedirection.enable = true;

  virtualisation.podman = {
    enable       = true;
    dockerCompat = true; # lets you type `docker` as an alias for podman
    defaultNetwork.settings.dns_enabled = true;
  };

  services.flatpak.enable = true;

  programs.zsh = {
    enable                    = true;
    autosuggestions.enable    = true;
    syntaxHighlighting.enable = true;
  };

  programs.steam = {
    enable                       = true;
    remotePlay.openFirewall      = true;
    dedicatedServer.openFirewall = true;
  };
  hardware.steam-hardware.enable = true;

  # List services that you want to enable:
    services.tailscale.enable = true;

  fonts.packages = with pkgs; [
    nerd-fonts.jetbrains-mono
    nerd-fonts.meslo-lg
    nerd-fonts.fantasque-sans-mono
    dejavu_fonts
    liberation_ttf
    fira-sans
    source-han-sans     # CJK support (Chinese / Japanese / Korean)
    noto-fonts
    noto-fonts-cjk-sans
  ];

  security.doas.enable = true;
  security.sudo.enable = false;
  security.doas.extraRules = [{
    users = ["ocelot"];
    # Optional, retains environment variables while running commands
    # e.g. retains your NIX_PATH when applying your config
    keepEnv = true;
    persist = true;  # Optional, only require password verification a single time
  }];


  # Enable the OpenSSH daemon.
  # services.openssh.enable = true;


  # This value determines the NixOS release from which the default
  # settings for stateful data, like file locations and database versions
  # on your system were taken. It‘s perfectly fine and recommended to leave
  # this value at the release version of the first install of this system.
  # Before changing this value read the documentation for this option
  # (e.g. man configuration.nix or on https://nixos.org/nixos/options.html).
  system.stateVersion = "25.11"; # Did you read the comment?

}
