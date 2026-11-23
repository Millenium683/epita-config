#!usr/bin/env bash

set -e 
home-manager switch -b backup --impure --flake github:NydeTvs/epita-config#epita
exec mango
