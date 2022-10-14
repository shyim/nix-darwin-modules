{
  description = "A collection of darwin modules";

  inputs.nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";

  outputs = { self, nixpkgs }: {
    darwinModules = rec {
        modules = import ./modules;
        default = modules;
      };
  };
}