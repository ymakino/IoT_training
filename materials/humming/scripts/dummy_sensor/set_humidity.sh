#!/bin/sh

DATAFILE=~/Desktop/scripts/dummy_sensor/data/humidity.txt

if [ $# -ne 1 ]; then
    echo "Usage: $0 H"
    exit 1
fi

printf "%02x" "$1" | sed -e 's/.*\(....\)$/\1/' | tee $DATAFILE
echo
