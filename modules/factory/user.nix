{self, ...}: let
  stateVersion = "25.11";
in {
  config.flake.factory.user = username: isAdmin: {
    nixos."${username}" = {
      lib,
      pkgs,
      ...
    }: {
      users.groups."${username}" = {};
      users.users."${username}" = {
        isNormalUser = true;
        home = "/home/${username}";
        extraGroups =
          ["${username}" "users"]
          ++ (lib.optionals isAdmin [
            "wheel"
          ]);
        shell = pkgs.zsh;
      };
      programs.zsh.enable = true;
      environment.shells = with pkgs; [bashInteractive zsh];

      home-manager.users."${username}" = {
        imports = [
          self.modules.homeManager."${username}"
        ];
        home.homeDirectory = "/home/${username}";
      };
    };

    darwin."${username}" = {
      lib,
      pkgs,
      ...
    }: {
      users.users."${username}" = {
        home = "/Users/${username}";
        shell = pkgs.zsh;
      };
      programs.zsh.enable = true;
      environment.shells = with pkgs; [bashInteractive zsh];

      home-manager.users."${username}" = {
        imports = [
          self.modules.homeManager."${username}"
        ];
        home.homeDirectory = "/Users/${username}";
      };

      system.primaryUser = lib.mkIf isAdmin "${username}";
    };

    homeManager."${username}" = {
      home = {
        inherit username stateVersion;
      };
    };
  };
}
