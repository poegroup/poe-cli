/**
 * Module dependencies
 */

var Color = require('ui-kit-color/color');
import classnames from 'ui-kit-classnames';

/**
 * Define and expose `root`
 */

var root = module.exports = require('ui-kit-root')();

Object.defineProperties(root, {
  classnames: {value: classnames},
  Color: {value: Color},
  color: {get: () => root.get(require.resolve('ui-kit-color'))}
});

root.set(require.resolve('ui-kit-color'), Object.assign({}, require('ui-kit-color').defaults, {
  primary: Color('hsl(212, 100%, 17%)'),
  gray: Color('hsl(27, 8%, 33%)'),
}));
