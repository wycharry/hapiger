bb = require 'bluebird'
program = require('commander');
chalk = require 'chalk'

HapiGER = require('./lib/hapi_server.coffee')

cli = ->

  program
    .version('0.0.1')
    .usage('[options]')
    .description('start a hapiger server')
    .option('-e, --esm <esm>', 'select Event Store Manager [memory, pg, rethinkdb]', 'memory')
    .option('-u, --esmurl <options>', 'The url location of the ESM')
    .option('-v, --verbose', "More Output", false)
    .parse(process.argv);

  verbose = program.verbose
  

  hapiger = new HapiGER(
  {
    esm: program.esm
    esmurl: program.esmurl
  })
  hapiger.initialize()
  .then( -> hapiger.start())
  .catch((e) -> console.log "ERROR"; console.log e.stack)


module.exports = cli