{
  flake.modules.nixos.luffy = {
    lib,
    config,
    ...
  }: {
    networking.firewall.enable = false;

    # PAM Order
    security.pam.services = let
      handle = service: {
        "${service}" = {
          rules.auth.fprintd = {
            order = config.security.pam.services."${service}".rules.auth.unix.order + 50;
          };
        };
      };
    in
      lib.mkMerge [
        (handle "greetd")
        (handle "hyprlock")
      ];
  };
}
