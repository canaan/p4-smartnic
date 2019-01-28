#!/bin/sh

set -x

ETH0=ens2np0s0
ETH1=ens2np0s1
ETH2=ens2np0s2
ETH3=ens2np0s3
CORE=3
QUEUE=1024

for i in $ETH0 $ETH1 $ETH2 $ETH3 
do
	numactl -m 0 -N 0 ethtool -L $i combined $CORE
	numactl -m 0 -N 0 ethtool -G $i rx $QUEUE tx $QUEUE 
	./nfp-drv-kmods/tools/set_irq_affinity.sh $i
done
