{
  description = "The Crystal Programming Language";

  inputs.utils.url = "github:kreisys/flake-utils";

  outputs = { self, utils, nixpkgs }:
  utils.lib.simpleFlake {
    inherit nixpkgs;
    systems = [ "x86_64-linux" "x86_64-darwin" ];
    overlay = final: prev: {
      inherit (final.callPackages ./pkgs {
        inherit (final.llvmPackages_10) stdenv clang llvm;
      })
      crystal
      crystal2nix
      binaryCrystal_0_31
      binaryCrystal_0_35
      crystal_0_31
      crystal_0_33
      crystal_0_34
      crystal_0_35
      ;
    };

    packages = {
        crystal
      , crystal2nix
      , binaryCrystal_0_31
      , binaryCrystal_0_35
      , crystal_0_31
      , crystal_0_33
      , crystal_0_34
      , crystal_0_35
    }@packages: packages // {
      defaultPackage = crystal;
    };
  };
}
