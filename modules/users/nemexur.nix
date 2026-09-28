{self, ...}: let
  username = "nemexur";
in {
  flake.modules = self.factory.user username true;
}
