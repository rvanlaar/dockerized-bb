#! /bin/sh

# Be careful, this version has been chosen by open2x
# 1.2.13 has been proposed but never switched on
SDL_VERSION=1.2.11

PACKAGE_DIR=$(CDPATH= cd -- "$(dirname -- "$0")" && pwd)
HELPERS_DIR=$PACKAGE_DIR/../..
. $HELPERS_DIR/functions.sh

do_make_bdir

# GPG key of Sam Lantinga
gpg --keyserver hkps://hkps.pool.sks-keyservers.net --recv-keys 0xA7763BE6
do_http_fetch SDL "https://www.libsdl.org/release/SDL-${SDL_VERSION}.tar.gz" 'tar xzf' \
	"gpgurl:http://www.libsdl.org/release/SDL-${SDL_VERSION}.tar.gz.sig"
rm -Rf $HOME/.gnupg

./autogen.sh

do_configure \
	--enable-video \
	--enable-video-gp2x \
	--disable-video-x11 \
	--disable-video-directfb

do_make

do_make install

do_clean_bdir
