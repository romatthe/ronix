{ config, pkgs, inputs, ... }:

{
  virtualisation.podman = {
    enable = true;
    dockerCompat = true;
  };

  virtualisation.oci-containers.backend = "podman";
  virtualisation.libvirtd.enable = true;
}
