
/**
 * Module dependencies.
 */

process.stdout.write('\u001B[2J');

var exec = require('child_process').exec;
var fs = require('fs-extra');
var path = require('path');
var should = require('should');
var expect = require('suppose');
var spawn = require('child_process').spawn;
var stream = require('stream');

describe('poe', function(){
  it('should output help', function(done){
    exec('bin/poe', function(err, stdout){
      if (err) return done(err);
      stdout.should.containDeep('poe');
      stdout.should.containDeep('poe <command> [options]');
      stdout.should.containDeep('--help');
      stdout.should.containDeep('Commands:');
      stdout.should.containDeep('create');
      done();
    });
  });
});

function proc(cmd, readable, writable) {
  readable = readable || 'inherit';
  writable = writable || 'inherit';
  var args = cmd.split(' ');
  var bin = __dirname + '/../bin/' + args.shift();
  var _proc = spawn(bin, args, { stdin: readable, stdout: writable /* , customFds: [0,1,2] */ });
  return _proc;
}

describe('poe create', function(){

  process.env.POE_DISABLE_CONFIG = true;

  beforeEach(function(done) {
    fs.remove('test/tmp', function(err) {
      if (err) return console.error(err);
      fs.mkdirp('test/tmp', function(err) {
        if (err) return console.error(err);
        // console.log('cleaned test/tmp');
        process.chdir('test/tmp');
        done();
      })
    });
  });

  afterEach(function() {
    // console.log('process.cwd(): ', process.cwd());
    process.chdir(__dirname + '/..');
  })

  // it('should output error and display help', function(done){
  //   expect('../../bin/poe', ['create'])
  //     .on('project: ').respond('foobar\n')
  //     .error(function(err) {
  //       err.should.be.an.Error;
  //       err.message.should.containDeep('You must provide a `type`.')
  //       err.message.should.containDeep('Usage: poe create')
  //     })
  //     .end(function(code) {
  //       code.should.be.greaterThan(0);
  //       done();
  //     });
  // });

  // it('should output error and display help', function(done){
  //   var exe = ('../../bin/poe-create', ['api'])
  //     .on('project: ').respond('foobar\n')
  //     .error(function(err) {
  //       // console.log('err: ', err);
  //     })
  //     .end(function(code) {
  //       code.should.eql(0);
  //       done();
  //     });
  // });

});

