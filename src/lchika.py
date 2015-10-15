import RPi.GPIO as GPIO
import time
import signal
import sys

channel = 4
GPIO.setmode(GPIO.BCM)
GPIO.setup(channel, GPIO.OUT)
is_running = True

def sigint_handler(signo, frame):
    is_running = False
    GPIO.output(channel, False)
    GPIO.cleanup()
    print "\nBye!!"
    sys.exit(0)

signal.signal(signal.SIGINT, sigint_handler)

while is_running == True:
    GPIO.output(channel, True)
    time.sleep(0.05)
    GPIO.output(channel, False)
    time.sleep(0.05)
