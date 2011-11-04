path    = require 'path'
fs      = require 'fs'
fsx     = require 'fsx'
version = require './domain/version'


Parser = (@template_dir, @o={}) ->
  throw new Error("need a valid template directory #{@template_dir}") if !path.existsSync(@template_dir)
  @o.ext    or= '.html'
  @o.domain or= 'template'
  @o.key    or= 'versions'
  return

Parser::data = ->
  vobj = {}
  for file in fsx.readDirSync(@template_dir).files when path.extname(file) is @o.ext
    v = version.read(fs.readFileSync(file))
    throw new Error("path: #{file} does not start with a valid version number") if !v
    vobj[path.basename(file).split(@o.ext)[0]] = v
  [@o.key, JSON.stringify(vobj)]

Parser::domains = ->
  [@o.domain, __dirname+'/domain/'] # make tinysemver requireable as template::version on the client



module.exports = Parser

if module is require.main
  console.log (new Parser('/home/clux/repos/deathmatchjs/public/tmpl/')).data()
