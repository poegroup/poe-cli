__webpack_public_path__ = __build_path__;

/**
 * Module dependencies
 */

import Poe from 'poe-ui';
var routes = require('./routes.jade?force-load').render;
var Forms = require('form-store');
var Store = require('hyper-store');
var Client = require('hyper-client-wait1');
var Translate = require('onus-translate');
var cookie = require('component-cookie');

var API_URL = browser.env.API_URL;

/**
 * Instantiate dependencies
 */

var format = require('hyper-uri-format')(API_URL);
var client = new Client(API_URL, cookie('_access_token'));
var store = new Store(client);
var forms = new Forms(client);

Poe(document.body, {
  routes: routes,
  store: store,
  translate: new Translate(`.translations.{{project}}`),
  encodeParams: format.encodeParams,
  decodeParams: format.decodeParams,
  forms: forms,
  base: __app_path__ || '/'
});
