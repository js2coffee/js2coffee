// Example demonstrating ES.Next JavaScript that can now be
// transpiled to CoffeeScript via Babel preprocessing
//
// NOTE: Use via Node.js API for full Babel support. The browser
// bundle has limited Babel support due to bundle size constraints.

// ES2015 (ES6) Features
const greeting = 'Hello';
let counter = 0;

const greet = (name) => `${greeting}, ${name}!`;

class Person {
  constructor(name, age) {
    this.name = name;
    this.age = age;
  }

  introduce() {
    return `I'm ${this.name}, ${this.age} years old`;
  }

  static create(name, age) {
    return new Person(name, age);
  }
}

const numbers = [1, 2, 3, 4, 5];
const doubled = numbers.map(n => n * 2);
const evens = numbers.filter(n => n % 2 === 0);

// Spread operator
const merged = {...{a: 1}, ...{b: 2}};

// For best results, use the Node.js API:
//
//   const js2coffee = require('js2coffee');
//   const result = js2coffee.build(source);
//   console.log(result.code);
