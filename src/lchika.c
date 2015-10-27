#include <wiringPi.h>

// Define GPIO17
#define GPIO17 17

// Main function
int main(void) {
  int i;

  if (wiringPiSetupGpio() == -1) {
    return 1;
  }

  pinMode(GPIO17, OUTPUT);

  // Repeat LED blinking 10 times
  for (i = 0; i < 10; i++) {
    digitalWrite(GPIO17, 0);
    delay(950);
    digitalWrite(GPIO17, 1);
    delay(50);
  }

  // Turn off LED
  digitalWrite(GPIO17, 0);

  return 0;
}
