#!/usr/bin/python

import random
import time
import subprocess

r = random.Random()

t = 25.0

while True:
  if t < 20:
    t += r.random() * 0.1
  elif t > 30:
    t -= r.random() * 0.1
  else:
    t += 0.2 * r.random() - 0.1
  subprocess.call(["echo", "./set_temperature.sh", str(t)])
  subprocess.call(["./set_temperature.sh", str(t)])

  time.sleep(1)
