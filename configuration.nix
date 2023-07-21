# Edit this configuration file to define what should be instlled on
# your system.  Help is available in the configuration.nix(5) man page
# and in the NixOS manual (accessible by running ‘nixos-help’).

{ lib, config, pkgs, ... }:

{
  imports =
    [
      ./hardware-configuration.nix
      ./laptop
      # ./secrets
    ];

  # set your time zone.
  time.timeZone = "America/Edmonton";

  # select internationalisation properties.
  i18n.defaultLocale = "en_CA.UTF-8";

  # Configure console keymap
  console.keyMap = "us";

  # This value determines the NixOS release from which the default
  # settings for stateful data, like file locations and database versions
  # on your system were taken. It‘s perfectly fine and recommended to leave
  # this value at the release version of the first install of this system.
  # Before changing this value read the documentation for this option
  # (e.g. man configuration.nix or on https://nixos.org/nixos/options.html).
  system.stateVersion = "22.11";

}
