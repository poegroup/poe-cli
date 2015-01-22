/**
 * Module dependencies
 */

var rc = require('rc');
var fs = require('fs');
var ask = require('./utils').ask;

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
    return ask(prop + ': ', function(answer) {
      args[prop] = answer;
      return configure(fields, fn, true, args);
    });
  }

  delete args['_'];

  fn(args, modified);
}
