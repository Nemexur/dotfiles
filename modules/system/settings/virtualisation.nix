{inputs, ...}: {
  flake.modules.nixos.containers = {pkgs, ...}: {
    virtualisation.containers.enable = true;
    environment.systemPackages = with pkgs; [
      lazydocker
    ];
  };
  flake.modules.nixos.virtd = {
    programs.virt-manager.enable = true;
    virtualisation.libvirtd.enable = true;
  };
  flake.modules.nixos.podman = {
    imports = [inputs.self.modules.nixos.containers];

    virtualisation.podman = {
      enable = true;
      dockerCompat = true;
      dockerSocket.enable = true;
      defaultNetwork.settings.dns_enabled = true;
    };
    users.groups.podman = {};
  };
  flake.modules.nixos.docker = {
    imports = [inputs.self.modules.nixos.containers];

    virtualisation.docker.enable = true;
    users.groups.docker = {};
  };

  flake.modules.darwin.containers = {pkgs, ...}: {
    environment.systemPackages = with pkgs; [
      lazydocker
      orbstack
    ];
  };

  flake.modules.darwin.podman = {pkgs, ...}: {
    imports = [inputs.self.modules.darwin.containers];

    environment.systemPackages = with pkgs; [
      podman
      podman-compose
    ];
  };
  flake.modules.darwin.docker = {pkgs, ...}: {
    imports = [inputs.self.modules.darwin.containers];

    environment.systemPackages = with pkgs; [
      docker
      docker-compose
    ];
  };
}
