{
  description = "A collection of darwin modules";

  outputs = { self, nixpkgs }: {
    imports = [
        ./modules
    ];
  };
}