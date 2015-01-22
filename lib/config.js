/**
 * Module dependencies
 */

var rc = require('rc');
var fs = require('fs');
var ask = require('./utils').ask;
var debug = require('debug')('poe:config.js');

/**
 * Define minimum required fields
 */

var baseFields = [
  'username',
  'email',
  'fullname'
];

exports = module.exports = function (fields, fn) {
  // we don't want to mutate these
  fields = fields || baseFields;
  var cloned = fields.slice(0);
  return configure(cloned, fn);
};

exports.load = load;
function load() {
  if (process.env.POE_DISABLE_CONFIG) return {};
  return rc('poe', {});
}

exports.configure = configure;
function configure(fields, fn, modified, args) {
  args = args || load();
  
  if (typeof fields === 'function') {
    fn = fields;
    fields = baseFields;
  }

  while (fields.length) {
    var prop = fields[0];
    if (args[prop]) {
      fields.shift();
      continue;
    }
    return ask(prop.toLowerCase().split('_').join(' ') + ': ', function(answer) {
      args[prop] = answer;
      return configure(fields, fn, true, args);
    });
  }

  if (args['_']) delete args['_'];

  fn(args, modified);
}
