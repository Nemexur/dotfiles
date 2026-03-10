{
  flake.modules.nixos.ssh = {
    services.openssh = {
      enable = true;
      settings.X11Forwarding = true;
      openFirewall = true;
    };
    programs.ssh.startAgent = true;

    # Add terminfo database of all known terminals to the system profile.
    # https://github.com/NixOS/nixpkgs/blob/nixos-25.11/nixos/modules/config/terminfo.nix
    environment.enableAllTerminfo = true;
  };

  flake.modules.darwin.ssh = {
    services.openssh.enable = false;
  };
}
