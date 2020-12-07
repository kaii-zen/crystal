{
  description = "The Crystal Programming Language";

  inputs.utils.url = "github:numtide/flake-utils";

  outputs = { self, utils, nixpkgs }:
    let
      name = "crystal-flake";
      systems = [ "x86_64-darwin" "x86_64-linux" ];
      overlay = final: prev: {
        crystal-flake = final.callPackages ./pkgs {
          inherit (final.llvmPackages_10) stdenv clang llvm;
        };
      };

      simpleFlake = utils.lib.simpleFlake {
        inherit name systems overlay self nixpkgs;
      };
    in
    simpleFlake // {
      inherit overlay;

      hydraJobs = self.packages;
    };
}
