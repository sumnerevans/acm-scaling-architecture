{
  description = "A very basic flake";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs";
    flake-utils.url = "github:numtide/flake-utils";
  };

  outputs = { self, nixpkgs, flake-utils }:
    (flake-utils.lib.eachDefaultSystem
      (system:
        let
          pkgs = import nixpkgs { system = system; };
          texlive = pkgs.texlive.combined.scheme-full;
        in
        {
          devShell = pkgs.mkShell {
            name = "texlive";
            buildInputs = with pkgs; [
              gnumake
              texlive
              python39Packages.pygments
            ];
          };
        }
      ));
}
