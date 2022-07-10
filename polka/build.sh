#!/bin/sh

echo "Building lua pam bindings..."
git clone https://github.com/RMTT/lua-pam.git /tmp/lua-pam
cmake /tmp/lua-pam -B /tmp/lua-pam/build
make -C /tmp/lua-pam/build
mv /tmp/lua-pam/build/liblua_pam.so awesome/module/
rm -rf /tmp/lua-pam

echo

echo "Building lua pulse bindings..."
git clone https://github.com/sclu1034/lua-libpulse-glib.git /tmp/lua-libpulse-glib
make -C /tmp/lua-libpulse-glib
mv /tmp/lua-libpulse-glib/out/lua_libpulse_glib.so awesome/module
rm -rf /tmp/lua-libpulse-glib

