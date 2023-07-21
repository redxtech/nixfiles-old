{ config, pkgs, ... }:
let
  mypkgs = import (fetchTarball "https://github.com/redxtech/nixpkgs/archive/master.tar.gz") { };
  py-pkgs = ps: with ps; [
    dbus-python
    pygobject3
    requests
  ];
in
{
  # group creation
  users.groups.plugdev = {};

  # default user options
  users.defaultUserShell = pkgs.zsh;

  users.users.gabe = {
    isNormalUser = true;
    description = "Gabe Dunn";
    extraGroups = [ "docker" "libvirtd" "networkmanager" "plugdev" "wheel" ];
    shell = pkgs.zsh;
    packages = with pkgs; with mypkgs;
    ## GUI APPS
    [
      beekeeper-studio-ultimate
      discord
      discord-ptb
      feh
      firefox
      flameshot
      # gamescope
      google-chrome
      kitty
      mpv
      networkmanagerapplet
      obsidian
      protonup-qt
      slack
      spotifywm
      xfce.thunar
      xfce.thunar-archive-plugin
      xfce.thunar-volman
      (vivaldi.override {
        proprietaryCodecs = true;
        enableWidevine = false;
        commandLineArgs = "--force-dark-mode";
      })
    ]
    ++
    ## cli apps
    [
      atool
      bat
      btop
      cpustat
      delta
      dex
      exa
      fasd
      fd
      ffmpeg
      ffmpegthumbnailer
      fnm
      fzf
      gh
      git
      hub
      jq
      lazygit
      mcfly
      mediainfo
      micro
      neofetch
      playerctl
      poetry
      ranger
      rclone
      ripgrep
      tealdeer
      tmux
      xfce.exo
      yadm
    ]
    ++
    ## wm
    [
      betterlockscreen
      dunst
      picom
      polkit_gnome
      polybar
      rofi
      sxhkd
      variety
    ]
    ++
    ## theme stuff
    [
      dracula-theme
      nordzy-cursor-theme
      papirus-icon-theme
      vimix-icon-theme
    ]
    ++
    ## gnome stuff
    [
      gnome.gpaste
      gnome3.gnome-tweaks
      gnomeExtensions.appindicator
      gnomeExtensions.blur-my-shell
      gnomeExtensions.caffeine
      gnomeExtensions.clipboard-indicator
      gnomeExtensions.docker
      gnomeExtensions.focus-changer
      gnomeExtensions.forge
      gnomeExtensions.gesture-improvements
      gnomeExtensions.grand-theft-focus
      gnomeExtensions.just-perfection
      gnomeExtensions.no-titlebar-when-maximized
      gnomeExtensions.openweather
      gnomeExtensions.pip-on-top
      gnomeExtensions.power-profile-switcher
      gnomeExtensions.switch-focus-type
      gnomeExtensions.system76-scheduler
      gnomeExtensions.workspace-indicator-2
      gnomeExtensions.vitals
      gnomeExtensions.x11-gestures
    ]
    ++
    ## dependencies
    [
      fontforge
      librsvg
      nodejs
      pyright
      (python3.withPackages py-pkgs )
      rust-analyzer
      sqlite
      w3m
      xclip
    ];
  };

}
