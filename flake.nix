{
  description = "A collection of darwin modules";

  outputs = { self, nixpkgs }: {
    darwinModules = rec {
        modules = import ./modules;
        default = modules;
      };
  };
}