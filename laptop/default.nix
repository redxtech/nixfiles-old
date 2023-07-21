{ config, ... }:

{
  networking.hostName = "laptop";

  imports =
    [
      ../generic
      ./boot.nix
      # ./nvidia_prime.nix
      ./services.nix
    ];
}
