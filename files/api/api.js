/**
 * Module dependencies
 */

var api = module.exports = require('simple-stack-common')({
  base: {
    host: 'x-orig-host',
    path: 'x-orig-path',
    port: 'x-orig-port',
    proto: 'x-orig-proto'
  }
});

/**
 * Decorate JSON response with `href` and `root`
 */

api.useBefore('router', require('hyper-decorate'));

api.get('/', function(req, res, next) {
  res.json({
    app: {
      name: '{{project}}',
      description: '{{description}}',
      author: {href: req.base + '/author'}
    }
  });
});

api.get('/author', function(req, res, next) {
  res.json({
    name: '{{fullname}}',
    github: 'https://github.com/{{username}}',
    email: '{{email}}'
  })
});
