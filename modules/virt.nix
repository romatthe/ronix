{ config, pkgs, inputs, ... }:

{
  virtualisation.podman = {
    enable = true;
    dockerCompat = true;
  };

  virtualisation.oci-container.backend = "podman";
  virtualisation.libvirtd.enable = true;
}
