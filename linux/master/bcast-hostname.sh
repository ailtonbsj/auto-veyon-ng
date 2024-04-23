#!/bin/bash

broadcast=$(ifconfig | grep broadcast | cut -d' ' -f16)

while true; do
    cat /etc/hostname | nc -w1 -ub $broadcast 12001
    sleep 3
done
