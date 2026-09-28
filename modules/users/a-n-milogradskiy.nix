{self, ...}: let
  username = "a.n.milogradskiy";
in {
  flake.modules = self.factory.user username true;
}
