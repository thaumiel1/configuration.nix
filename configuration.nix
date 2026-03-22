# Edit this configuration file to define what should be installed on
# your system.  Help is available in the configuration.nix(5) man page
# and in the NixOS manual (accessible by running ‘nixos-help’).

{ config, pkgs, ... }:

{
  imports = [
    # Include the results of the hardware scan.
    ./hardware-configuration.nix
  ];

  # Bootloader
  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;

  networking.hostName = "nixos";

  # Enable networking
  networking.networkmanager.enable = true;
  networking.firewall.enable = true;

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

  services.desktopManager.cosmic.enable = true;
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

  # Enable sound with pipewire
  services.pulseaudio.enable = false;
  security.rtkit.enable = true;
  services.pipewire = {
    enable = true;
    alsa.enable = true;
    alsa.support32Bit = true;
    pulse.enable = true;
  };

  # Enable touchpad support
  services.libinput.enable = true;

  # User account
  users.users.ocelot = {
    isNormalUser = true;
    description = "Ocelot";
    extraGroups = [
      "networkmanager"
      "wheel"
      "podman"
      "docker"
      "libvirtd"
      "audio"
      "video"
    ];
    packages = with pkgs; [
      #  thunderbird
    ];
    shell = pkgs.zsh;
  };

  # Enable nix flakes
  nix.settings.experimental-features = [
    "nix-command"
    "flakes"
  ];

  # Allow unfree packages
  nixpkgs.config.allowUnfree = true;

  environment.systemPackages = with pkgs; [
    claude-code
    nil
    nixd
    rustdesk
    opencode
    podman-desktop
    zulu
    zulu8
    zulu25
    nur.repos.charmbracelet.crush
    pywal16
    pure-prompt
    cider-2
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
    vscode # unfree
    helix
    vim
    neovim
    zed-editor # confirmed in nixpkgs since 24.11

    jetbrains-toolbox

    # --- Version control ---
    git
    github-cli
    gitkraken # unfree — confirmed in nixpkgs

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
    docker-compose
    virt-manager # GUI front-end for libvirtd (enabled above)

    # --- GPU Screen Recorder GUI ---
    gpu-screen-recorder-gtk

    # --- System & disk tools ---
    gparted
    btrfs-progs
    btrfs-assistant # GUI for snapper / btrfs — confirmed in nixpkgs
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
    bind # provides dig / nslookup
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

    # --- Graphics & creative ---
    gimp
    inkscape
    krita

    # --- Office & productivity ---
    libreoffice-qt6
    texlive.combined.scheme-full
    zathura
    typora # unfree

    # --- Notes & writing ---
    zettlr
    obsidian # unfree — confirmed in nixpkgs

    # --- Database tools ---
    dbeaver-bin # unfree — confirmed in nixpkgs

    # --- Wayland / compositor utilities ---

    wl-clipboard
    slurp
    grim
    flameshot
    satty # screenshot annotation tool

    # --- Misc CLI utilities ---
    yt-dlp

    # --- Dev extras ---
    just # command runner (like make, but simpler)
    stow # dotfile symlink manager
    cppcheck # static analysis for C/C++

    # Neovim plugins
    vimPlugins.nvim-treesitter
  ];

  programs.neovim = {
    enable = true;
    defaultEditor = true;
  };

  virtualisation.libvirtd.enable = true;

  virtualisation.spiceUSBRedirection.enable = true;

  virtualisation.docker.enable = true;

  virtualisation.podman = {
    enable = true;
    defaultNetwork.settings.dns_enabled = true;
  };

  services.flatpak.enable = true;

  programs.zsh = {
    enable = true;
    autosuggestions.enable = true;
    syntaxHighlighting.enable = true;
  };

  programs.steam = {
    enable = true;
    remotePlay.openFirewall = true;
    dedicatedServer.openFirewall = true;
  };
  hardware.steam-hardware.enable = true;

  services.tailscale.enable = true;

  fonts.packages = with pkgs; [
    nerd-fonts.jetbrains-mono
    nerd-fonts.meslo-lg
    nerd-fonts.fantasque-sans-mono
    dejavu_fonts
    liberation_ttf
    fira-sans
    source-han-sans # CJK support (Chinese / Japanese / Korean)
    noto-fonts
    noto-fonts-cjk-sans
  ];

  security.doas.enable = true;
  security.sudo.enable = false;
  security.doas.extraRules = [
    {
      users = [ "ocelot" ];
      # Optional, retains environment variables while running commands
      # e.g. retains your NIX_PATH when applying your config
      keepEnv = true;
      persist = true; # Optional, only require password verification a single time
    }
  ];

  # PAM limits for file descriptors
  security.pam.loginLimits = [
    {
      domain = "*";
      type = "soft";
      item = "nofile";
      value = "524288";
    }
    {
      domain = "*";
      type = "hard";
      item = "nofile";
      value = "1048576";
    }
  ];

  # Systemd user limits via extraConfig
  systemd.user.extraConfig = ''
    DefaultLimitNOFILE=524288
    DefaultLimitNOFILESoft=524288
  '';

  system.stateVersion = "25.11";

}
