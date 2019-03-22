#!/bin/sh

#Backup original
cp config.h config.h.bak
cp config_desktop.h config.h

# Build
rm -rf src
updpkgsums
makepkg -sif

# Restore original
mv config.h.bak config.h

# Restore original checksums
updpkgsums
