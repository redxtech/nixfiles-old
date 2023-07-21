{ config, pkgs, ... }:

{
  # bootloader.
  boot = {
    # kernel version
    kernelPackages = pkgs.linuxPackages_zen;
    #kernelPackages = pkgs.linuxKernel.kernels.linux_zen;

    plymouth.enable = true;

    loader = {
      systemd-boot.enable = true;
      efi = {
        canTouchEfiVariables = true;
        efiSysMountPoint = "/boot/efi";
      };
    };
    initrd = {
      systemd.enable = true;

      # setup keyfile
      secrets = {
        "/crypto_keyfile.bin" = null;
      };
      # enable swap on luks
      luks.devices = {
        "luks-56051129-eb6d-4e41-b9e3-f4a6f2a35d0a" = {
          device = "/dev/disk/by-uuid/56051129-eb6d-4e41-b9e3-f4a6f2a35d0a";
          keyFile = "/crypto_keyfile.bin";
        };
      };
    };
  };
}
