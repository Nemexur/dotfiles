{
  inputs,
  self,
  ...
}: {
  flake.agenix-rekey = inputs.agenix-rekey.configure {
    userFlake = self;
    inherit (self) nixosConfigurations darwinConfigurations homeConfigurations;
  };
}
