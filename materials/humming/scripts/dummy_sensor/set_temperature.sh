#!/bin/sh

DATAFILE=~/Desktop/scripts/dummy_sensor/data/temperature.txt

if [ $# -ne 1 ]; then
    echo "Usage $0 T"
    exit 1
fi

T=`python -c "print(int($1 * 10))"`

printf "%04x" "$T" | sed -e 's/.*\(....\)$/\1/' | tee $DATAFILE
echo
