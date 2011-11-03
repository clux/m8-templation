path    = require 'path'
fs      = require 'fs'
fsx     = require 'fsx'
ver     = require './domain/ver'

exp = (template_dir, ext='.html') ->
  m8 = {}
  m8.domains = {'m8-tmpl': __dirname + '/domain/'} # make tinysemver requireable as m8-tmpl::ver on the client
  m8.data = ->
    vobj = {}
    for file in fsx.readDirSync(template_dir).files when path.extname(file) is ext
      v = ver.read(fs.readFileSync(file))
      throw new Error("path: #{file} does not start with a valid version number") if !v
      vobj[path.basename(file).split(ext)[0]] = v
    JSON.stringify(vobj)
  m8

module.exports = exp
