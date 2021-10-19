#! /bin/sh

rm -f ./node-env.nix
node2nix -i package.json -o node-packages.nix -c composition.nix -14
