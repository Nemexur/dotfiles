{inputs, ...}: {
  #NixOS
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
  flake.modules.nixos.docker = {pkgs, ...}: {
    imports = [inputs.self.modules.nixos.containers];

    virtualisation.docker = {
      enable = true;
      package = pkgs.docker.override {
        buildxSupport = true;
        composeSupport = true;
      };
    };
    users.groups.docker = {};
  };

  # Darwin
  flake.modules.darwin.containers = {pkgs, ...}: {
    environment.systemPackages = with pkgs; [
      lazydocker
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
      (docker.override {
        buildxSupport = true;
        composeSupport = true;
      })
    ];
  };
}
