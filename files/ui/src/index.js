__webpack_public_path__ = __build_path__;
/**
 * Module dependencies
 */

import Poe from 'poe-ui';
import Forms from 'form-store';
import Store from 'hyper-store';
import Client from 'hyper-client-wait1';
import Format from 'hyper-uri-format';
import Translate from 'onus-translate';
import routes from 'onus-router/react?enhancers=basename!../web';

/**
 * Setup environment variables
 */

var API_URL = browser.env.API_URL;

/**
 * Instantiate dependencies
 */

var format = require('hyper-uri-format')(API_URL);
var client = new Client(API_URL);
var store = new Store(client);
var forms = new Forms(client);

module.exports = Poe(document.getElementById('app'), {
  router: {
    activeLinkClassName: 'is-active',
    basename: __app_path__,
    routes: routes
  },
  format: format,
  forms: new Forms(client),
  store: store,
  translate: new Translate('.translations.{{project}}')
});
