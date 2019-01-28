#!/bin/sh

set -x

DEV=ens2np0s3
OBJ=xdp3.o

load() {
	ip link set dev $DEV xdp obj $OBJ verb
}

unload() {
	ip link set dev $DEV xdp off
}


case "$1" in
	load)
		set -x
		load
		;;
	unload)
		set -x
		unload
		;;
*)
	echo "usage:30 {load|unload}"
esac
