{ pkgs, ... }:

{
  # allow unfree packages
  nixpkgs.config.allowUnfree = true;

  # install steam
  programs.steam = {
    enable = true;
  };

  # ssh agent
  programs.ssh.startAgent = true;

  # zsh shell
  programs.zsh.enable = true;

  # dconf, needed for virt-manager
  programs.dconf.enable = true;

  # kde connect
  programs.kdeconnect.enable = true;

  # kde partition manager
  programs.partition-manager.enable = true;

  # Some programs need SUID wrappers, can be configured further or are
  # started in user sessions.
  # programs.mtr.enable = true;
  programs.gnupg.agent = {
    enable = true;
    # enableSSHSupport = true;
  };

  # add development docs
  # documentation.dev.enable = true;

  # fonts
  fonts = {
    fonts = with pkgs; [
      (nerdfonts.override { 
        fonts = [
          "FiraCode"
          "Hack"
          "Inconsolata"
          "JetBrainsMono"
          "NerdFontsSymbolsOnly"
          "Noto"
        ]; 
      })
      jetbrains-mono
      noto-fonts
      noto-fonts-cjk
      noto-fonts-emoji
      noto-fonts-extra
    ];
  };

  environment.systemPackages = with pkgs; [
    bspwm
    curl
    file
    gcc
    git
    htop
    killall
    lsb-release
    man-pages
    man-pages-posix
    neovim
    unrar
    unzip
    virt-manager
    wget
    xclip
    zsh
  ];
}
