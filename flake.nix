{
  description = "High performance Node.js/PostgreSQL job queue.";

  inputs = {
    nixpkgs.url = "nixpkgs/nixos-21.05";
    utils.url = "github:numtide/flake-utils";
    flake-compat.url = "github:edolstra/flake-compat";
    flake-compat.flake = false;
  };

  outputs = { self, nixpkgs, utils, ... }@inputs: {

    overlay = final: prev:
      let
        pkgs = final;
      in
      {
        graphile-worker = (import ./composition.nix {
          inherit pkgs;
        }).nodeDependencies;
      };

  } // utils.lib.eachDefaultSystem (system:
    let
      pkgs = import nixpkgs {
        inherit system;
        overlays = [ self.overlay ];
      };
    in
    {

      defaultPackage = pkgs.graphile-worker;

      devShell = pkgs.mkShell {
        buildInputs = [
          pkgs.nodePackages.node2nix
          pkgs.nixpkgs-fmt
        ];
      };
    });
}
