{
  description = "A very basic flake";

  inputs.utils.url = "github:numtide/flake-utils";

  outputs = { self, utils, nixpkgs }:
    utils.lib.eachDefaultSystem (system: rec {
      overlay = final: prev: {
        inherit (final.callPackages ./default.nix {
          inherit (final.llvmPackages_10) stdenv clang llvm;
        })
          crystal_0_31
          crystal_0_32
          crystal_0_33
          crystal_0_34
          crystal
          crystal2nix;
      };

      legacyPackages = import nixpkgs {
        inherit system;
        overlays = [ overlay ];
      };

      packages = {
        inherit (legacyPackages) crystal;
      };

      defaultPackage = legacyPackages.crystal;

      hydraJobs = packages;
    });

}

# {

#   packages.x86_64-darwin.crystal = nixpkgs.legacyPackages.x86_64-linux.hello;
#   packages.x86_64-darwin = {

#   defaultPackage.x86_64-linux = self.packages.x86_64-linux.hello;
