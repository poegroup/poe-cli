
/**
 * Module dependencies.
 */

var exec = require('child_process').exec;
var fs = require('fs');
var path = require('path');
var should = require('should');

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

