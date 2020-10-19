{
  description = "A very basic flake";

  inputs.utils.url = "github:numtide/flake-utils";

  outputs = { self, utils, nixpkgs }:
    utils.lib.eachSystem [ "x86_64-linux" "x86_64-darwin" ] (system: rec {
      overlay = final: prev: {
        inherit (final.callPackages ./default.nix {
          inherit (final.llvmPackages_10) stdenv clang llvm;
        })
          crystal_0_31
          crystal_0_32
          crystal_0_33
          crystal_0_34
          crystal_0_35
          crystal
          crystal2nix;
      };

      legacyPackages = import nixpkgs {
        inherit system;
        overlays = [ overlay ];
      };

      packages = {
        inherit (legacyPackages)
          crystal_0_31
          crystal_0_32
          crystal_0_33
          crystal_0_34
          crystal_0_35
          crystal
          crystal2nix;
      };

      defaultPackage = legacyPackages.crystal;

      hydraJobs = packages;
    });
}
