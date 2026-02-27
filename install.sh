#!/bin/bash
set -e

echo "== Removing old webkit (libsoup2 version) if present =="
sudo pacman -Rns --noconfirm webkit2gtk || true

echo "== Installing required dependencies for surf (webkit 4.1 stack) =="
sudo pacman -S --needed \
    base-devel \
    pkgconf \
    webkit2gtk-4.1 \
    gtk3 \
    glib2 \
    gcr \
    libsoup3 \
    xorgproto

echo "== Cleaning old surf install (if exists) =="
sudo rm -rf /usr/local/lib/surf
sudo rm -f /usr/local/bin/surf

echo "== Cleaning build directory =="
make clean || true

echo "== Building surf =="
make

echo "== Installing surf =="
sudo make install

echo "== Done. Verifying linkage =="
ldd /usr/local/bin/surf | grep soup || true

echo ""
echo "If you only see libsoup-3.0.so, you're good."
