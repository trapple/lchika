"use strict";

const gpio = require("gpio");

const channel = 4;
const interval = 50;
let setId;

const gpio4 = gpio.export(channel, {
  direction: "out",
  ready(){
    setId = setInterval(() => {
      this.set();
      setTimeout(() => {
        this.reset(); 
      }, interval);
    }, interval * 2);
  }
});

process.on("SIGINT", () => {
  gpio4.reset();
  clearInterval(setId);
  setTimeout(() => {
    gpio4.unexport();
  }, interval + 1);
  console.log("\nBye!!");
});
