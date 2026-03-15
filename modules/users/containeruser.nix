{self, ...}: let
  username = "containeruser";
in {
  flake.modules = self.factory.user username false;
}
