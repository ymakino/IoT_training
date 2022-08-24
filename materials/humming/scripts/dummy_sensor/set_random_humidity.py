#!/usr/bin/python

import random
import time
import subprocess

r = random.Random()

h = 50.0

while True:
  if h < 40:
    h += r.random()
  elif h > 60:
    h -= r.random()
  else:
    h += 2 * r.random() - 1.0
  subprocess.call(["echo", "./set_humidity.sh", str(int(h))])
  subprocess.call(["./set_humidity.sh", str(int(h))])

  time.sleep(1)
