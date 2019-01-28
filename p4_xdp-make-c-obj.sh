#!/bin/sh

set -x

XDPFILE="diffserv-change.p4"
CFILE="diffserv-change.c"
OBJ="diffserv-change.o"

sudo p4c-xdp --target xdp \
        -o /tmp/$CFILE /home/y-kanaumi/p4c/extensions/p4c-xdp/tests/$XDPFILE

sudo clang -Wno-unused-value -Wno-pointer-sign \
        -Wno-compare-distinct-pointer-types \
        -Wno-gnu-variable-sized-type-not-at-end \
        -Wno-tautological-compare \
      -O2 -emit-llvm -g \
       -I/home/y-kanaumi/p4c/p4include \
       -I/home/y-kanaumi/p4c/backends/ebpf/runtime/ \
       -I/home/y-kanaumi/p4c/extensions/p4c-xdp/tests \
       -c /tmp/$CFILE  -o -| llc -march=bpf -filetype=obj -o /tmp/$OBJ
