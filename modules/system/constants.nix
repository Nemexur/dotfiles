{
  flake.modules.generic.systemConstants = {lib, ...}: {
    options.systemConstants = lib.mkOption {
      type = lib.types.attrsOf lib.types.unspecified;
      default = {};
      description = "Default Constants";
    };

    config.systemConstants = {
      name = "nemexur";
      email = "alex.milogradsky@gmail.com";
      userFullName = "Aleksandr Milogradskiy";
      stateVersion = "26.05";
      darwinStateVersion = 7;
    };
  };
}
