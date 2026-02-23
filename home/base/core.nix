# {
#   pkgs,
#   pkgs-custom,
#   ...
# } @ inputs: let
#   customPackages = map (p: p inputs) (builtins.attrValues pkgs-custom);
# in {
#   home.packages = with pkgs;
#     customPackages
#     ++ [
#       cowsay
#     ];
# }
