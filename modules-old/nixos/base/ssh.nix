{
  lib,
  config,
  ...
}: let
  cfg = config.modules.nixos-base.ssh;
in {
  options.modules.nixos-base.ssh = {
    enable = lib.mkEnableOption "Enable SSH access";
  };

  config = lib.mkIf cfg.enable {
    services.openssh = {
      enable = true;
      settings = {
        X11Forwarding = true;
      };
      openFirewall = true;
    };
    programs.ssh.startAgent = true;

    # Add terminfo database of all known terminals to the system profile.
    # https://github.com/NixOS/nixpkgs/blob/nixos-25.11/nixos/modules/config/terminfo.nix
    environment.enableAllTerminfo = true;
  };
}
