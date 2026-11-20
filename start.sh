#!usr/bin/env bash

set -e 
home-manager switch -b backup --flake github:NydeTvs/epita-config#epita
exec mango
