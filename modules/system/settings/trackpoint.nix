{
  flake.modules.nixos.trackpoint = {
    hardware.trackpoint = {
      enable = true;
      emulateWheel = true;
      sensitivity = 200;
      speed = 130;
      press_to_select = true;
    };
  };
}
