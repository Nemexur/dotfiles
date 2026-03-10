{
  flake.modules.nixos.virtd = {
    programs.virt-manager.enable = true;
    virtualisation.libvirtd.enable = true;
  };
  flake.modules.nixos.podman = {
    virtualisation.podman.enable = true;
    users.groups.podman = {};
  };
  flake.modules.nixos.docker = {
    virtualisation.docker.enable = true;
    users.groups.docker = {};
  };
}
