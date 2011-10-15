
/**
 * Module dependencies.
 */

var express = require('../../lib/express');

var app = express.createServer();

require('./mvc').boot(app);

app.listen(3000);
console.log('Express app started on port 3000');