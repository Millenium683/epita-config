#!/bin/sh

set -e 
home-manager switch -b "backup-$(date +%s)" --impure --flake "github:Millenium683/epita-config?ref=feat/sans-kitty#epita"
exec mango
