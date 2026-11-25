#!/bin/sh

set -e 
home-manager switch -b backup --impure --flake github:Millenium683/epita-config#epita
exec mango
