/**
 * Module dependencies
 */

import Color from 'ui-kit/utils/color.js';
import * as branding from 'ui-kit/utils/branding.js';

exports = module.exports = branding;

// colors

var color = exports.color;

for (var key in color)
  color[key] = new Color(color[key]);

export var color = color;
