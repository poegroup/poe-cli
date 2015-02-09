module.exports = {
  project: pwd(),
  username: process.env.USER,
  email: exec('npm config get email', {silent: true}),
  fullname: exec('npm config get init-author-name', {silent: true}),
  description: 'a hypermedia api',
  PORT: '5000'
}
