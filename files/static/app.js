/**
 * Module dependencies
 */

var stack = require('poe-static');

/**
 * Expose the app
 */

var app = module.exports = stack();
var builder = app.builder;

builder.addES6({
  test: /\.(js)$/,
  include: /ui-kit/
});
