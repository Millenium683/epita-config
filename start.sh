#!/bin/sh

set -e 
home-manager switch -b "backup-$(date +%s)" --impure --flake github:Millenium683/epita-config#epita
exec mango
