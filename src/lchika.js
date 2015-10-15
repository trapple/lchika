"use strict";

const gpio = require("gpio");

let isRunning = 1;
let setId;

const gpio4 = gpio.export(4, {
  direction: "out",
  ready(){
    let value = 1;
    setId = setInterval(() => {
      this.set(value);
      value++;
      value %= 2;
    }, 50);
  }
});

process.on("SIGINT", () => {
  gpio4.set(0);
  clearInterval(setId);
  gpio4.unexport();
  console.log("\nBye!!");
});
