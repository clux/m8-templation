path    = require 'path'
fs      = require 'fs'
fsx     = require 'fsx'
version = require './domain/version'


Parser = (@template_dir, @ext='.html', @key='versions', @domain='template') ->

Parser::data = ->
  vobj = {}
  for file in fsx.readDirSync(@template_dir).files when path.extname(file) is @ext
    v = version.read(fs.readFileSync(file))
    throw new Error("path: #{file} does not start with a valid version number") if !v
    vobj[path.basename(file).split(@ext)[0]] = v
  JSON.stringify(vobj)

Parser::domains = ->
  [@domain, __dirname+'/domain/'] # make tinysemver requireable as template::version on the client



module.exports = Parser

if module is require.main
  console.log (new Parser('/home/clux/repos/deathmatchjs/public/tmpl/')).data()
