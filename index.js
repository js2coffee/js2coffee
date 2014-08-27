var esprima = require('esprima');

module.exports = function (source, options) {
  console.log(esprima.parse(source));
};
