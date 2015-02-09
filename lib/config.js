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
  var defaults = {};
  if (!Array.isArray(fields)) {
    fields = Object.keys(fields).map(function(key, i, ctx) {
      var def = fields[ctx[i]] || ''
      defaults[key] = def;
      return key;
    });
  }
  var cloned = fields.slice(0);
  return configure(cloned, defaults, fn);
};

exports.load = load;
function load() {
  if (process.env.POE_DISABLE_CONFIG) return {};
  return rc('poe', {});
}

exports.configure = configure;
function configure(fields, defaults, fn, modified, args) {
  args = args || load();

  if (typeof fields === 'function') {
    fn = fields;
    fields = baseFields;
  }

  var def;
  while (fields.length) {
    var prop = fields[0];
    if (args[prop]) {
      fields.shift();
      continue;
    }
    return ask(createAsk(prop), function(answer) {
      var def = defaults[prop];
      if (!answer.length && def) {
        answer = def;
        fields.shift();
      }
      args[prop] = answer;
      return configure(fields, defaults, fn, true, args);
    });
  }

  if (args['_']) delete args['_'];

  fn(args, modified);

  function createAsk(prop) {
    return prop.toLowerCase().split('_').join(' ') + (defaults[prop] ? ' (' + defaults[prop] + '): ' : ': ');
  }
}
