#!/bin/sh

NUM=17

if [ \! -d /sys/class/gpio/gpio${NUM} ]; then
  echo ${NUM} > /sys/class/gpio/export
  sleep 0.5
  echo out > /sys/class/gpio/gpio${NUM}/direction
fi

DATA="$3"

if [ ${DATA} = '30' ]; then
  echo 0 > /sys/class/gpio/gpio${NUM}/value
elif [ ${DATA} = '31' ]; then
  echo 1 > /sys/class/gpio/gpio${NUM}/value
fi
