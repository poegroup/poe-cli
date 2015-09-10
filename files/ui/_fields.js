module.exports = {
  project: exec('pwd | xargs basename', {silent: true}),
  username: process.env.USER,
  email: exec('npm config get email', {silent: true}),
  fullname: exec('npm config get init-author-name', {silent: true}),
  description: 'a webapp',
  PORT: '5000',
  API_URL: 'ws://localhost:4000'
};
