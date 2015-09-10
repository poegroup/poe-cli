var changeCase = require('change-case');

var project = exec('pwd | xargs basename', {silent: true});

module.exports = {
  project: changeCase.snakeCase(project.output),
  project_cap: changeCase.pascal(project.output),
  description: 'a hypermedia api',
  PORT: '4000'
};
