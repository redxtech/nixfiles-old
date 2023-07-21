{ config, pkgs, ... }:

{
  # xorg related settings
  services.xserver = {
    enable = true;
    layout = "us";
    xkbVariant = "";
    # xkbOptions = "ctrl:nocaps,shift:both_capslock";

    displayManager.gdm.enable = true;
    # displayManager.sddm.enable = true;
    desktopManager.gnome.enable = true;
    displayManager.defaultSession = "none+bspwm";
    windowManager.bspwm.enable = true;

    libinput.enable = true;
    # libinput.touchpad.disableWhileTyping = true;
  };

  virtualisation = {
    # enable libvirtd
    libvirtd = {
      enable = true;
      qemu.ovmf.enable = true;
      qemu.ovmf.packages = [ pkgs.OVMFFull.fd ];
      qemu.swtpm.enable = true;
      onBoot = "ignore";
      qemu.verbatimConfig = ''
      user = "gabe"
      '';
    };

    # enable docker
    docker.enable = true;
  };

  # enable sound with pipewire.
  sound.enable = true;
  hardware.pulseaudio.enable = false;
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

  # flatpak
  services.flatpak.enable = true;

  # enable the OpenSSH daemon.
  services.openssh.enable = true;

  # enable bluetooth
  hardware.bluetooth.enable = true;
  services.blueman.enable = true;

  # enable CUPS to print documents.
  services.printing.enable = true;

  # dbus packages
  services.dbus.packages = with pkgs; [ python310Packages.dbus-python ];

# ensure gnome settings daemon is running
  services.udev = {
    packages = with pkgs; [ gnome.gnome-settings-daemon ];
    # udev rules for moonlander flashing
    extraRules = ''
      # Rules for Oryx web flashing and live training
      KERNEL=="hidraw*", ATTRS{idVendor}=="16c0", MODE="0664", GROUP="plugdev"
      KERNEL=="hidraw*", ATTRS{idVendor}=="3297", MODE="0664", GROUP="plugdev"

      # Wally Flashing rules for the Moonlander and Planck EZ
      SUBSYSTEMS=="usb", ATTRS{idVendor}=="0483", ATTRS{idProduct}=="df11",     MODE:="0666",     SYMLINK+="stm32_dfu"
    '';
  };

  # enable system76 scheduler
  # services.system76-scheduler.enable = true;

  # enable networking
  networking = {
    networkmanager.enable = true;
    # wireless.enable = true; # enables wireless support via wpa_supplicant.

    # open ports in the firewall.
    firewall = {
      allowedTCPPorts = [ 22 443 ];
      allowedUDPPorts = [ 22 443 ];

      # if packets are still dropped, they will show up in dmesg
      logReversePathDrops = true;

      # wireguard trips rpfilter up
      /*
      extraCommands = ''
        ip46tables -t mangle -I nixos-fw-rpfilter -p udp -m udp --sport 51820 -j RETURN
        ip46tables -t mangle -I nixos-fw-rpfilter -p udp -m udp --dport 51820 -j RETURN
      '';
      extraStopCommands = ''
        ip46tables -t mangle -D nixos-fw-rpfilter -p udp -m udp --sport 51820 -j RETURN || true
        ip46tables -t mangle -D nixos-fw-rpfilter -p udp -m udp --dport 51820 -j RETURN || true
      '';
      */
    };
  };
}
