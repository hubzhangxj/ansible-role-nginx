#!/bin/sh
set -x
TOPDIR=`pwd`

NGINX=nginx-1.11.4.tar.gz
NGINX_DIR=${NGINX%\.*}
NGINX_DIR=${NGINX_DIR%\.*}
NGINX_PATH=$TOPDIR/install

nginx_is_install()
{
	test -f $NGINX_PATH/sbin/nginx
}

if nginx_is_install; then
	echo "$NGINX is already installed"
	exit 0
fi

pushd build/$NGINX_DIR
./configure  --with-http_ssl_module --prefix=$TOPDIR/install
make && make install
popd

if nginx_is_install; then
	if [ ! $(grep -q "NGINX_PATH" scripts/profile) ]; then
		echo "export NGINX_PATH=$NGINX_PATH" >> scripts/profile
		echo 'export PATH=$PATH:$NGINX_PATH/sbin' >> scripts/profile
	fi

	ulimit -n 102400

	echo "$NGINX install successfully"
	exit 0
else
	echo "Failed to install $NGINX"
	exit 1
fi
