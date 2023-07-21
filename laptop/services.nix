{ config, ... }:

{
  # List services that you want to enable:

  # Waydroid
  # virtualisation = {
  #   waydroid.enable = true;
  #   lxd.enable = true;
  # };

  # Enable touchegg
  services.touchegg.enable = true;
}
