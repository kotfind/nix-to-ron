{
  inputs = {
    nixpkgs.url = "nixpkgs/nixpkgs-unstable";
    flake-utils.url = "github:numtide/flake-utils";
  };

  outputs = {
    nixpkgs,
    flake-utils,
    ...
  }:
    flake-utils.lib.eachDefaultSystem (system: let
      # general
      pkgs = import nixpkgs {inherit system;};

      # lib
      my-lib = import ./my-lib.nix {inherit pkgs;};

      # testing
      test-lib = import ./test-lib.nix {inherit pkgs;};
      tests = import ./tests.nix {inherit pkgs my-lib test-lib;};
      inherit (test-lib) runTests writeReportOrThrow;
    in {
      lib = my-lib;
      checks = {
        tests = writeReportOrThrow (runTests tests);
      };
    });
}
